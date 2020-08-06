#tag Class
Protected Class Repo
	#tag Method, Flags = &h0
		Sub Constructor(folder As FolderItem)
		  Init
		  call GitIt( folder, kCurrentBranch )
		  mGitFolder = folder
		  
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

	#tag Method, Flags = &h0
		Sub Refresh()
		  GetDiffs
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StageLines(lines() As Git_MTC.DiffLine)
		  
		End Sub
	#tag EndMethod


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
			  Return mGitFolder
			End Get
		#tag EndGetter
		GitFolder As FolderItem
	#tag EndComputedProperty

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
