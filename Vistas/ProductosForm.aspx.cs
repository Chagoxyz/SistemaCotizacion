using System;

namespace SistemaCotizacion.Vistas
{
    public partial class Productos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMensaje.Text = string.Empty;
            }
        }

        protected void btnGuardarProducto_Click(object sender, EventArgs e)
        {
            try
            {
                if (CamposVacios())
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Por favor complete todos los campos del producto.";
                    return;
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Producto procesado correctamente.";
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Ocurrió un error al guardar: " + ex.Message;
            }
        }

        protected void btnEditarProducto_Click(object sender, EventArgs e)
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

        protected void btnEliminarProducto_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtCodigo.Text))
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Ingrese el código del producto para simular la eliminación.";
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

        protected void btnLimpiarProducto_Click(object sender, EventArgs e)
        {
            txtCodigo.Text = string.Empty;
            txtNombreProducto.Text = string.Empty;
            ddlMoneda.SelectedIndex = 0;
            ddlEstadoProducto.SelectedIndex = 0;
            lblMensaje.Text = string.Empty;
        }

        private bool CamposVacios()
        {
            return string.IsNullOrWhiteSpace(txtCodigo.Text) ||
                   string.IsNullOrWhiteSpace(txtNombreProducto.Text) ||
                   string.IsNullOrWhiteSpace(ddlMoneda.SelectedValue) ||
                   string.IsNullOrWhiteSpace(ddlEstadoProducto.SelectedValue);
        }
    }
}