#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub NewDocument()
		  if M_Git.GitVersion = "" then
		    return
		  end if
		  
		  //
		  // There is now "new" here, so call Open
		  //
		  OpenRepo
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  if M_Git.GitVersion = "" then
		    MessageBox( "The git command line utility must be installed first." )
		    quit
		  end if
		  
		  //
		  // Load up the best mono font
		  //
		  var fonts() as string
		  for i as integer = 0 to System.LastFontIndex
		    fonts.AddRow( System.FontAt( i ) )
		  next
		  
		  #if DebugBuild then
		    fonts.Sort
		  #endif
		  
		  var bestFonts() as string = array( _
		  "JetBrains Mono NL", _
		  "JetBrainsMono NL", _
		  "JetBrains Mono", _
		  "JetBrainsMono", _
		  "Source Code Pro", _
		  "SourceCode Pro", _
		  "SourceCodePro", _
		  "Noto Mono", _
		  "Lucida Console", _
		  "Courier New", _
		  "Courier", _
		  "Monaco", _
		  GitmasListbox.kDefaultMonoFontName _
		  )
		  
		  for each f as string in bestFonts
		    if fonts.IndexOf( f ) <> -1 then
		      MonoFontName = f
		      exit
		    end if
		  next
		  
		  if MonoFontName = "" then
		    MonoFontName = "SmallSystem"
		    MonoFontSize = 0
		  end if
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub OpenDocument(item As FolderItem)
		  if M_Git.GitVersion = "" then
		    return
		  end if
		  
		  if not item.IsFolder then
		    item = item.Parent
		  end if
		  
		  //
		  // Scan for windows that already show this repo
		  //
		  for i as integer = WindowCount - 1 downto 0
		    var w as Window = Window( i )
		    if w isa WndRepo then
		      var wr as WndRepo = WndRepo( w )
		      if wr.GitFolder.NativePath = item.NativePath then
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
		Function AboutMenu() As Boolean Handles AboutMenu.Action
			WndAbout.Show
			return true
			
			
		End Function
	#tag EndMenuHandler

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
		MonoFontName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		MonoFontSize As Integer = 11
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  var f as FolderItem = SpecialFolder.Temporary.Child( "gitmas" )
			  if not f.Exists then
			    f.CreateFolder
			  end if
			  return f
			  
			End Get
		#tag EndGetter
		TempFolder As FolderItem
	#tag EndComputedProperty


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
			Name="MonoFontName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MonoFontSize"
			Visible=false
			Group="Behavior"
			InitialValue="10"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
