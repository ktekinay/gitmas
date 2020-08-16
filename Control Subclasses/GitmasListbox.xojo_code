#tag Class
Protected Class GitmasListbox
Inherits Listbox
	#tag Event
		Function CellBackgroundPaint(g As Graphics, row As Integer, column As Integer) As Boolean
		  if RaiseEvent CellBackgroundPaint( g, row, column ) then
		    //
		    // Subclass handled it
		    //
		    return true
		  end if
		  
		  if row < self.RowCount and Selected( row ) then
		    //
		    // Selected row, let Xojo handle it
		    //
		    return false
		  end if
		  
		  if ( row mod 2 ) = 0 then
		    //
		    // Even row
		    //
		    return false
		  end if
		  
		  var altRowColorLight as color = &cF0F2FF00
		  var altRowColorDark as color = &c10101000
		  
		  g.DrawingColor = if( IsDarkMode, altRowColorDark, altRowColorLight )
		  g.FillRectangle( 0, 0, g.Width, g.Height )
		  
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub Close()
		  RaiseEvent Close
		  
		  if mExpanderTimer isa object then
		    mExpanderTimer.RunMode = Timer.RunModes.Off
		    RemoveHandler mExpanderTimer.Action, WeakAddressOf ExpanderTimer_Action
		    mExpanderTimer = nil
		  end if
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub CollapseRow(row As Integer)
		  RaiseEvent CollapseRow( row )
		  
		  if not IsExpandingAll and IsModifierKeyDown then
		    //
		    // Collapse all the rows
		    //
		    ExpandValue = false
		    ExpanderTimer.RunMode = Timer.RunModes.Single
		  end if
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub ExpandRow(row As Integer)
		  RaiseEvent ExpandRow( row )
		  
		  if not IsExpandingAll and IsModifierKeyDown then
		    //
		    // Expand all the rows
		    //
		    ExpandValue = true
		    ExpanderTimer.RunMode = Timer.RunModes.Single
		  end if
		  
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub CollapseAll()
		  IsExpandingAll = true
		  
		  for r as integer = LastRowIndex downto 0
		    if self.ExpandableRowAt( r ) and self.RowExpandedAt( r ) = true then
		      self.RowExpandedAt( r ) = false
		    end if
		  next
		  
		  IsExpandingAll = false
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExpandAll()
		  IsExpandingAll = true
		  
		  for r as integer = LastRowIndex downto 0
		    if self.ExpandableRowAt( r ) and self.RowExpandedAt( r ) = false then
		      self.RowExpandedAt( r ) = true
		    end if
		  next
		  
		  IsExpandingAll = false
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ExpanderTimer_Action(sender As Timer)
		  #pragma unused sender
		  
		  if ExpandValue then
		    ExpandAll
		  else
		    CollapseAll
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedRows() As Integer()
		  var rows() as integer
		  
		  for row as integer = 0 to self.LastRowIndex
		    if Selected( row ) then
		      rows.AddRow( row )
		    end if
		  next
		  
		  return rows
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectedRows(Assigns rows() As Integer)
		  //
		  // Unselect all the rows
		  //
		  self.SelectedRowIndex = -1
		  
		  for each row as integer in rows
		    self.Selected( row ) = true
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectedRowTags() As Variant()
		  var tags() as variant
		  
		  for row as integer = 0 to self.LastRowIndex
		    tags.AddRow( RowTagAt( row ) )
		  next
		  
		  return tags
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event CellBackgroundPaint(g As Graphics, row As Integer, column As Integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Close()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CollapseRow(row As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ExpandRow(row As Integer)
	#tag EndHook


	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  if mExpanderTimer is nil then
			    mExpanderTimer = new Timer
			    mExpanderTimer.Period = 5
			    mExpanderTimer.RunMode = Timer.RunModes.Off
			    
			    AddHandler mExpanderTimer.Action, WeakAddressOf ExpanderTimer_Action
			  end if
			  
			  return mExpanderTimer
			End Get
		#tag EndGetter
		Private ExpanderTimer As Timer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private ExpandValue As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private IsExpandingAll As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  var result as boolean
			  
			  if TargetMacOS and _
			    Keyboard.OptionKey and _
			    not Keyboard.ShiftKey and _
			    not Keyboard.ControlKey and _
			    not Keyboard.CommandKey then
			    result = true
			    
			  elseif not TargetMacOS and _
			    Keyboard.AltKey and _
			    not Keyboard.ShiftKey and _
			    not Keyboard.ControlKey and _
			    not Keyboard.OSKey then
			    result = true
			  end if
			  
			  return result
			  
			End Get
		#tag EndGetter
		Private IsModifierKeyDown As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mExpanderTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h0
		MonoFontName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		MonoFontSize As Integer
	#tag EndProperty


	#tag Constant, Name = kDefaultMonoFontName, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Monaco"
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"Lucida Console"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Noto Mono"
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
			InitialValue=""
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
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBorder"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnCount"
			Visible=true
			Group="Appearance"
			InitialValue="1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnWidths"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultRowHeight"
			Visible=true
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="GridLinesHorizontalStyle"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="Borders"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - None"
				"2 - ThinDotted"
				"3 - ThinSolid"
				"4 - ThickSolid"
				"5 - DoubleThinSolid"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="GridLinesVerticalStyle"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="Borders"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - None"
				"2 - ThinDotted"
				"3 - ThinSolid"
				"4 - ThickSolid"
				"5 - DoubleThinSolid"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHeader"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HeadingIndex"
			Visible=true
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialValue"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHorizontalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasVerticalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DropIndicatorVisible"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataSource"
			Visible=true
			Group="Database Binding"
			InitialValue=""
			Type="String"
			EditorType="DataSource"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataField"
			Visible=true
			Group="Database Binding"
			InitialValue=""
			Type="String"
			EditorType="DataField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoHideScrollbars"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowResizableColumns"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowRowDragging"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowRowReordering"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowExpandableRows"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RequiresSelection"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RowSelectionType"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="RowSelectionTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Single"
				"1 - Multiple"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="MonoFontName"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MonoFontSize"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Bold"
			Visible=true
			Group="Font"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=true
			Group="Font"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontName"
			Visible=true
			Group="Font"
			InitialValue="System"
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontSize"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="Single"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontUnit"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="FontUnits"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Pixel"
				"2 - Point"
				"3 - Inch"
				"4 - Millimeter"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Underline"
			Visible=true
			Group="Font"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_ScrollOffset"
			Visible=false
			Group="Appearance"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_ScrollWidth"
			Visible=false
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group=""
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
