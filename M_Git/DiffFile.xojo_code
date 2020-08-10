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
		  
		  const kHunkSep as string = "@@ "
		  
		  Parent = repo
		  
		  var hunkStrings() as string = diffString.Split( &u0A + kHunkSep )
		  var headerLines() as string = hunkStrings( 0 ).Split( &u0A )
		  hunkStrings.RemoveRowAt( 0 )
		  
		  for each header as string  in headerLines
		    if header.BeginsWith( "index " ) then
		      FileIndex = header.Middle( 6 )
		    elseif header.BeginsWith( "---" ) then
		      FromFile = ExtractFolderItem( repo.GitFolder, header.Middle( 4 ), FromPathSpec )
		    elseif header.BeginsWith( "+++" ) then
		      ToFile = ExtractFolderItem( repo.GitFolder, header.Middle( 4 ), ToPathSpec )
		    end if
		  next
		  
		  if FromFile.NativePath.Compare( ToFile.NativePath, ComparisonOptions.CaseSensitive ) = 0 then
		    ToFile = FromFile
		  end if
		  
		  //
		  // Create the hunks
		  //
		  Hunks.RemoveAllRows
		  for each hunk as string in hunkStrings
		    Hunks.AddRow( new M_Git.Hunk( self, kHunkSep + hunk ) )
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ExtractFolderItem(parentFolder As FolderItem, path As String, ByRef pathSpec As String) As FolderItem
		  path = path.NthField( &u09, 1 )
		  
		  var left1 as string = path.Left( 1 )
		  var left2 as string = path.Left( 2 )
		  
		  if left2 = "a/" or left2 = "b/" then
		    path = path.Middle( 1 )
		    pathSpec = path.Middle( 1 )
		  elseif left1 = "/" or ( TargetWindows and left1 = "\" ) then
		    pathSpec = path.Middle( 1 )
		  else
		    pathSpec = path
		  end if
		  
		  #if TargetWindows then
		    path = path.ReplaceAll( "/", "\" )
		  #endif
		  
		  var newPath as string = parentFolder.NativePath + path
		  var f as new FolderItem( newPath )
		  return f
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		ChangedLineCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		FileIndex As String
	#tag EndProperty

	#tag Property, Flags = &h0
		FromFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		FromPathSpec As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Hunks() As Hunk
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if ParentWR is nil then
			    return nil
			  else
			    return M_Git.Repo( ParentWR.Value )
			  end if
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  if value is nil then
			    ParentWR = nil
			  else
			    ParentWR = new WeakRef( value )
			  end if
			  
			End Set
		#tag EndSetter
		Parent As M_Git.Repo
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private ParentWR As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h0
		ToFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		ToPathSpec As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FileIndex"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="ChangedLineCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ToPathSpec"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FromPathSpec"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
