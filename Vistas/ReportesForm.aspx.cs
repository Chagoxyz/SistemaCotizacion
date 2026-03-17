using System;

namespace SistemaCotizacion.Vistas
{
    public partial class Reportes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMensaje.Text = string.Empty;
                gvReportes.DataSource = null;
                gvReportes.DataBind();
            }
        }

        protected void btnGenerarReporte_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(ddlTipoReporte.SelectedValue))
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Debe seleccionar un tipo de reporte.";
                    return;
                }

                if (string.IsNullOrWhiteSpace(ddlFormatoReporte.SelectedValue))
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Debe seleccionar un formato de reporte.";
                    return;
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "La generación del reporte fue procesada correctamente. La exportación real se implementará en la siguiente fase con base de datos.";

                gvReportes.DataSource = null;
                gvReportes.DataBind();
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Ocurrió un error al generar el reporte: " + ex.Message;
            }
        }

        protected void btnLimpiarReporte_Click(object sender, EventArgs e)
        {
            ddlTipoReporte.SelectedIndex = 0;
            ddlFormatoReporte.SelectedIndex = 0;
            lblMensaje.Text = string.Empty;

            gvReportes.DataSource = null;
            gvReportes.DataBind();
        }
    }
}