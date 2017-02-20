#tag Class
Protected Class ToastrIJ
Inherits WebControlWrapper
	#tag Method, Flags = &h0
		Sub Display(Message As String, Type As ToastrIJ.Type = ToastrIJ.Type.Info, Title As String = "")
		  dim toastrType as String = "info"
		  
		  select case Type
		  case ToastrIJ.Type.Success
		    toastrType = "success"
		    
		  case ToastrIJ.Type.Warning
		    toastrType = "warning"
		    
		  case ToastrIJ.Type.Error
		    toastrType = "error"
		    
		  end select
		  
		  
		  dim js as String = "toastr." + toastrType + "('" + Message.Trim.ReplaceAll(EndOfLine, "<br/>") + "'"
		  
		  if Title.Trim.Len > 0 then
		    js = js + ", '" + Title.Trim + "'"
		  end if
		  
		  js = js + ");"
		  
		  ExecuteJavaScript js
		End Sub
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


	#tag Constant, Name = JavascriptNamespace, Type = String, Dynamic = False, Default = \"IMJ.ToastrIJ", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ShowInTrayArea, Type = Boolean, Dynamic = False, Default = \"True", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ShowStyleProperty, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant


	#tag Enum, Name = Type, Type = Integer, Flags = &h0
		Info
		  Success
		  Warning
		Error
	#tag EndEnum


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
			Visible=true
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
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockHorizontal"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockVertical"
			Visible=true
			Group="Behavior"
			InitialValue="False"
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
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
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
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Behavior"
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
