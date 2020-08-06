#tag Class
Protected Class DiffLine
	#tag Method, Flags = &h0
		Sub Constructor(hunk As Git_MTC.Hunk, line As String)
		  Parent = hunk
		  
		  var indicator as string = line.Left( 1 )
		  Value = line.Middle( 1 )
		  
		  select case indicator
		  case " "
		    LineType = Git_MTC.LineTypes.Unchanged
		  case "+"
		    LineType = Git_MTC.LineTypes.Addition
		  case "-"
		    LineType = Git_MTC.LineTypes.Subtraction
		  case else
		    raise new GitException( "Could not determine line type of '" + line + "'" )
		  end select
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		FromLine As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		LineType As Git_MTC.LineTypes
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if ParentWR is nil then
			    return nil
			  else
			    return Git_MTC.Hunk( ParentWR.Value )
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
		Parent As Git_MTC.Hunk
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private ParentWR As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h0
		ToLine As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Value As String
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
			Name="LineType"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
