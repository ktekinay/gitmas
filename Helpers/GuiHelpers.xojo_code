#tag Module
Protected Module GuiHelpers
	#tag Method, Flags = &h0
		Function QuickRequestDialog(inWindow As Window, msg As String, explanation As String, actionButtonCaption As String = kCaptionOK, cancelButtonCaption As String = kCaptionCancel, alternateButtonCaption As String = "") As String
		  var diag as new MessageDialog
		  diag.Message = msg
		  diag.Explanation = explanation
		  diag.ActionButton.Caption = actionButtonCaption
		  
		  if cancelButtonCaption = "" then
		    diag.CancelButton.IsVisible = false
		  else
		    diag.CancelButton.Caption = cancelButtonCaption
		    diag.CancelButton.IsVisible = true
		  end if
		  
		  if alternateButtonCaption = "" then
		    diag.AlternateActionButton.IsVisible = false
		  else
		    diag.AlternateActionButton.Caption = alternateButtonCaption
		    diag.AlternateActionButton.IsVisible = true
		  end if
		  
		  var result as string
		  if inWindow isa object then
		    result = diag.ShowModalWithin( inWindow ).Caption
		  else
		    result = diag.ShowModal.Caption
		  end if
		  
		  return result
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kCaptionCancel, Type = String, Dynamic = False, Default = \"Cancel", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kCaptionOK, Type = String, Dynamic = False, Default = \"OK", Scope = Protected
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
	#tag EndViewBehavior
End Module
#tag EndModule
