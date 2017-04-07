#tag WebPage
Begin WebPage MainPage
   Compatibility   =   ""
   Cursor          =   0
   Enabled         =   True
   Height          =   600
   HelpTag         =   ""
   HorizontalCenter=   0
   ImplicitInstance=   True
   Index           =   -2147483648
   IsImplicitInstance=   False
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   LockVertical    =   False
   MinHeight       =   400
   MinWidth        =   600
   Style           =   "None"
   TabOrder        =   0
   Title           =   "ToastrIJ"
   Top             =   0
   VerticalCenter  =   0
   Visible         =   True
   Width           =   800
   ZIndex          =   1
   _DeclareLineRendered=   False
   _HorizontalPercent=   0.0
   _ImplicitInstance=   False
   _IsEmbedded     =   False
   _Locked         =   False
   _NeedsRendering =   True
   _OfficialControl=   False
   _OpenEventFired =   False
   _ShownEventFired=   False
   _VerticalPercent=   0.0
   Begin ToastrIJ Toastr
      CloseButton     =   False
      Cursor          =   0
      Enabled         =   True
      ErrorIcon       =   0
      ExtendedTimeOut =   1000
      Height          =   400
      HelpTag         =   ""
      HorizontalCenter=   0
      HorizontalPosition=   "0"
      Index           =   -2147483648
      InfoIcon        =   0
      Left            =   120
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   True
      NewestOnTop     =   True
      Scope           =   2
      Style           =   "-1"
      SuccessIcon     =   0
      TabOrder        =   -1
      TimeOut         =   5000
      Top             =   120
      VerticalCenter  =   0
      VerticalPosition=   "0"
      Visible         =   True
      WarningIcon     =   0
      Width           =   300
      ZIndex          =   1
      _DeclareLineRendered=   False
      _HorizontalPercent=   0.0
      _IsEmbedded     =   False
      _Locked         =   False
      _NeedsRendering =   True
      _OfficialControl=   False
      _OpenEventFired =   False
      _VerticalPercent=   0.0
   End
   Begin DemoContainer DemoArea
      Cursor          =   0
      Enabled         =   True
      Height          =   422
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   100
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   True
      Scope           =   0
      ScrollbarsVisible=   0
      Style           =   "488470527"
      TabOrder        =   0
      Top             =   89
      VerticalCenter  =   0
      Visible         =   True
      Width           =   600
      ZIndex          =   1
      _DeclareLineRendered=   False
      _HorizontalPercent=   0.0
      _IsEmbedded     =   False
      _Locked         =   False
      _NeedsRendering =   True
      _OfficialControl=   False
      _OpenEventFired =   False
      _ShownEventFired=   False
      _VerticalPercent=   0.0
   End
   Begin WebLink Icons8Link
      Cursor          =   0
      Enabled         =   True
      HasFocusRing    =   True
      Height          =   22
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   300
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   True
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   False
      Multiline       =   False
      Scope           =   0
      Style           =   "-1"
      TabOrder        =   1
      Target          =   2
      Text            =   "Custom Icon from Icons8"
      TextAlign       =   2
      Top             =   558
      URL             =   "https://icons8.com/web-app/13889/Toaster#filled"
      VerticalCenter  =   0
      Visible         =   True
      Width           =   200
      ZIndex          =   1
      _NeedsRendering =   True
   End
End
#tag EndWebPage

#tag WindowCode
#tag EndWindowCode

#tag Events Toastr
	#tag Event
		Sub Open()
		  //
		  // Uncomment following to change styles of notifications.
		  //
		  // me.InfoStyle = DarkInfoStyle
		  // me.SuccessStyle = DarkSuccessStyle
		  // me.WarningStyle = DarkWarningStyle
		  // me.ErrorStyle = DarkErrorStyle
		  // 
		  // me.CloseButtonStyle = DarkCloseButtonStyle
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DemoArea
	#tag Event
		Sub DisplayMessage(Message As String, Type As ToastrIJ.Type, Title As String, Sticky As Boolean, CustomIcon As Boolean)
		  dim pic As Picture
		  
		  if CustomIcon then
		    pic = ToasterIcon
		  end if
		  
		  Toastr.Display Message, Type, Title, Sticky, pic
		End Sub
	#tag EndEvent
	#tag Event
		Sub VerticalPositionChanged(Position As ToastrIJ.VerticalPosition)
		  Toastr.VerticalPosition = Position
		End Sub
	#tag EndEvent
	#tag Event
		Sub HorizontalPositionChanged(Position As ToastrIJ.HorizontalPosition)
		  Toastr.HorizontalPosition = Position
		End Sub
	#tag EndEvent
	#tag Event
		Sub ClearMessages(WithAnimation As Boolean = True)
		  Toastr.Clear(WithAnimation)
		End Sub
	#tag EndEvent
	#tag Event
		Sub CloseButtonChanged(Value As Boolean)
		  Toastr.CloseButton = Value
		End Sub
	#tag EndEvent
	#tag Event
		Sub TimeOutChanged(Value As Integer)
		  Toastr.TimeOut = Value
		End Sub
	#tag EndEvent
	#tag Event
		Sub ExtendedTimeOutChanged(Value As Integer)
		  Toastr.ExtendedTimeOut = Value
		End Sub
	#tag EndEvent
	#tag Event
		Sub NewestOnTopChanged(Value As Boolean)
		  Toastr.NewestOnTop = Value
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Cursor"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Automatic"
			"1 - Standard Pointer"
			"2 - Finger Pointer"
			"3 - IBeam"
			"4 - Wait"
			"5 - Help"
			"6 - Arrow All Directions"
			"7 - Arrow North"
			"8 - Arrow South"
			"9 - Arrow East"
			"10 - Arrow West"
			"11 - Arrow Northeast"
			"12 - Arrow Northwest"
			"13 - Arrow Southeast"
			"14 - Arrow Southwest"
			"15 - Splitter East West"
			"16 - Splitter North South"
			"17 - Progress"
			"18 - No Drop"
			"19 - Not Allowed"
			"20 - Vertical IBeam"
			"21 - Crosshair"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HorizontalCenter"
		Group="Behavior"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Index"
		Group="ID"
		InitialValue="-2147483648 "
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="IsImplicitInstance"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockHorizontal"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockVertical"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Behavior"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabOrder"
		Group="Behavior"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="VerticalCenter"
		Group="Behavior"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Behavior"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ZIndex"
		Group="Behavior"
		InitialValue="1"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_DeclareLineRendered"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_HorizontalPercent"
		Group="Behavior"
		Type="Double"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_ImplicitInstance"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_IsEmbedded"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_Locked"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_NeedsRendering"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_OfficialControl"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_OpenEventFired"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_ShownEventFired"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_VerticalPercent"
		Group="Behavior"
		Type="Double"
	#tag EndViewProperty
#tag EndViewBehavior
