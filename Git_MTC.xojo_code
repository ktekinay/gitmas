#tag Module
Protected Module Git_MTC
	#tag Method, Flags = &h21
		Private Function GitIt(repoPath As FolderItem, subcommand As String) As String
		  var cmd as string
		  #if TargetWindows then
		    cmd = "chdir """ + repoPath.NativePath + """ && "
		  #else
		    cmd = "cd '" + repoPath.NativePath.ReplaceAll( "'", "'\''" ) + "' && "
		  #endif
		  
		  cmd = cmd + GitCommand + subcommand
		  
		  var sh as new Shell
		  sh.Execute cmd
		  MaybeExceptionFromShell( "Error executing git command " + subcommand, sh )
		  
		  return sh.Result.DefineEncoding( Encodings.UTF8 ).Trim
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Init()
		  if WasInited then
		    return
		  end if
		  
		  //
		  // Set the git command
		  //
		  if GitCommandPath = "" then
		    #if not TargetWindows then
		      var sh as new Shell
		      sh.Execute "which git"
		      MaybeExceptionFromShell( "Error finding git command", sh )
		      
		      GitCommandPath = sh.Result.DefineEncoding( Encodings.UTF8 ).Trim
		    #endif
		  end if
		  
		  WasInited = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MaybeExceptionFromShell(msg As String, sh As Shell)
		  if sh.ExitCode <> 0 then
		    msg = msg.Trim
		    
		    if msg = "" then
		      msg = "Shell error"
		    end if
		    
		    if sh.Result <> "" then
		      msg = msg + ": " + sh.Result
		    end if
		    
		    raise new GitException( msg, sh.ExitCode )
		  end if
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private GitCommand As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  return mGitCommandPath
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mGitCommandPath = value
			  GitCommand = "'" + value.Trim.ReplaceAll( "'", "'\''" ) + "' " + kGitOptions + " "
			  
			End Set
		#tag EndSetter
		Protected GitCommandPath As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mGitCommandPath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private WasInited As Boolean
	#tag EndProperty


	#tag Constant, Name = kCheckout, Type = String, Dynamic = False, Default = \"checkout", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kCurrentBranch, Type = String, Dynamic = False, Default = \"branch --show-current", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kGitDiff, Type = String, Dynamic = False, Default = \"diff --no-color", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kGitOptions, Type = String, Dynamic = False, Default = \"--no-pager --no-optional-locks -c color.branch\x3Dfalse -c color.diff\x3Dfalse -c color.status\x3Dfalse -c diff.mnemonicprefix\x3Dfalse -c core.quotepath\x3Dfalse", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kGitStatus, Type = String, Dynamic = False, Default = \"status", Scope = Protected
	#tag EndConstant


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
			Name="GitCommand"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
