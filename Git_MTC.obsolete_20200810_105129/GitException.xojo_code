#tag Class
Protected Class GitException
Inherits RuntimeException
	#tag Method, Flags = &h0
		Sub Constructor(msg As String, code As Integer = 0)
		  super.Constructor
		  
		  Message = msg
		  ErrorNumber = code
		  
		End Sub
	#tag EndMethod


End Class
#tag EndClass
