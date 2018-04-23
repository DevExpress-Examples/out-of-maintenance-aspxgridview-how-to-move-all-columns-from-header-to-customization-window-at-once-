using System;
using DevExpress.Web.ASPxGridView;

public partial class _Default : System.Web.UI.Page {
    protected void grid_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e) {
        ASPxGridView gridView = (ASPxGridView)sender;
        foreach (GridViewColumn column in gridView.Columns) {
            if (Convert.ToBoolean(hf["columnsInWindow"])) {
                if (column.Visible && column.ShowInCustomizationForm)
                    column.Visible = false;
            } else {
                if (!column.Visible && column.ShowInCustomizationForm)
                    column.Visible = true;
            }
        }
    }
    protected void grid_AfterPerformCallback(object sender, ASPxGridViewAfterPerformCallbackEventArgs e) {
        if (e.CallbackName == "COLUMNMOVE") {
            ASPxGridView gridView = (ASPxGridView)sender;
            gridView.JSProperties["cpColumnsInHeader"] = false;
            foreach (GridViewColumn column in gridView.Columns) {
                if (column.Visible && column.ShowInCustomizationForm) {
                    gridView.JSProperties["cpColumnsInHeader"] = true;
                    break;
                }
            }
        }
    }
}