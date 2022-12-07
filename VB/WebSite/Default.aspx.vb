Imports Microsoft.VisualBasic
Imports System
Imports DevExpress.Web

Partial Public Class _Default
	Inherits System.Web.UI.Page
	Protected Sub grid_CustomCallback(ByVal sender As Object, ByVal e As ASPxGridViewCustomCallbackEventArgs)
		Dim gridView As ASPxGridView = CType(sender, ASPxGridView)
		For Each column As GridViewColumn In gridView.Columns
			If Convert.ToBoolean(hf("columnsInWindow")) Then
				If column.Visible AndAlso column.ShowInCustomizationForm Then
					column.Visible = False
				End If
			Else
				If (Not column.Visible) AndAlso column.ShowInCustomizationForm Then
					column.Visible = True
				End If
			End If
		Next column
	End Sub
	Protected Sub grid_AfterPerformCallback(ByVal sender As Object, ByVal e As ASPxGridViewAfterPerformCallbackEventArgs)
		If e.CallbackName = "COLUMNMOVE" Then
			Dim gridView As ASPxGridView = CType(sender, ASPxGridView)
			gridView.JSProperties("cpColumnsInHeader") = False
			For Each column As GridViewColumn In gridView.Columns
				If column.Visible AndAlso column.ShowInCustomizationForm Then
					gridView.JSProperties("cpColumnsInHeader") = True
					Exit For
				End If
			Next column
		End If
	End Sub
End Class