using System;

namespace SistemaCotizacion.Vistas
{
    public partial class Plazos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMensaje.Text = string.Empty;
            }
        }

        protected void btnGuardarPlazo_Click(object sender, EventArgs e)
        {
            try
            {
                if (CamposVacios())
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Por favor complete todos los campos del plazo.";
                    return;
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Plazo procesado correctamente.";
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Ocurrió un error al guardar: " + ex.Message;
            }
        }

        protected void btnEditarPlazo_Click(object sender, EventArgs e)
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

        protected void btnEliminarPlazo_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtDescripcionPlazo.Text))
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Ingrese la descripción del plazo para simular la eliminación.";
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
            return string.IsNullOrWhiteSpace(txtDescripcionPlazo.Text) ||
                   string.IsNullOrWhiteSpace(txtCantidadPlazo.Text) ||
                   string.IsNullOrWhiteSpace(ddlTipoPlazo.SelectedValue) ||
                   string.IsNullOrWhiteSpace(ddlEstadoPlazo.SelectedValue);
        }
    }
}