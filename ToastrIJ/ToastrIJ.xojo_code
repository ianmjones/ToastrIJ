#tag Class
Protected Class ToastrIJ
Inherits WebControlWrapper
	#tag Event
		Sub SetupCSS(ByRef Styles() as WebControlCSS)
		  AddStyles Styles, ToastrIJ.Type.Info, InfoStyle, CloseButtonStyle, InfoIcon
		  AddStyles Styles, ToastrIJ.Type.Success, SuccessStyle, CloseButtonStyle, SuccessIcon
		  AddStyles Styles, ToastrIJ.Type.Warning, WarningStyle, CloseButtonStyle, WarningIcon
		  AddStyles Styles, ToastrIJ.Type.Error, ErrorStyle, CloseButtonStyle, ErrorIcon
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AddStyle(ByRef Styles() As WebControlCSS, Selector As String, Style As WebStyle)
		  dim newStyles() as WebControlCSS = WebControlCSS.Convert(Style)
		  
		  if newStyles.Ubound > -1 then
		    for each newStyle as WebControlCSS in newStyles
		      // Apply given selector, optionally with modifier such as ":hover" depending on WebStyle.
		      newStyle.Selector = selector + if(newStyle.Selector.NthField(":", 2).Trim.Len > 0, ":" + newStyle.Selector.NthField(":", 2).Trim, "")
		      Styles.Append newStyle
		    next
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddStyles(ByRef Styles() As WebControlCSS, Type As ToastrIJ.Type, Style As WebStyle, CloseButtonStyle As WebStyle = Nil, Icon As Picture = Nil)
		  dim selector as String = "#toast-container .toast-" + GetTypeName(Type).Lowercase
		  dim closeButtonSelector as String = selector + " .toast-close-button"
		  
		  if Style <> Nil then
		    // Base style for background and text.
		    AddStyle Styles, selector, Style
		    
		    // By default add same style to close button, optionally override.
		    AddStyle Styles, closeButtonSelector, Style
		  end if
		  
		  if CloseButtonStyle <> Nil then
		    AddStyle Styles, closeButtonSelector, CloseButtonStyle
		  end if
		  
		  if Icon <> Nil then
		    dim iconStyle as new WebControlCSS
		    iconStyle.Selector = selector
		    iconStyle.Value("background-image") = GetIconURL(Icon)
		    Styles.Append iconStyle
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CleanForJS(Source As String) As String
		  // Clean up for JavaScript and injections
		  
		  // Literals
		  Source = ReplaceAll(Source, "\b", "\\b")
		  Source = ReplaceAll(Source, "\f", "\\f")
		  Source = ReplaceAll(Source, "\n", "\\n")
		  Source = ReplaceAll(Source, "\r", "\\r")
		  Source = ReplaceAll(Source, "\t", "\\t")
		  
		  // Line breaks
		  Source = ReplaceLineEndings(Source, "<br />")
		  
		  // Escape quotes
		  Source = ReplaceAll(Source, """", "\""")
		  Source = ReplaceAll(Source, "'", "\'")
		  
		  return Source
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear(WithAnimation As Boolean = True)
		  dim js as String
		  
		  if WithAnimation then
		    js = "toastr.clear();"
		  else
		    js = "toastr.remove();"
		  end if
		  
		  ExecuteJavaScript js
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DerivePositionClass() As String
		  dim positionClass as String = "toast"
		  
		  select case VerticalPosition
		  case ToastrIJ.VerticalPosition.Bottom
		    positionClass = positionClass + "-bottom"
		    
		  else
		    positionClass = positionClass + "-top"
		    
		  end select
		  
		  select case HorizontalPosition
		  case ToastrIJ.HorizontalPosition.Left
		    positionClass = positionClass + "-left"
		    
		  case ToastrIJ.HorizontalPosition.Center
		    positionClass = positionClass + "-center"
		    
		  case ToastrIJ.HorizontalPosition.Full
		    positionClass = positionClass + "-full-width"
		    
		  else
		    positionClass = positionClass + "-right"
		    
		  end select
		  
		  return positionClass
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Display(Message As String, Type As ToastrIJ.Type = ToastrIJ.Type.Info, Sticky As Boolean = False)
		  Display(Message, Type, "", Sticky)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Display(Message As String, Type As ToastrIJ.Type = ToastrIJ.Type.Info, Icon As Picture)
		  Display(Message, Type, "", False, Icon)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Display(Message As String, Type As ToastrIJ.Type = ToastrIJ.Type.Info, Title As String = "", Sticky As Boolean = False, icon As Picture = Nil)
		  dim js as String = "var optionsOverride = {};"
		  
		  // Set position of the notification.
		  js = js + "toastr.options.positionClass = '" + DerivePositionClass + "';"
		  
		  // Should notifications include a close button?
		  js = js + "toastr.options.closeButton = " + Str(CloseButton or Sticky).Lowercase + ";"
		  
		  // Should notification stick around?
		  if Sticky then
		    js = js + "toastr.options.timeOut = 0;"
		    js = js + "toastr.options.extendedTimeOut = 0;"
		  else
		    js = js + "toastr.options.timeOut = " + Str(TimeOut) + ";"
		    js = js + "toastr.options.extendedTimeOut = " + Str(ExtendedTimeOut) + ";"
		  end if
		  
		  // Add new notifications to top or bottom of stack?
		  js = js + "toastr.options.newestOnTop =" + Str(NewestOnTop).Lowercase + ";"
		  
		  // Custom icon?
		  if Icon <> Nil then
		    js = js + GetCustomIconJS(Type, Icon)
		  end if
		  
		  // Set type of the notification.
		  dim toastrType as String = GetTypeName(Type).Lowercase
		  
		  // Construct notification.
		  js = js + "toastr." + toastrType + "('" + PrepareMessage(Message) + "'"
		  js = js + ", '" + PrepareTitle(Title) + "'"
		  js = js + ", optionsOverride"
		  js = js + ");"
		  
		  ExecuteJavaScript js
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetCustomIconJS(Type As ToastrIJ.Type, Icon As Picture) As String
		  me.IconID = me.IconID + 1
		  
		  dim toastrType as String = GetTypeName(Type).Lowercase
		  dim js As String = "optionsOverride.iconClass = 'toast-" + toastrType + " toast-icon-" + Str(me.IconID) + "';"
		  
		  js = js + "var newStyle = document.createElement('style');"
		  js = js + "newStyle.id = 'toast-icon-" + Str(me.IconID) + "';"
		  js = js + "var newCSS = document.createTextNode('#toast-container>.toast-" + toastrType + ".toast-icon-" + Str(me.IconID) + " { background-image: " + GetIconURL(Icon) + " !important; }');"
		  js = js + "newStyle.append(newCSS);"
		  js = js + "document.head.append(newStyle);"
		  
		  return js
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetIconURL(Icon As Picture) As String
		  dim url as string
		  dim mb as MemoryBlock = Icon.GetData(Picture.FormatPNG, 100)
		  
		  if mb <> nil then
		    url = EncodeBase64(mb.StringValue(0, mb.Size), 0)
		  end if
		  
		  if url.Len > 0 then
		    url = "url(data:image/png;base64," + url + ")"
		  end if
		  
		  return url
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetTypeName(Type As ToastrIJ.Type) As String
		  return me.TypeNames().Value(Type).StringValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function HorizontalPositionNames() As Dictionary
		  dim positions as new Dictionary
		  
		  positions.Value(ToastrIJ.HorizontalPosition.Right) = "Right"
		  positions.Value(ToastrIJ.HorizontalPosition.Center) = "Center"
		  positions.Value(ToastrIJ.HorizontalPosition.Left) = "Left"
		  positions.Value(ToastrIJ.HorizontalPosition.Full) = "Full"
		  
		  return positions
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function HTMLHeader(CurrentSession as WebSession) As String
		  // Make sure the libraries only get added to the header once.
		  dim sa() as string
		  
		  if not IsLibraryRegistered(CurrentSession, JavascriptNamespace, "jquery", 311) then
		    RegisterLibrary(CurrentSession, JavascriptNamespace, "jquery", 311)
		    sa.Append "<script src=""https://code.jquery.com/jquery-3.1.1.min.js""></script>"
		  end if
		  
		  if not IsLibraryRegistered(CurrentSession, JavascriptNamespace, "toastr", 213) then
		    RegisterLibrary(CurrentSession, JavascriptNamespace, "toastr", 213)
		    sa.Append "<link href=""https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.3/toastr.min.css"" rel=""stylesheet"" type=""text/css""/>"
		    sa.Append "<script src=""https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.3/toastr.min.js""></script>"
		  end if
		  
		  if sa.Ubound > -1 then
		    return join(sa,EndOfLine.UNIX)
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function PrepareMessage(Message As String) As String
		  Message = CleanForJS(Message.Trim)
		  
		  dim modifiedMessage as String = Message
		  
		  if RaiseEvent MessageToDisplay(modifiedMessage) then
		    Message = modifiedMessage
		  end if
		  
		  return Message
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function PrepareTitle(Title As String) As String
		  Title = CleanForJS(Title.Trim)
		  
		  dim modifiedTitle as String = Title
		  
		  if RaiseEvent TitleToDisplay(modifiedTitle) then
		    Title = modifiedTitle
		  end if
		  
		  return Title
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function TypeNames() As Dictionary
		  dim types as new Dictionary
		  
		  types.Value(Type.Info) = "Info"
		  types.Value(Type.Success) = "Success"
		  types.Value(Type.Warning) = "Warning"
		  types.Value(Type.Error) = "Error"
		  
		  return types
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function VerticalPositionNames() As Dictionary
		  dim positions as new Dictionary
		  
		  positions.Value(ToastrIJ.VerticalPosition.Top) = "Top"
		  positions.Value(ToastrIJ.VerticalPosition.Bottom) = "Bottom"
		  
		  return positions
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event MessageToDisplay(ByRef Message As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TitleToDisplay(ByRef Title As String) As Boolean
	#tag EndHook


	#tag Property, Flags = &h0
		CloseButton As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		CloseButtonStyle As WebStyle
	#tag EndProperty

	#tag Property, Flags = &h0
		ErrorIcon As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		ErrorStyle As WebStyle
	#tag EndProperty

	#tag Property, Flags = &h0
		ExtendedTimeOut As Integer = 1000
	#tag EndProperty

	#tag Property, Flags = &h0
		HorizontalPosition As ToastrIJ.HorizontalPosition
	#tag EndProperty

	#tag Property, Flags = &h21
		Private IconID As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		InfoIcon As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		InfoStyle As WebStyle
	#tag EndProperty

	#tag Property, Flags = &h0
		NewestOnTop As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		SuccessIcon As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		SuccessStyle As WebStyle
	#tag EndProperty

	#tag Property, Flags = &h0
		TimeOut As Integer = 5000
	#tag EndProperty

	#tag Property, Flags = &h0
		VerticalPosition As ToastrIJ.VerticalPosition
	#tag EndProperty

	#tag Property, Flags = &h0
		WarningIcon As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		WarningStyle As WebStyle
	#tag EndProperty


	#tag Constant, Name = JavascriptNamespace, Type = String, Dynamic = False, Default = \"IMJ.ToastrIJ", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ShowInTrayArea, Type = Boolean, Dynamic = False, Default = \"True", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ShowStyleProperty, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant


	#tag Enum, Name = HorizontalPosition, Type = Integer, Flags = &h0
		Right
		  Center
		  Left
		Full
	#tag EndEnum

	#tag Enum, Name = Type, Type = Integer, Flags = &h0
		Info
		  Success
		  Warning
		Error
	#tag EndEnum

	#tag Enum, Name = VerticalPosition, Type = Integer, Flags = &h0
		Top
		Bottom
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="CloseButton"
			Visible=true
			Group="Notification Options"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Cursor"
			Group="Behavior"
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
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ErrorIcon"
			Visible=true
			Group="Notification Icons"
			Type="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ExtendedTimeOut"
			Visible=true
			Group="Notification Options"
			InitialValue="1000"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="400"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
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
			Name="HorizontalPosition"
			Visible=true
			Group="Notification Position"
			Type="ToastrIJ.HorizontalPosition"
			EditorType="Enum"
			#tag EnumValues
				"0 - Right"
				"1 - Center"
				"2 - Left"
				"3 - Full"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InfoIcon"
			Visible=true
			Group="Notification Icons"
			Type="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Group="Position"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Group="Behavior"
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
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockVertical"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="NewestOnTop"
			Visible=true
			Group="Notification Options"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SuccessIcon"
			Visible=true
			Group="Notification Icons"
			Type="Picture"
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
			Name="TimeOut"
			Visible=true
			Group="Notification Options"
			InitialValue="5000"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Group="Position"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="VerticalCenter"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="VerticalPosition"
			Visible=true
			Group="Notification Position"
			Type="ToastrIJ.VerticalPosition"
			EditorType="Enum"
			#tag EnumValues
				"0 - Top"
				"1 - Bottom"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="WarningIcon"
			Visible=true
			Group="Notification Icons"
			Type="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="300"
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
			Name="_VerticalPercent"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
