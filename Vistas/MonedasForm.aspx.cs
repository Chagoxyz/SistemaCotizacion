using System;

namespace SistemaCotizacion.Vistas
{
    public partial class Monedas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMensaje.Text = string.Empty;
            }
        }

        protected void btnGuardarMoneda_Click(object sender, EventArgs e)
        {
            try
            {
                if (CamposVacios())
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Por favor complete todos los campos de la moneda.";
                    return;
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Moneda procesada correctamente.";
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Ocurrió un error al guardar: " + ex.Message;
            }
        }

        protected void btnEditarMoneda_Click(object sender, EventArgs e)
        {
            try
            {
                if (CamposVacios())
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Debe completar la información antes de editar.";
                    return;
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Edición simulada correctamente.";
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Ocurrió un error al editar: " + ex.Message;
            }
        }

        protected void btnEliminarMoneda_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtCodigoMoneda.Text))
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Ingrese el código de la moneda para simular la eliminación.";
                    return;
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Eliminación simulada correctamente.";
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Ocurrió un error al eliminar: " + ex.Message;
            }
        }

        private bool CamposVacios()
        {
            return string.IsNullOrWhiteSpace(txtCodigoMoneda.Text) ||
                   string.IsNullOrWhiteSpace(txtNombreMoneda.Text) ||
                   string.IsNullOrWhiteSpace(txtSimboloMoneda.Text) ||
                   string.IsNullOrWhiteSpace(ddlEstadoMoneda.SelectedValue);
        }
    }
}