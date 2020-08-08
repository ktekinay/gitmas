#tag Class
Protected Class Repo
	#tag Method, Flags = &h21
		Private Sub CheckStatusTimer_Action(sender As Timer)
		  if GitFolder is nil then
		    sender.RunMode = Timer.RunModes.Off
		  else
		    sender.RunMode = Timer.RunModes.Multiple
		    Refresh
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Git_MTC.Init
		  
		  CheckStatusTimer = new Timer
		  AddHandler CheckStatusTimer.Action, WeakAddressOf CheckStatusTimer_Action
		  CheckStatusTimer.Period = 5 * 1000
		  CheckStatusTimer.RunMode = Timer.RunModes.Off
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(folder As FolderItem)
		  Constructor()
		  GitFolder = folder
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Destructor()
		  if CheckStatusTimer isa object then
		    CheckStatusTimer.RunMode = Timer.RunModes.Off
		    RemoveHandler CheckStatusTimer.Action, WeakAddressOf CheckStatusTimer_Action
		    CheckStatusTimer = nil
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ExtractEOL(s As String)
		  if EOL = "" then
		    const kLF as string = &u0A
		    const kCR as string = &u0D
		    const kCRLF as string = kCR + kLF
		    
		    if s.IndexOf( kCRLF ) <> -1 then
		      EOL = kCRLF
		    elseif s.IndexOf( kLF ) <> -1 then
		      EOL = kLF
		    elseif s.IndexOf( kCR ) <> -1 then
		      EOL = kCR
		    end if
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GetDiffs()
		  var diffString as string = GitIt( GitFolder, kGitDiff )
		  System.DebugLog diffString
		  
		  ExtractEOL( diffString )
		  diffString = diffString.ReplaceLineEndings( &u0A )
		  diffString = &u0A + diffString
		  
		  var diffs() as DiffFile
		  var parts() as string = diffString.Split( &u0A + "diff --git " )
		  
		  //
		  // Remove the first part
		  //
		  parts.RemoveRowAt( 0 )
		  
		  for each part as string in parts
		    diffs.AddRow new DiffFile( self, part )
		  next
		  
		  self.Diffs.RemoveAllRows
		  for each df as DiffFile in diffs
		    self.Diffs.AddRow( df )
		  next
		  
		  self.Diffs = diffs
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function LineSorterByFileAndPosition(l1 As Git_MTC.DiffLine, l2 As Git_MTC.DiffLine) As Integer
		  var f1 as FolderItem = l1.Parent.Parent.ToFile
		  var f2 as FolderItem = l2.Parent.Parent.ToFile
		  
		  var result as integer = f1.NativePath.Compare( f2.NativePath, ComparisonOptions.CaseSensitive )
		  
		  if result = 0 then // Same file
		    result = l1.DiffIndex - l2.DiffIndex
		  end if
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Refresh()
		  if GitFolder is nil then
		    CheckStatusTimer.RunMode = Timer.RunModes.Off
		    
		  else
		    CheckStatusTimer.RunMode = Timer.RunModes.Multiple
		    CheckStatusTimer.Reset
		    
		    var currentStatus as string = Git_MTC.GitIt( GitFolder, Git_MTC.kGitStatus )
		    
		    if currentStatus.Compare( LastStatus, ComparisonOptions.CaseSensitive ) <> 0 then
		      //
		      // Get the current data
		      //
		      GetDiffs
		      
		      //
		      // Store the current status
		      //
		      LastStatus = currentStatus
		      
		      //
		      // Let the caller know
		      //
		      RaiseEvent Changed
		    end if
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetFile(pathSpec As String)
		  var path as string = pathSpec
		  
		  #if TargetWindows then
		    path = """" + path + """"
		  #else
		    path = "'" + path.ReplaceAll( "'", "'\''" ) + "'"
		  #endif
		  
		  call Git_MTC.GitIt( GitFolder, Git_MTC.kGitCheckoutFile + path )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RevertLines(lines() As Git_MTC.DiffLine)
		  //
		  // Open each file and remove or add the lines as needed
		  //
		  
		  lines.Sort AddressOf LineSorterByFileAndPosition
		  
		  //
		  // Create a list of files and their lines
		  //
		  var dict as new Dictionary
		  
		  for each line as Git_MTC.DiffLine in lines
		    if line.LineType = Git_MTC.LineTypes.Unchanged then
		      //
		      // Don't care
		      //
		      continue for line
		    end if
		    
		    var df as Git_MTC.DiffFile = line.Parent.Parent
		    
		    var arr() as Git_MTC.DiffLine
		    arr = dict.Lookup( df, arr )
		    arr.AddRow( line )
		    dict.Value( df ) = arr
		  next
		  
		  //
		  // Cycle through the files. If the number of changed lines matches the given lines
		  // we can reset the file
		  //
		  var keys() as variant = dict.Keys
		  var values() as variant = dict.Values
		  for i as integer = 0 to keys.LastRowIndex
		    var df as Git_MTC.DiffFile = keys( i )
		    var arr() as Git_MTC.DiffLine = values( i )
		    
		    if df.ChangedLineCount = arr.Count then
		      //
		      // We can reset
		      //
		      ResetFile( df.ToPathSpec )
		      dict.Remove( df )
		    end if
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StageLines(lines() As Git_MTC.DiffLine)
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 546865206769742073746174757320686173206368616E6765642E
		Event Changed()
	#tag EndHook


	#tag Property, Flags = &h21
		Private CheckStatusTimer As Timer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return GitIt( GitFolder, kCurrentBranch )
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  call GitIt( GitFolder, kCheckout + " " + value )
			  
			End Set
		#tag EndSetter
		CurrentBranch As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Diffs() As Git_MTC.DiffFile
	#tag EndProperty

	#tag Property, Flags = &h0
		EOL As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mGitFolder
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mGitFolder = value
			  Refresh
			  
			End Set
		#tag EndSetter
		GitFolder As FolderItem
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private LastStatus As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGitFolder As FolderItem
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CurrentBranch"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EOL"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
