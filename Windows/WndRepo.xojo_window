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
   Height          =   722
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1406697471
   MenuBarVisible  =   True
   MinimumHeight   =   480
   MinimumWidth    =   640
   Resizeable      =   True
   Title           =   "gitmas"
   Type            =   "0"
   Visible         =   True
   Width           =   958
   Begin Label Labels
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   0
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   True
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
      Top             =   30
      Transparent     =   False
      Underline       =   False
      Value           =   "Current Branch:"
      Visible         =   True
      Width           =   102
   End
   Begin Label LblCurrentBranch
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   123
      LockBottom      =   False
      LockedInPosition=   True
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
      Top             =   30
      Transparent     =   False
      Underline       =   False
      Value           =   "Unknown"
      Visible         =   True
      Width           =   815
   End
   Begin DiffLineListbox LbLines
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   True
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   2
      ColumnWidths    =   ",75"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   20
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
      Height          =   542
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Line	Count"
      Italic          =   False
      Left            =   20
      LineValueColumn =   0
      LockBottom      =   True
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MonoFontName    =   ""
      MonoFontSize    =   0
      RequiresSelection=   False
      RowSelectionType=   "1"
      Scope           =   2
      ShowNoContent   =   True
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   72
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   319
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin PlatformPushButton BtnStage
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Stage"
      Default         =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   259
      LockBottom      =   True
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   626
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin PlatformPushButton BtnRevert
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Revert..."
      Default         =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   167
      LockBottom      =   True
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      MacButtonStyle  =   "0"
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   626
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin M_Git.Repo MyRepo
      CurrentBranch   =   ""
      EOL             =   ""
      Index           =   -2147483648
      LockedInPosition=   True
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin Label LblRepoPath
      AllowAutoDeactivate=   True
      Bold            =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextAlignment   =   "0"
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   8
      Transparent     =   False
      Underline       =   False
      Value           =   "Unknown"
      Visible         =   True
      Width           =   918
   End
   Begin DiffLineListbox LbLineFiles
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   True
      AllowFocusRing  =   True
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   3
      ColumnWidths    =   "60,60"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   20
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      GridLinesHorizontalStyle=   "0"
      GridLinesVerticalStyle=   "0"
      HasBorder       =   True
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   574
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   351
      LineValueColumn =   2
      LockBottom      =   True
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MonoFontName    =   ""
      MonoFontSize    =   0
      RequiresSelection=   False
      RowSelectionType=   "1"
      Scope           =   2
      ShowNoContent   =   False
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   72
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   587
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Activate()
		  MyRepo.Refresh
		  //
		  // Will raise the Changed event if anything is different
		  //
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function GetSelectedLines() As M_Git.DiffLine()
		  var arr() as M_Git.DiffLine
		  
		  for row as integer = 0 to LbLines.RowCount - 1
		    if LbLines.Selected( row ) then
		      var rowArr() as M_Git.DiffLine = LbLines.RowTagAt( row )
		      for each dl as M_Git.DiffLine in rowArr
		        arr.AddRow dl
		      next
		    end if
		  next
		  
		  return arr
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function LinesMatching(line As M_Git.DiffLine) As M_Git.DiffLine()
		  var key as string = line.Value.Trim
		  
		  for row as integer = 0 to LbLines.LastRowIndex
		    var rowKey as string = LbLines.CellValueAt( row, 0 )
		    if rowKey = key then
		      return LbLines.RowTagAt( row )
		    end if
		  next
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MaybeRevert(lines() As M_Git.DiffLine) As Boolean
		  if QuickRequestDialog( self, "Really revert these lines?", "This cannot be undone.", "Revert" ) = "Revert" then
		    MyRepo.RevertLines( lines )
		    return true
		  end if
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshFromRepo()
		  //
		  // Refresh the current data from the repo
		  //
		  
		  if GitFolder is nil then
		    return
		  end if
		  
		  lblRepoPath.Value = GitFolder.NativePath
		  lblCurrentBranch.Value = MyRepo.CurrentBranch
		  var diffs() as M_Git.DiffFile = MyRepo.Diffs
		  
		  //
		  // Harvest the lines
		  //
		  var lineDict as new Dictionary
		  
		  for each df as M_Git.DiffFile in diffs
		    if df.IsBinaryFile then
		      //
		      // Ignore these
		      //
		      continue for df
		    end if
		    
		    for each hunk as M_Git.Hunk in df.Hunks
		      for each dl as M_Git.DiffLine in hunk.Lines
		        if dl.IsUnchanged or dl.LineType = M_Git.LineTypes.NoTrailingNewline then
		          //
		          // Don't care
		          //
		          continue for dl
		        end if
		        
		        var indicator as string = dl.Symbol
		        var key as string = indicator + dl.Value.Trim 
		        
		        var arr() as M_Git.DiffLine 
		        arr = lineDict.Lookup( key, arr )
		        arr.Append( dl )
		        lineDict.Value( key ) = arr
		      next
		    next
		  next
		  
		  //
		  // Fill in the listbox
		  //
		  var lbLinesScrollPosition as integer = LbLines.ScrollPosition
		  var lbLinesSelectedRows() as integer = LbLines.SelectedRows
		  var lbFilesScrollPosition as integer = LbLineFiles.ScrollPosition
		  var lbFilesSelectedRows() as integer = LbLineFiles.SelectedRows
		  
		  LbLines.RemoveAllRows
		  for each key as string in lineDict.Keys
		    var arr() as M_Git.DiffLine = lineDict.Value( key )
		    LbLines.AddRow( key.Middle( 1 ) ) // Remove the indicator
		    LbLines.CellValueAt( LbLines.LastRowIndex, 1 ) = arr.Count.ToString
		    lbLines.RowTagAt( LbLines.LastRowIndex ) = arr
		  next
		  
		  LbLines.Sort
		  LbLines.SelectedRows = lbLinesSelectedRows
		  LbLines.ScrollPosition = lbLinesScrollPosition
		  LbLineFiles.SelectedRows = lbFilesSelectedRows
		  LbLineFiles.ScrollPosition = lbFilesScrollPosition
		  
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshLineFiles()
		  LbLineFiles.RemoveAllRows
		  
		  //
		  // Get the selected lines
		  //
		  var lines() as M_Git.DiffLine
		  for row as integer = 0 to LbLines.RowCount - 1
		    if LbLines.Selected( row ) then
		      var thisArr() as M_Git.DiffLine = LbLines.RowTagAt( row )
		      for each line as M_Git.DiffLine in thisArr
		        lines.AddRow line
		      next
		    end if
		  next
		  
		  //
		  // Split them up by hunks
		  //
		  var hunkDict as new Dictionary
		  var hunks() as M_Git.Hunk
		  
		  for each line as M_Git.DiffLine in lines
		    var hunk as M_Git.Hunk = line.Parent
		    
		    var lineArr() as M_Git.DiffLine
		    if hunkDict.HasKey( hunk ) then
		      lineArr = hunkDict.Value( hunk )
		    else
		      hunks.AddRow( hunk )
		      hunkDict.Value( hunk ) = lineArr
		    end if
		    
		    lineArr.AddRow( line )
		  next
		  
		  //
		  // Now split them up by files
		  //
		  var fileDict as new Dictionary
		  var files() as M_Git.DiffFile
		  
		  for each hunk as M_Git.Hunk in hunks
		    var file as M_Git.DiffFile = hunk.Parent
		    
		    var hunkArr() as M_Git.Hunk
		    if fileDict.HasKey( file ) then
		      hunkArr = fileDict.Value( file )
		    else
		      files.AddRow( file )
		      fileDict.Value( file ) = hunkArr
		    end if
		    
		    hunkArr.AddRow( hunk )
		  next
		  
		  //
		  // Fill in the listbox
		  //
		  for each file as M_Git.DiffFile in files
		    LbLineFiles.AddExpandableRow( file.ToPathSpec )
		    for col as integer = 1 to lbLineFiles.ColumnCount - 1
		      LbLineFiles.CellValueAt( LbLineFiles.LastAddedRowIndex, col ) = file.ToPathSpec // Needs something so it will draw
		    next
		    
		    LbLineFiles.RowTagAt( LbLineFiles.LastAddedRowIndex ) = fileDict.Value( file )
		    LbLineFiles.CellTagAt( LbLineFiles.LastAddedRowIndex, 0 ) = file
		    
		    //
		    // Expand the row as needed
		    //
		    if IsFileRowExpandedDict.Lookup( EncodeHex( file.ToPathSpec ), true ) then
		      LbLineFiles.RowExpandedAt( LbLineFiles.LastAddedRowIndex ) = true
		    end if
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Show(repoPath As FolderItem)
		  Super.Show()
		  
		  try
		    MyRepo.GitFolder = repoPath
		    
		  catch err as M_Git.GitException
		    MessageBox "This does not appear to be a git repo"
		    Close
		    return
		  end try
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StageSelectedLines()
		  var selected() as M_Git.DiffLine = GetSelectedLines
		  MyRepo.StageLines( selected )
		  
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if MyRepo isa object then
			    return MyRepo.GitFolder
			  end if
			  
			End Get
		#tag EndGetter
		GitFolder As FolderItem
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  if mIsFileRowExpandedDict is nil then
			    mIsFileRowExpandedDict = new Dictionary
			  end if
			  
			  return mIsFileRowExpandedDict
			End Get
		#tag EndGetter
		Private Shared IsFileRowExpandedDict As Dictionary
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private IsShowingError As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared mIsFileRowExpandedDict As Dictionary
	#tag EndProperty


	#tag Constant, Name = kCaptionCollapseAll, Type = String, Dynamic = False, Default = \"Collapse All", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kCaptionExpandAll, Type = String, Dynamic = False, Default = \"Expand All", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kCaptionOpenFiles, Type = String, Dynamic = False, Default = \"Open Files", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kCaptionRevertAllLinesLikeThese, Type = String, Dynamic = False, Default = \"Revert All Lines Like These...", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kCaptionRevertTheseLines, Type = String, Dynamic = False, Default = \"Revert These Lines...", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kCaptionShowFiles, Type = String, Dynamic = False, Default = \"Show Files On Disk", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kCaptionStageAllLikeThese, Type = String, Dynamic = False, Default = \"Stage All Lines Like These", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kCaptionStageTheseLines, Type = String, Dynamic = False, Default = \"Stage These Lines", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events LbLines
	#tag Event
		Sub Change()
		  var isEnabled as boolean = me.SelectedRowCount <> 0
		  BtnStage.Enabled = isEnabled
		  BtnRevert.Enabled = isEnabled
		  RefreshLineFiles
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  me.SortingColumn = 1
		  me.HeadingIndex = 1
		  me.ColumnSortDirectionAt( 1 ) = ListBox.SortDirections.Descending
		  
		  me.ColumnAlignmentAt( 1 ) = ListBox.Alignments.Right
		  
		  me.MonoFontName = App.MonoFontName
		  me.MonoFontSize = App.MonoFontSize
		End Sub
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  #pragma unused x
		  #pragma unused y
		  
		  var lines() as M_Git.DiffLine = GetSelectedLines
		  
		  base.AddMenu( new MenuItem( kCaptionStageTheseLines, lines ) )
		  base.AddMenu( new MenuItem( kCaptionRevertTheseLines, lines ) )
		  
		  return true
		  
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  select case hitItem.Value
		  case kCaptionStageTheseLines
		    MyRepo.StageLines( hitItem.Tag )
		    return true
		    
		  case kCaptionRevertTheseLines
		    call MaybeRevert( hitItem.Tag )
		    return true
		    
		  end select
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events BtnStage
	#tag Event
		Sub Action()
		  StageSelectedLines
		  RefreshFromRepo
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BtnRevert
	#tag Event
		Sub Action()
		  call MaybeRevert( GetSelectedLines )
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MyRepo
	#tag Event , Description = 546865206769742073746174757320686173206368616E6765642E
		Sub Changed()
		  RefreshFromRepo
		  
		End Sub
	#tag EndEvent
	#tag Event , Description = 5265706F727420616E20657863657074696F6E2074686174206F6363757272656420647572696E6720526566726573682E
		Sub RefreshError(err As RuntimeException)
		  if IsShowingError then
		    return
		  end if
		  
		  IsShowingError = true
		  
		  var ti as Introspection.TypeInfo = Introspection.GetType( err )
		  var msg as string = "A " + ti.Name + " exception occurred while refreshing the repo"
		  msg = msg.Trim
		  
		  var button as string = GuiHelpers.QuickRequestDialog( self, msg, err.Message, "Close", "Try Again" )
		  
		  if button = "Close" then
		    self.Close
		  end if
		  
		  IsShowingError = false
		  
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LbLineFiles
	#tag Event
		Sub ExpandRow(row As Integer)
		  var hunks() as M_Git.Hunk = me.RowTagAt( row )
		  
		  for hunkIndex as integer = 0 to hunks.LastRowIndex
		    var hunk as M_Git.Hunk = hunks( hunkIndex )
		    
		    for each line as M_Git.DiffLine in hunk.Lines
		      me.AddRow( "" )
		      
		      if line.LineType <> M_Git.LineTypes.NoTrailingNewline then
		        if line.FromLine <> -1 then
		          me.CellValueAt( me.LastAddedRowIndex, 0 ) = line.FromLine.ToString
		        end if
		        if line.ToLine <> -1 then
		          me.CellValueAt( me.LastAddedRowIndex, 1 ) = line.ToLine.ToString
		        end if
		      end if
		      
		      me.CellValueAt( me.LastAddedRowIndex, 2 ) = line.Value
		      me.RowTagAt( me.LastAddedRowIndex ) = line
		      
		      me.CellBorderLeftAt( me.LastAddedRowIndex, 2 ) = Listbox.Borders.ThinSolid
		      me.CellAlignmentAt( me.LastAddedRowIndex, 0 ) = Listbox.Alignments.Right
		      me.CellAlignmentAt( me.LastAddedRowIndex, 1 ) = Listbox.Alignments.Right
		      me.CellAlignmentOffsetAt( me.LastAddedRowIndex, 2 ) = 15
		    next
		    
		    if hunkIndex < hunks.LastRowIndex then
		      me.AddRow "..."
		    end if
		  next
		  
		  var df as M_Git.DiffFile = me.CellTagAt( row, 0 )
		  IsFileRowExpandedDict.Value( EncodeHex( df.ToPathSpec ) ) = true
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function CellTextPaint(g As Graphics, row As Integer, column As Integer, x as Integer, y as Integer) As Boolean
		  #pragma unused g
		  #pragma unused column
		  #pragma unused x
		  #pragma unused y
		  
		  if me.ExpandableRowAt( row ) then
		    return true
		  end if
		  
		  if column = me.ColumnCount - 1 then
		    var line as M_Git.DiffLine = me.RowTagAt( row )
		    
		    if line.IsAddition or line.IsSubtraction then
		      me.FontName = me.MonoFontName
		      me.FontSize = me.MonoFontSize
		      g.Bold = true
		      g.DrawText( line.Value, x, y )
		      return true
		    end if
		  end if
		End Function
	#tag EndEvent
	#tag Event
		Function CellBackgroundPaint(g As Graphics, row As Integer, column As Integer) As Boolean
		  const kBuffer as integer = 25
		  const kHeightBuffer as integer = 4
		  
		  if row >= me.RowCount then
		    return true
		  end if
		  
		  if me.ExpandableRowAt( row ) then
		    var spec as string = me.CellValueAt( row, 0 )
		    
		    g.FontName = me.FontName
		    g.FontSize = me.FontSize
		    g.Bold = true
		    var startingX as integer = column * me.ColumnAt( 0 ).WidthActual
		    
		    const kLightColor as color = Color.White
		    const kDarkColor as color = Color.DarkGray
		    
		    var textColor as color
		    var backColor as color
		    
		    if IsDarkMode then
		      textColor = kDarkColor
		      backColor = kLightColor
		    else
		      textColor= kLightColor
		      backColor = kDarkColor
		    end if
		    
		    const kArc as integer = 20
		    const kRoundRectBuffer as integer = 50
		    
		    var useX as integer = 0 - startingX + kBuffer
		    var useY as integer = g.Height - kHeightBuffer
		    
		    g.DrawingColor = backColor
		    if column = 0 then
		      g.FillRoundRectangle( useX - 5, 0, g.Width + 50, g.Height, kArc, kArc )
		    elseif column = me.ColumnCount - 1 then
		      g.FillRoundRectangle( 0 - kRoundRectBuffer, 0, g.Width + kRoundRectBuffer, g.Height, kArc, kArc )
		    else
		      g.FillRectangle( 0, 0, g.Width, g.Height )
		    end if
		    
		    g.DrawingColor = textColor
		    g.DrawText( spec, useX, useY )
		    return true
		    
		  elseif row < me.RowCount and column = me.LineValueColumn then
		    var tag as variant = me.RowTagAt( row )
		    var line as M_Git.DiffLine = tag
		    var drawIt as boolean
		    
		    if line is nil then
		      //
		      // Do nothing
		      //
		      
		    elseif line.IsAddition then
		      if IsDarkMode then
		        g.DrawingColor = DiffLineListbox.kColorAddition
		      else
		        g.DrawingColor = &cC0FFAD00
		      end if
		      drawIt = true
		      
		    elseif line.IsSubtraction then
		      if IsDarkMode then
		        g.DrawingColor = DiffLineListbox.kColorSubtraction
		      else
		        g.DrawingColor = &cFFA29F00
		      end if
		      drawIt = true
		    end if
		    
		    if drawIt then
		      g.FillRoundRectangle( 5, 1, g.Width - 10, g.Height - 2, 20, 20 )
		    end if
		    
		    return drawIt
		    
		  end if
		  
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub CollapseRow(row As Integer)
		  var df as M_Git.DiffFile = me.CellTagAt( row, 0 )
		  IsFileRowExpandedDict.Value( EncodeHex( df.ToPathSpec ) ) = false
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  #pragma unused x
		  #pragma unused y
		  
		  //
		  // Add the standard options
		  //
		  base.AddMenu( new MenuItem( kCaptionExpandAll ) )
		  base.AddMenu( new MenuItem( kCaptionCollapseAll ) )
		  
		  //
		  // See what's selected
		  //
		  var selectedRows() as integer = me.SelectedRows
		  
		  var files() as M_Git.DiffFile
		  var lines() as M_Git.DiffLine
		  
		  for each row as integer in selectedRows
		    if me.ExpandableRowAt( row ) then
		      files.AddRow( me.CellTagAt( row, 0 ) )
		    else
		      lines.AddRow( me.RowTagAt( row ) )
		    end if
		  next
		  
		  if files.Count <> 0 then
		    base.AddMenu( new MenuItem( MenuItem.TextSeparator ) )
		    base.AddMenu( new MenuItem( kCaptionOpenFiles, files ) )
		    base.AddMenu( new MenuItem( kCaptionShowFiles, files ) )
		  end if
		  
		  if lines.Count <> 0 then
		    base.AddMenu( new MenuItem( MenuItem.TextSeparator ) )
		    base.AddMenu( new MenuItem( kCaptionStageTheseLines, lines ) )
		    base.AddMenu( new MenuItem( kCaptionStageAllLikeThese, lines ) )
		    
		    base.AddMenu( new MenuItem( MenuItem.TextSeparator ) )
		    base.AddMenu( new MenuItem( kCaptionRevertTheseLines, lines ) )
		    base.AddMenu( new MenuItem( kCaptionRevertAllLinesLikeThese, lines ) )
		  end if
		  
		  return true
		  
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  var lines() as M_Git.DiffLine
		  var likeThese as boolean
		  var isRevert as boolean
		  var isStage as boolean
		  
		  select case hitItem.Value
		  case kCaptionExpandAll
		    me.ExpandAll
		    return true
		    
		  case kCaptionCollapseAll
		    me.CollapseAll
		    return true
		    
		  case kCaptionOpenFiles
		    var files() as M_Git.DiffFile = hitItem.Tag
		    for each file as M_Git.DiffFile in files
		      file.ToFile.Open
		    next
		    return true
		    
		  case kCaptionShowFiles
		    var files() as M_Git.DiffFile = hitItem.Tag
		    for each file as M_Git.DiffFile in files
		      file.ToFile.Parent.Open
		    next
		    return true
		    
		  case kCaptionStageTheseLines
		    lines = hitItem.Tag
		    isStage = true
		    
		  case kCaptionStageAllLikeThese
		    lines = hitItem.Tag
		    isStage = true
		    likeThese = true
		    
		  case kCaptionRevertTheseLines
		    lines = hitItem.Tag
		    isRevert = true
		    
		  case kCaptionRevertAllLinesLikeThese
		    lines = hitItem.Tag
		    isRevert = true
		    likeThese = true
		    
		  end select
		  
		  if likeThese then
		    var realLines() as M_Git.DiffLine
		    
		    for each iline as M_Git.DiffLine in lines
		      for each line as M_Git.DiffLine in LinesMatching( iline )
		        realLines.AddRow( line )
		      next
		    next
		    lines = realLines
		  end if
		  
		  if isStage then
		    MyRepo.StageLines( lines )
		    LbLineFiles.SelectedRowIndex = -1
		    return true
		    
		  elseif isRevert then
		    if MaybeRevert( lines ) then
		      LbLineFiles.SelectedRowIndex = -1
		    end if
		    return true
		    
		  end if
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub Open()
		  me.MonoFontName = App.MonoFontName
		  me.MonoFontSize = App.MonoFontSize
		  
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
