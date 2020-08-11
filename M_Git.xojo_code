#tag Module
Protected Module M_Git
	#tag Method, Flags = &h21
		Private Function ExtractEOL(s As String, default As String = "") As String
		  const kLF as string = &u0A
		  const kCR as string = &u0D
		  const kCRLF as string = kCR + kLF
		  
		  if s.IndexOf( kCRLF ) <> -1 then
		    return kCRLF
		  elseif s.IndexOf( kLF ) <> -1 then
		    return kLF
		  elseif s.IndexOf( kCR ) <> -1 then
		    return kCR
		  end if
		  
		  return default
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GitIt(repoPath As FolderItem, subcommand As String) As String
		  var cmd as string
		  #if TargetWindows then
		    cmd = "chdir " + ShellSafe( repoPath.NativePath ) + " && "
		  #else
		    cmd = "cd " + ShellSafe( repoPath.NativePath ) + " && "
		  #endif
		  
		  cmd = cmd + GitCommand + subcommand
		  
		  System.DebugLog( "Executing: " + cmd )
		  var sh as new Shell
		  sh.Execute( cmd )
		  if sh.ExitCode = 0 then
		    System.DebugLog( "...success" )
		  else
		    System.DebugLog( "...FAILED (" + sh.ExitCode.ToString + ")" )
		  end if
		  
		  var result as string = sh.Result.DefineEncoding( Encodings.UTF8 ).Trim
		  System.DebugLog( result )
		  
		  MaybeExceptionFromShell( "Error executing git command " + subcommand, sh )
		  
		  return result
		  
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
		      sh.Execute( "echo $SHELL" )
		      MaybeExceptionFromShell( "Could not identify shell", sh )
		      
		      var shellPath as string = sh.Result.DefineEncoding( Encodings.UTF8 ).Trim
		      sh.Execute( shellPath + " -lc 'which git'" )
		      MaybeExceptionFromShell( "Error finding git command", sh )
		      
		      GitCommandPath = sh.Result.DefineEncoding( Encodings.UTF8 ).Trim
		      GitCommandPath = GitCommandPath.ReplaceLineEndings( &uA )
		      GitCommandPath = GitCommandPath.NthField( &uA, GitCommandPath.CountFields( &uA ) )
		    #endif
		    System.DebugLog( "Using git from " + GitCommandPath )
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

	#tag Method, Flags = &h21
		Private Function ShellSafe(s As String) As String
		  //
		  // Makes a string shell-safe
		  //
		  
		  #if TargetWindows then
		    
		    const kQuote as string = """"
		    
		    s = kQuote + s.ReplaceAll( kQuote, "\" + kQuote ) + kQuote
		    
		  #else
		    
		    const kQuote as string = "'"
		    
		    s = kQuote + s.ReplaceAll( kQuote, kQuote + "\'" + kQuote ) + kQuote
		    
		  #endif
		  
		  return s
		  
		End Function
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
			  GitCommand = ShellSafe( value ) + " " + kGitOptions + " "
			  
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

	#tag Constant, Name = kGitAdd, Type = String, Dynamic = False, Default = \"add ", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kGitApplyCached, Type = String, Dynamic = False, Default = \"apply --cached ", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kGitCheckoutFile, Type = String, Dynamic = False, Default = \"checkout -- ", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kGitDiff, Type = String, Dynamic = False, Default = \"diff --no-color --minimal --patch --unified\x3D6 ", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kGitOptions, Type = String, Dynamic = False, Default = \"--no-pager --no-optional-locks -c color.branch\x3Dfalse -c color.diff\x3Dfalse -c color.status\x3Dfalse -c diff.mnemonicprefix\x3Dfalse -c core.quotepath\x3Dfalse", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kGitResetHard, Type = String, Dynamic = False, Default = \"reset --hard HEAD -- ", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kGitStatus, Type = String, Dynamic = False, Default = \"status -vv ", Scope = Private
	#tag EndConstant


	#tag Enum, Name = LineTypes, Type = Integer, Flags = &h1
		Unchanged
		  Addition
		Subtraction
	#tag EndEnum


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
	#tag EndViewBehavior
End Module
#tag EndModule
