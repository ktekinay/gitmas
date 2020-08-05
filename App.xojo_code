#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub NewDocument()
		  //
		  // There is now "new" here, so call Open
		  //
		  OpenRepo
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub OpenDocument(item As FolderItem)
		  WasAppOpenedWithDocument = true
		  
		  //
		  // Scan for windows that already show this repo
		  //
		  for i as integer = WindowCount - 1 downto 0
		    var w as Window = Window( i )
		    if w isa WndRepo then
		      var wr as WndRepo = WndRepo( w )
		      if wr.RepoFolderItem.NativePath = item.NativePath then
		        wr.Show
		        return
		      end if
		    end if
		  next
		  
		  //
		  // If we get here, we couldn't find an open window, so create it
		  //
		  var wr as new WndRepo
		  wr.Show( item )
		  
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function FileOpenMenu() As Boolean Handles FileOpenMenu.Action
			OpenRepo
			Return True
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Sub OpenRepo()
		  var d as new SelectFolderDialog
		  d.PromptText = "Open an existing repo:"
		  var result as FolderItem = d.ShowModal
		  
		  if result isa FolderItem then
		    OpenDocument( result )
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		WasAppOpenedWithDocument As Boolean
	#tag EndProperty


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="WasAppOpenedWithDocument"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
