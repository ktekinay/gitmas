#tag Class
Protected Class Hunk
	#tag Method, Flags = &h0
		Sub Constructor(df As Git_MTC.DiffFile, hunkString As String)
		  Parent = df
		  
		  //
		  // Sample
		  //
		  '@@ -4,24 +4,32 @@ Inherits ToolsMenuItem
		  '     #tag Event
		  '         Sub EnableMenu()
		  '             if App.CurrentUser is nil then
		  '                 Visible = False
		  '             elseif Visible <> App.CurrentUser.IsDeveloper then
		  '                 Visible = App.CurrentUser.IsDeveloper
		  '             end if
		  '         End Sub
		  '     #tag EndEvent
		  '
		  '
		  '     #tag ViewBehavior
		  '+        #tag ViewProperty
		  '+            Name="LastRowIndex"
		  '+            Visible=false
		  '+            Group="Behavior"
		  '+            InitialValue=""
		  '+            Type="Integer"
		  '+            EditorType=""
		  '+        #tag EndViewProperty
		  '         #tag ViewProperty
		  '             Name="HasCheckMark"
		  '             Visible=false
		  '             Group="Behavior"
		  '             InitialValue=""
		  '             Type="Boolean"
		  '             EditorType=""
		  '         #tag EndViewProperty
		  '         #tag ViewProperty
		  '             Name="Shortcut"
		  '             Visible=false
		  '             Group="Behavior"
		  
		  var rx as new RegEx // Reusable
		  var match as RegExMatch
		  
		  //
		  // Get the starting and ending indexes
		  //
		  rx.SearchPattern = "@@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))?"
		  match = rx.Search( hunkString )
		  FromStartingLine = match.SubExpressionString( 1 ).ToInteger
		  FromStartingLineCount = if( match.SubExpressionString( 2 ) <> "", match.SubExpressionString( 2 ).ToInteger , 1 )
		  ToStartingLine = match.SubExpressionString( 3 ).ToInteger
		  ToStartingLineCount = if( match.SubExpressionCount > 4 and match.SubExpressionString( 4 ) <> "", match.SubExpressionString( 4 ).ToInteger, 1 )
		  
		  //
		  // Set the Source
		  //
		  rx.SearchPattern = "\A.*\R"
		  rx.ReplacementPattern = ""
		  mSource = rx.Replace( hunkString )
		  
		  //
		  // Set the lines
		  //
		  var lines() as string = Source.Split( &u0A )
		  var fromIndex as integer = FromStartingLine
		  var toIndex as integer = ToStartingLine
		  
		  self.Lines.RemoveAllRows
		  
		  for i as integer = 0 to lines.LastRowIndex
		    var line as string = lines( i )
		    var dl as new Git_MTC.DiffLine( self, line )
		    
		    select case dl.LineType
		    case Git_MTC.LineTypes.Unchanged
		      dl.FromLine = fromIndex
		      dl.ToLine = toIndex
		      fromIndex = fromIndex + 1
		      toIndex = toIndex + 1
		    case LineTypes.Addition
		      dl.FromLine = -1
		      dl.ToLine = toIndex
		      toIndex = toIndex + 1
		    case LineTypes.Subtraction
		      dl.FromLine = fromIndex
		      dl.ToLine = -1
		      fromIndex = fromIndex + 1
		    end select
		    self.Lines.AddRow( dl )
		  next
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function LinesWithoutType(exclude As Git_MTC.LineTypes) As Git_MTC.DiffLine()
		  var result() as Git_MTC.DiffLine
		  for each dl as Git_MTC.DiffLine in Lines
		    if dl.LineType <> exclude then
		      result.AddRow( dl )
		    end if
		  next
		  
		  return result
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  var builder() as string
			  for each dl as Git_MTC.DiffLine in LinesWithoutType( Git_MTC.LineTypes.Subtraction )
			    builder.Append( dl.Value )
			  next
			  
			  var eol as string = &u0A
			  if Parent isa object and Parent.Parent isa object then
			    eol = Parent.Parent.EOL
			  end if
			  
			  return String.FromArray( builder, eol )
			  
			End Get
		#tag EndGetter
		AfterChanges As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  var builder() as string
			  for each dl as Git_MTC.DiffLine in LinesWithoutType( Git_MTC.LineTypes.Addition )
			    builder.Append( dl.Value )
			  next
			  
			  var eol as string = &u0A
			  if Parent isa object and Parent.Parent isa object then
			    eol = Parent.Parent.EOL
			  end if
			  
			  return String.FromArray( builder, eol )
			  
			End Get
		#tag EndGetter
		BeforeChanges As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		FromStartingLine As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		FromStartingLineCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Lines() As Git_MTC.DiffLine
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSource As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if ParentWR is nil then
			    return nil
			  else
			    return Git_MTC.DiffFile( ParentWR.Value )
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
		Parent As Git_MTC.DiffFile
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private ParentWR As WeakRef
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mSource
			End Get
		#tag EndGetter
		Source As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		ToStartingLine As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		ToStartingLineCount As Integer
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
			Name="FromStartingLineCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ToStartingLine"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ToStartingLineCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Source"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AfterChanges"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BeforeChanges"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FromStartingLine"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
