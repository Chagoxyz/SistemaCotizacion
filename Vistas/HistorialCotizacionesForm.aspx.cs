using System;

namespace SistemaCotizacion.Vistas
{
    public partial class HistorialCotizaciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMensaje.Text = string.Empty;
                gvHistorialCotizaciones.DataSource = null;
                gvHistorialCotizaciones.DataBind();
            }
        }

        protected void btnBuscarHistorial_Click(object sender, EventArgs e)
        {
            try
            {
                bool clienteVacio = string.IsNullOrWhiteSpace(txtBuscarClienteHistorial.Text);
                bool productoVacio = string.IsNullOrWhiteSpace(ddlProductoHistorial.SelectedValue);

                if (clienteVacio && productoVacio)
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Ingrese un nombre de cliente o seleccione un producto para realizar la búsqueda.";
                    return;
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Búsqueda procesada. La carga de resultados reales se implementará en la siguiente fase con base de datos.";

                gvHistorialCotizaciones.DataSource = null;
                gvHistorialCotizaciones.DataBind();
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Ocurrió un error al buscar: " + ex.Message;
            }
        }

        protected void btnLimpiarHistorial_Click(object sender, EventArgs e)
        {
            txtBuscarClienteHistorial.Text = string.Empty;
            ddlProductoHistorial.SelectedIndex = 0;
            lblMensaje.Text = string.Empty;

            gvHistorialCotizaciones.DataSource = null;
            gvHistorialCotizaciones.DataBind();
        }
    }
}