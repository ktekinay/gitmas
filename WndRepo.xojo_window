#tag Window
Begin Window WndRepo
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   "0"
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   400
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1406697471
   MenuBarVisible  =   True
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "gitmas"
   Type            =   "0"
   Visible         =   True
   Width           =   600
   Begin Label Labels
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   0
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Value           =   "Current Branch:"
      Visible         =   True
      Width           =   121
   End
   Begin Label LblCurrentBranch
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   171
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Value           =   "Unknown"
      Visible         =   True
      Width           =   409
   End
   Begin Listbox LbLines
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   True
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   2
      ColumnWidths    =   "70%"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontalStyle=   "0"
      GridLinesVerticalStyle=   "0"
      HasBorder       =   True
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   277
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Line	Count"
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      RowSelectionType=   "0"
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   103
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   560
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Activate()
		  RefreshFromRepo
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub RefreshFromRepo()
		  //
		  // Refresh the current data from the repo
		  //
		  
		  if Repo is nil then
		    return
		  end if
		  
		  lblCurrentBranch.Value = Repo.CurrentBranch
		  var diffs() as Git_MTC.DiffFile = Repo.GetDiffs
		  
		  //
		  // Harvest the lines
		  //
		  var lineDict as new Dictionary
		  
		  for each df as Git_MTC.DiffFile in diffs
		    for each hunk as Git_MTC.Hunk in df.Hunks
		      for each dl as Git_MTC.DiffLine in hunk.Lines
		        var indicator as string
		        select case dl.LineType
		        case Git_MTC.LineTypes.Unchanged
		          //
		          // Don't care
		          //
		          continue for dl
		          
		        case Git_MTC.LineTypes.Addition
		          indicator = "+"
		          
		        case Git_MTC.LineTypes.Subtraction
		          indicator = "-"
		          
		        end select
		        
		        var key as string = indicator + dl.Value.Trim // 0, 1, or 2 to indicate type
		        
		        var arr() as Git_MTC.DiffLine 
		        arr = lineDict.Lookup( key, arr )
		        arr.Append( dl )
		        lineDict.Value( key ) = arr
		      next
		    next
		  next
		  
		  //
		  // Fill in the listbox
		  //
		  LbLines.RemoveAllRows
		  for each key as string in lineDict.Keys
		    var arr() as Git_MTC.DiffLine = lineDict.Value( key )
		    LbLines.AddRow( key ) // Remove the indicator
		    LbLines.CellValueAt( LbLines.LastRowIndex, 1 ) = arr.Count.ToString
		    lbLines.RowTagAt( LbLines.LastRowIndex ) = arr
		  next
		  
		  LbLines.Sort
		  
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Show(repoPath As FolderItem)
		  Super.Show()
		  
		  try
		    Repo = new Git_MTC.Repo( repoPath )
		  catch err as Git_MTC.GitException
		    MessageBox "This does not appear to be a git repo"
		    Close
		    return
		  end try
		  
		  RefreshFromRepo
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Repo As Git_MTC.Repo
	#tag EndProperty


#tag EndWindowCode

#tag Events LbLines
	#tag Event
		Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  if column <> 1 then
		    return false
		  end if
		  
		  var arr1() as Git_MTC.DiffLine = me.RowTagAt( row1 )
		  var arr2() as Git_MTC.DiffLine = me.RowTagAt( row2 )
		  
		  result = arr1.Count - arr2.Count
		  
		  if result = 0 then
		    //
		    // Let's see if these lines appear next to each other anywhere
		    //
		    for each dl1 as Git_MTC.DiffLine in arr1
		      for each dl2 as Git_MTC.DiffLine in arr2
		        if dl2.Parent = dl1.Parent then
		          //
		          // Same hunk
		          //
		          if dl1.LineType <> dl2.LineType then
		            //
		            // They are different line types, so we will list the subtraction before the addition
		            //
		            result = integer( dl2.LineType ) - integer( dl1.LineType )
		          else
		            //
		            // Same type, so let's get the relative result
		            //
		            result = ( dl1.FromLine - dl2.FromLine ) + ( dl1.ToLine - dl2.ToLine )
		          end if
		          
		          exit for dl1 // We're done
		        end if
		      next
		    next
		    
		    //
		    // If it's a reverse sort, we need to flip the result
		    //
		    if me.ColumnSortDirectionAt( 1 ) = ListBox.SortDirections.Descending then
		      result = 0 - result
		    end if
		  end if
		  
		  if result = 0 then
		    //
		    // Couldn't find the result in any other way, so let's use the name
		    //
		    result = me.CellValueAt( row1, 0 ).Compare( me.CellValueAt( row2, 0 ) )
		  end if
		  
		  return true
		End Function
	#tag EndEvent
	#tag Event
		Sub Open()
		  me.SortingColumn = 1
		  me.HeadingIndex = 1
		  me.ColumnSortDirectionAt( 1 ) = ListBox.SortDirections.Descending
		End Sub
	#tag EndEvent
#tag EndEvents
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
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="MenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
