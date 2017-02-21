#tag Class
Protected Class ToastrIJ
Inherits WebControlWrapper
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
		Sub Display(Message As String, Type As ToastrIJ.Type = ToastrIJ.Type.Info, Title As String = "")
		  dim js as String
		  
		  // Set position of the notification.
		  js = js + "toastr.options.positionClass = '" + DerivePositionClass + "';"
		  
		  // Set type of the notification.
		  dim toastrType as String = "info"
		  
		  select case Type
		  case ToastrIJ.Type.Success
		    toastrType = "success"
		    
		  case ToastrIJ.Type.Warning
		    toastrType = "warning"
		    
		  case ToastrIJ.Type.Error
		    toastrType = "error"
		    
		  end select
		  
		  // Construct notification.
		  js = js + "toastr." + toastrType + "('" + PrepareMessage(Message) + "'"
		  
		  if Title.Trim.Len > 0 then
		    js = js + ", '" + PrepareTitle(Title) + "'"
		  end if
		  
		  js = js + ");"
		  
		  ExecuteJavaScript js
		End Sub
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
		HorizontalPosition As ToastrIJ.HorizontalPosition
	#tag EndProperty

	#tag Property, Flags = &h0
		VerticalPosition As ToastrIJ.VerticalPosition
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
