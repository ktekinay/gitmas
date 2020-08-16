#tag Class
Protected Class DiffLine
	#tag Method, Flags = &h0
		Sub Constructor(hunk As M_Git.Hunk, line As String)
		  Parent = hunk
		  
		  var indicator as string = line.Left( 1 )
		  Value = line.Middle( 1 )
		  
		  select case indicator
		  case " "
		    LineType = M_Git.LineTypes.Unchanged
		  case "+"
		    LineType = M_Git.LineTypes.Addition
		  case "-"
		    LineType = M_Git.LineTypes.Subtraction
		  case "\" 
		    LineType = M_Git.LineTypes.NoTrailingNewline
		  case else
		    raise new GitException( "Could not determine line type of '" + line + "'" )
		  end select
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		DiffIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		FromLine As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return LineType = M_Git.LineTypes.Addition
			  
			End Get
		#tag EndGetter
		IsAddition As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return LineType = M_Git.LineTypes.Subtraction
			  
			End Get
		#tag EndGetter
		IsSubtraction As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return LineType = M_Git.LineTypes.Unchanged
			  
			End Get
		#tag EndGetter
		IsUnchanged As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		LineType As M_Git.LineTypes
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if ParentWR is nil then
			    return nil
			  else
			    return M_Git.Hunk( ParentWR.Value )
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
		Parent As M_Git.Hunk
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private ParentWR As WeakRef
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  select case LineType
			  case M_Git.LineTypes.Unchanged
			    return " "
			  case M_Git.LineTypes.Addition
			    return "+"
			  case M_Git.LineTypes.Subtraction
			    return "-"
			  case M_Git.LineTypes.NoTrailingNewline
			    return "\"
			  end select
			End Get
		#tag EndGetter
		Symbol As String
	#tag EndComputedProperty

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
			Type="M_Git.LineTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Unchanged"
				"1 - Addition"
				"2 - Subtraction"
				"3 - NoTrailingNewline"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="FromLine"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ToLine"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Value"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Symbol"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DiffIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsAddition"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsSubtraction"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsUnchanged"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
