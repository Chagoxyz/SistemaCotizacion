using System;

namespace SistemaCotizacion.Vistas
{
    public partial class Usuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMensaje.Text = string.Empty;
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                if (CamposVacios())
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Por favor complete todos los campos del formulario.";
                    return;
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Usuario procesado correctamente.";
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Ocurrió un error al guardar: " + ex.Message;
            }
        }

        protected void btnEditar_Click(object sender, EventArgs e)
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

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtNombreUsuario.Text))
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Ingrese el nombre de usuario para simular la eliminación.";
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

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtNombreCompleto.Text = string.Empty;
            txtNombreUsuario.Text = string.Empty;
            txtContrasena.Text = string.Empty;
            ddlEstado.SelectedIndex = 0;
            lblMensaje.Text = string.Empty;
        }

        private bool CamposVacios()
        {
            return string.IsNullOrWhiteSpace(txtNombreCompleto.Text) ||
                   string.IsNullOrWhiteSpace(txtNombreUsuario.Text) ||
                   string.IsNullOrWhiteSpace(txtContrasena.Text) ||
                   string.IsNullOrWhiteSpace(ddlEstado.SelectedValue);
        }
    }
}