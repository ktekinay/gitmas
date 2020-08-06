#tag Class
Protected Class DiffFile
	#tag Method, Flags = &h0
		Sub Constructor(repo As Repo, diffString As String)
		  //
		  // Sample diff
		  //
		  'diff --git a/dragon-gui/UI/Claim List Views/ClaimListMassChangeWindow.xojo_window b/dragon-gui/UI/Claim List Views/ClaimListMassChangeWindow.xojo_window
		  'index e9080e4cb..46820d3a6 100644
		  '--- a/dragon-gui/UI/Claim List Views/ClaimListMassChangeWindow.xojo_window    
		  '+++ b/dragon-gui/UI/Claim List Views/ClaimListMassChangeWindow.xojo_window    
		  '@@ -930,6 +930,7 @@ Begin DragonBaseWindow ClaimListMassChangeWindow
		  'Top             =   503
		  'Transparent     =   False
		  'Underline       =   False
		  '+         UnicodeMode     =   "0"
		  'UseFocusRing    =   True
		  'Visible         =   True
		  'Width           =   235
		  '@@ -1244,7 +1245,7 @@ Begin DragonBaseWindow ClaimListMassChangeWindow
		  'Scope           =   2
		  'TabIndex        =   10
		  'TabPanelIndex   =   0
		  '-      TabStop         =   True
		  '+      TabStop         =   "True"
		  'Top             =   688
		  'Transparent     =   False
		  'Value           =   0.0
		  '@@ -1366,6 +1367,7 @@ Begin DragonBaseWindow ClaimListMassChangeWindow
		  'Top             =   447
		  'Transparent     =   False
		  'Underline       =   False
		  '+         UnicodeMode     =   "0"
		  'UseFocusRing    =   True
		  'Visible         =   True
		  'Width           =   235
		  
		  var hunkStrings() as string = diffString.Split( &u0A + "@@ " )
		  var headerLines() as string = hunkStrings( 0 ).Split( &u0A )
		  hunkStrings.RemoveRowAt( 0 )
		  
		  //
		  // Ignore the first line
		  //
		  
		  //
		  // Get the Index
		  //
		  Index = headerLines( 1 ).Middle( 6 )
		  
		  //
		  // Get the From file
		  //
		  FromFile = ExtractFolderItem( repo.GitFolder, headerLines( 2 ).Middle( 4 ) )
		  ToFile = ExtractFolderItem( repo.GitFolder, headerLines( 3 ).Middle( 4 ) )
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ExtractFolderItem(parentFolder As FolderItem, path As String) As FolderItem
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		FromFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		Hunks() As Hunk
	#tag EndProperty

	#tag Property, Flags = &h0
		Index As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ToFile As FolderItem
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
			Name="FromFile"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
