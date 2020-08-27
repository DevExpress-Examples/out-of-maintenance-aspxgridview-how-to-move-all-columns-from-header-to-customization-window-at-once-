<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <script type="text/javascript">
        function OnCustomizationWindowCloseUp(s, e) {
            btnMoveColumns.SetEnabled(false);
            UpdateBtnToggleCustomWindowText();
        }
        function OnBtnToggleCustomWindowClick(s, e) {
            btnMoveColumns.SetEnabled(!grid.IsCustomizationWindowVisible());
            if (grid.IsCustomizationWindowVisible())
                grid.HideCustomizationWindow();
            else
                grid.ShowCustomizationWindow();
            UpdateBtnToggleCustomWindowText();
        }
        function OnBtnMoveColumnsClick(s, e) {
            if (!hiddenField.Get('columnsInWindow')) {
                hiddenField.Set('columnsInWindow', true);
            }
            else {
                hiddenField.Set('columnsInWindow', false);
            }
            UpdateBtnMoveColumnsText(hiddenField.Get('columnsInWindow'));
            grid.PerformCallback();
        }
        function UpdateBtnToggleCustomWindowText() {
            var text = grid.IsCustomizationWindowVisible() ? 'Hide' : 'Show';
            text += ' Customization Window';
            btnToggleCustomWindow.SetText(text);
        }
        function UpdateBtnMoveColumnsText(moveToWindow) {
            var text = 'Move all columns to ';
            text += moveToWindow ? 'Header' : 'Customization Window';
            btnMoveColumns.SetText(text);
        }
        function OnEndCallBack(s, e) {
            if (s.cpColumnsInHeader != undefined) {
                UpdateBtnMoveColumnsText(!s.cpColumnsInHeader);
                hiddenField.Set('columnsInWindow', !s.cpColumnsInHeader);
                delete s.cpColumnsInHeader;
            }
        } 
               
    </script>

    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td>
                    <dx:ASPxButton ID="buttonToggleCustomWindow" runat="server" ClientInstanceName="btnToggleCustomWindow"
                        Text="Show Customization Window" AutoPostBack="false" Width="250px">
                        <ClientSideEvents Click="OnBtnToggleCustomWindowClick" />
                    </dx:ASPxButton>
                </td>
                <td>
                    <dx:ASPxButton ID="buttonMoveColumns" runat="server" ClientInstanceName="btnMoveColumns"
                        Text="Move all columns to Customization Window" ClientEnabled="false" AutoPostBack="false">
                        <ClientSideEvents Click="OnBtnMoveColumnsClick" />
                    </dx:ASPxButton>
                </td>
            </tr>
        </table>
        <br />
        <dx:ASPxGridView ID="grid" runat="server" ClientInstanceName="grid" AutoGenerateColumns="False"
            DataSourceID="gridDataSource" KeyFieldName="ProductID" OnCustomCallback="grid_CustomCallback"
            OnAfterPerformCallback="grid_AfterPerformCallback">
            <ClientSideEvents EndCallback="OnEndCallBack" CustomizationWindowCloseUp="OnCustomizationWindowCloseUp" />
            <SettingsCustomizationWindow Enabled="True" />
            <Columns>
                <dx:GridViewDataTextColumn FieldName="ProductID" ReadOnly="True" VisibleIndex="0">
                    <EditFormSettings Visible="False" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="ProductName" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="SupplierID" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CategoryID" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
        <asp:AccessDataSource ID="gridDataSource" runat="server" DataFile="~/App_Data/nwind.mdb"
            SelectCommand="SELECT [ProductID], [ProductName], [SupplierID], [CategoryID] FROM [Products]">
        </asp:AccessDataSource>
    </div>
    <dx:ASPxHiddenField ID="hf" ClientInstanceName="hiddenField" runat="server">
    </dx:ASPxHiddenField>
    </form>
</body>
</html>