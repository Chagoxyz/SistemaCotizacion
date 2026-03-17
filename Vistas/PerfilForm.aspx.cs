using System;

namespace SistemaCotizacion.Vistas
{
    public partial class Perfil : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMensaje.Text = string.Empty;
            }
        }

        protected void btnGuardarPerfil_Click(object sender, EventArgs e)
        {
            try
            {
                if (CamposVacios())
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Por favor complete todos los campos del perfil.";
                    return;
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Cambios de perfil procesados correctamente.";
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Ocurrió un error al guardar: " + ex.Message;
            }
        }

        protected void btnCancelarPerfil_Click(object sender, EventArgs e)
        {
            txtNombrePerfil.Text = string.Empty;
            txtCorreoPerfil.Text = string.Empty;
            txtTelefonoPerfil.Text = string.Empty;
            txtContrasenaPerfil.Text = string.Empty;
            lblMensaje.Text = string.Empty;
        }

        private bool CamposVacios()
        {
            return string.IsNullOrWhiteSpace(txtNombrePerfil.Text) ||
                   string.IsNullOrWhiteSpace(txtCorreoPerfil.Text) ||
                   string.IsNullOrWhiteSpace(txtTelefonoPerfil.Text) ||
                   string.IsNullOrWhiteSpace(txtContrasenaPerfil.Text);
        }
    }
}