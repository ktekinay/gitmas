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
		Private Function GenerateDiffForLines(df As Git_MTC.DiffFile, lines() As Git_MTC.DiffLine) As String
		  //
		  // lines will be sorted
		  //
		  
		  var hunks() as Git_MTC.Hunk = HunksOfLines( lines )
		  
		  var builder() as string
		  
		  //
		  // Header
		  //
		  builder.AddRow( "diff --git a/" + df.FromPathSpec + " b/" + df.ToPathSpec )
		  builder.AddRow( "index " + df.FileIndex )
		  builder.AddRow( "--- a/" + df.FromPathSpec + &u09 )
		  builder.AddRow( "+++ b/" + df.ToPathSpec + &u09 )
		  
		  for each hunk as Git_MTC.Hunk in hunks
		    //
		    // Record the header index, we'll build it later
		    //
		    builder.AddRow( "header" )
		    var headerIndex as integer = builder.LastRowIndex
		    var toCount as integer
		    var fromCount as integer
		    
		    for each hunkLine as Git_MTC.DiffLine in hunk.Lines
		      if hunkLine.IsUnchanged then
		        //
		        // We add it regardless if it's included
		        //
		        builder.AddRow( hunkLine.Symbol + hunkLine.Value )
		        fromCount = fromCount + 1
		        toCount = toCount + 1
		        
		      else
		        var isIncluded as boolean = lines.IndexOf( hunkLine ) <> 0
		        
		        if isIncluded then
		          builder.AddRow( hunkLine.Symbol + hunkLine.Value )
		          if hunkLine.IsAddition then
		            toCount = toCount + 1
		          else //Subtraction
		            fromCount = fromCount + 1
		          end if
		          
		        elseif hunkLine.IsSubtraction then 
		          //
		          // Since it wasn't included, we act like it's unchanged
		          //
		          builder.AddRow( " " + hunkLine.Value )
		          fromCount = fromCount + 1
		          toCount = toCount + 1
		          
		        end if
		        
		      end if
		    next
		    
		    //
		    // Now build the header
		    //
		    var header as string = "@@ -" + hunk.FromStartingLine.ToString + "," + fromCount.ToString
		    header = header + " +" + hunk.ToStartingLine.ToString + "," + toCount.ToString
		    header = header + " @@"
		    builder( headerIndex ) = header
		  next
		  
		  var diff as string = String.FromArray( builder, EndOfLine ) + EndOfLine
		  return diff
		  
		  'diff --git a/dragon-gui/UI/Claim Views/Claim Widgets/ClaimAppealControl.xojo_window b/dragon-gui/UI/Claim Views/Claim Widgets/ClaimAppealControl.xojo_window
		  'index c748cd894..d4c1bd217 100644
		  '--- a/dragon-gui/UI/Claim Views/Claim Widgets/ClaimAppealControl.xojo_window    
		  '+++ b/dragon-gui/UI/Claim Views/Claim Widgets/ClaimAppealControl.xojo_window    
		  '@@ -416,6 +416,7 @@ Begin DragonBaseContainerControl ClaimAppealControl
		  'Top             =   103
		  'Transparent     =   False
		  'Underline       =   False
		  '+         UnicodeMode     =   "0"
		  'UseFocusRing    =   True
		  'Visible         =   True
		  'Width           =   280
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GetDiffs()
		  var diffString as string = GitIt( GitFolder, kGitDiff )
		  System.DebugLog diffString
		  
		  if EOL = "" then
		    EOL = ExtractEOL( diffString )
		  end if
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
		Private Function HunksOfLines(lines() As Git_MTC.DiffLine) As Git_MTC.Hunk()
		  //
		  // lines will already be properly sorted
		  //
		  
		  var hunks() as Git_MTC.Hunk
		  
		  for each line as Git_MTC.DiffLine in lines
		    if hunks.Count = 0 or hunks( hunks.LastRowIndex ) <> line.Parent then
		      hunks.AddRow( line.Parent )
		    end if
		  next
		  
		  return hunks
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function LineSorterByFileAndPosition(l1 As Git_MTC.DiffLine, l2 As Git_MTC.DiffLine) As Integer
		  var f1 as FolderItem = l1.Parent.Parent.ToFile
		  var f2 as FolderItem = l2.Parent.Parent.ToFile
		  
		  var result as integer = f1.NativePath.Compare( f2.NativePath, ComparisonOptions.CaseSensitive )
		  
		  if result = 0 then // Same file
		    result = l1.Parent.FromStartingLine - l2.Parent.FromStartingLine
		  end if
		  
		  if result = 0 then // Same hunk
		    result = l1.DiffIndex - l2.DiffIndex
		  end if
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function LinesToFileDict(lines() As Git_MTC.DiffLine) As Dictionary
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
		    
		    var fileLines() as Git_MTC.DiffLine
		    fileLines = dict.Lookup( df, fileLines )
		    fileLines.AddRow( line )
		    dict.Value( df ) = fileLines
		  next
		  
		  return dict
		  
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
		Sub ResetFile(df As Git_MTC.DiffFile)
		  ResetFileWithoutRefresh( df )
		  Refresh
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ResetFileByHunks(df As Git_MTC.DiffFile, resetLines() As Git_MTC.DiffLine)
		  //
		  // The lines will be sorted by hunks
		  //
		  
		  var hunks() as Git_MTC.Hunk = HunksOfLines( resetLines )
		  
		  //
		  // Recreate the file and write it back
		  //
		  var tis as TextInputStream = TextInputStream.Open( df.ToFile )
		  var source as string = tis.ReadAll( Encodings.UTF8 )
		  tis.Close
		  
		  var eol as string = ExtractEOL( source, EndOfLine )
		  
		  var sourceLines() as string = source.Split( eol )
		  
		  //
		  // For each hunk, we will remove the lines as they exist, then add them 
		  // back from the hunk, adjusting for the ones that are being reverted
		  //
		  
		  for hunkIndex as integer = hunks.LastRowIndex downto 0
		    var hunk as Git_MTC.Hunk = hunks( hunkIndex )
		    
		    //
		    // Make sure we are matching at the right place
		    //
		    var startingIndex as integer = hunk.ToStartingLine - 1
		    for each line as Git_MTC.DiffLine in hunk.Lines
		      if line.IsUnchanged or line.IsAddition then
		        if sourceLines( line.ToLine - 1 ).Compare( line.Value, ComparisonOptions.CaseSensitive ) = 0 then
		          //
		          // Matched
		          //
		          exit for line
		        else
		          //
		          // Some problem
		          //
		          raise new Git_MTC.GitException( "Could not find matching line during revert" )
		        end if
		      end if
		    next
		    
		    //
		    // Remove the existing lines from the source
		    //
		    for counter as integer = 1 to hunk.ToLineCount
		      sourceLines.RemoveRowAt( startingIndex )
		    next counter
		    
		    //
		    // Add them back from the hunk
		    //
		    var sourceIndex as integer = startingIndex
		    
		    for each line as Git_MTC.DiffLine in hunk.Lines
		      var isReset as boolean = _
		      line.LineType <> Git_MTC.LineTypes.Unchanged and _
		      resetLines.IndexOf( line ) <> -1
		      
		      if isReset = false or line.LineType = Git_MTC.LineTypes.Subtraction then
		        //
		        // Add it back
		        //
		        sourceLines.AddRowAt( sourceIndex, line.Value )
		        sourceIndex = sourceIndex + 1
		      end if
		    next line
		  next hunkIndex
		  
		  source = String.FromArray( sourceLines, eol )
		  
		  //
		  // Backup the file
		  //
		  var backup as FolderItem = _
		  df.ToFile.Parent.Child( df.ToFile.Name + "." + System.Microseconds.ToString( "##0" ) + ".bkup" )
		  df.ToFile.CopyTo( backup )
		  
		  //
		  // Overwrite the file
		  //
		  var orig as new FolderItem( df.ToFile ) // Refresh the properties
		  var lastModified as Date = orig.ModificationDate
		  
		  var bs as BinaryStream
		  
		  try
		    bs = BinaryStream.Open( df.ToFile, true )
		    bs.BytePosition = 0 // Reset the contents
		    bs.Write( source )
		    bs.Close
		    bs = nil
		    
		  catch err as IOException
		    if bs isa object then
		      bs.Close
		      bs = nil
		    end if
		    
		    //
		    // Maybe restore the backup
		    //
		    var current as new FolderItem( df.ToFile )
		    if current.ModificationDate.TotalSeconds <> lastModified.TotalSeconds then
		      backup.CopyTo( df.ToFile )
		    end if
		    
		    backup.Remove
		    
		    raise err
		  end try
		  
		  //
		  // Success, remove the backup
		  //
		  backup.Remove
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ResetFileWithoutRefresh(df As Git_MTC.DiffFile)
		  var path as string = df.FromPathSpec
		  
		  #if TargetWindows then
		    path = """" + path + """"
		  #else
		    path = "'" + path.ReplaceAll( "'", "'\''" ) + "'"
		  #endif
		  
		  call Git_MTC.GitIt( GitFolder, Git_MTC.kGitCheckoutFile + path )
		  
		  if df.ToFile.Exists and df.FromFile.Exists and _
		    df.ToFile.NativePath.Compare( df.FromFile.NativePath, ComparisonOptions.CaseSensitive ) <> 0 then
		    df.ToFile.Remove
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RevertLines(lines() As Git_MTC.DiffLine)
		  //
		  // Open each file and remove or add the lines as needed
		  //
		  
		  //
		  // Create a list of files and their lines
		  //
		  var dict as Dictionary = LinesToFileDict( lines )
		  
		  //
		  // Cycle through the files. If the number of changed lines matches the given lines
		  // we can reset the file
		  //
		  var keys() as variant = dict.Keys
		  var values() as variant = dict.Values
		  for i as integer = 0 to keys.LastRowIndex
		    var df as Git_MTC.DiffFile = keys( i )
		    var fileLines() as Git_MTC.DiffLine = values( i )
		    
		    if df.ChangedLineCount = fileLines.Count then
		      //
		      // We can reset
		      //
		      ResetFileWithoutRefresh( df )
		      
		    else
		      //
		      // We have to cherry-pick lines out of files using the hunks
		      //
		      ResetFileByHunks( df, fileLines )
		      
		    end if
		  next
		  
		  Refresh
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StageFile(df As Git_MTC.DiffFile)
		  StageFileWithoutRefresh( df )
		  Refresh
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StageFileWithoutRefresh(df As Git_MTC.DiffFile)
		  call GitIt( df.Parent.GitFolder, Git_MTC.kGitAdd + "'" + df.ToPathSpec.ReplaceAll( "'", "'\''" ) + "'" )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StageLines(lines() As Git_MTC.DiffLine)
		  //
		  // Stage lines, or entire files, if needed
		  //
		  
		  var dict as Dictionary = LinesToFileDict( lines )
		  
		  //
		  // Cycle through the files. If the number of changed lines matches the given lines
		  // we can stage the file
		  //
		  var keys() as variant = dict.Keys
		  var values() as variant = dict.Values
		  for i as integer = 0 to keys.LastRowIndex
		    var df as Git_MTC.DiffFile = keys( i )
		    var fileLines() as Git_MTC.DiffLine = values( i )
		    
		    if df.ChangedLineCount = fileLines.Count then
		      //
		      // We can reset
		      //
		      StageFileWithoutRefresh( df )
		      
		    else
		      var diffString as string = GenerateDiffForLines( df, lines )
		      var diffFile as FolderItem = App.TempFolder.Child( "stagelines.diff" )
		      var tos as TextOutputStream = TextOutputStream.Create( diffFile )
		      tos.Write( diffString )
		      tos.Close
		      
		      call GitIt( GitFolder, Git_MTC.kGitApplyCached + "'" + diffFile.NativePath.ReplaceAll( "'", "'\''" ) + "'" )
		      
		      diffFile.Remove
		    end if
		  next
		  
		  Refresh
		  
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
