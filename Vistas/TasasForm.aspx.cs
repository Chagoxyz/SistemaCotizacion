using System;

namespace SistemaCotizacion.Vistas
{
    public partial class Tasas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMensaje.Text = string.Empty;
            }
        }

        protected void btnGuardarTasa_Click(object sender, EventArgs e)
        {
            try
            {
                if (CamposVacios())
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Por favor complete todos los campos de la tasa.";
                    return;
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Tasa procesada correctamente.";
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Ocurrió un error al guardar: " + ex.Message;
            }
        }

        protected void btnEditarTasa_Click(object sender, EventArgs e)
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

        protected void btnEliminarTasa_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtPlazoTasa.Text))
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Ingrese el plazo para simular la eliminación.";
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
            return string.IsNullOrWhiteSpace(ddlProductoTasa.SelectedValue) ||
                   string.IsNullOrWhiteSpace(ddlMonedaTasa.SelectedValue) ||
                   string.IsNullOrWhiteSpace(txtPlazoTasa.Text) ||
                   string.IsNullOrWhiteSpace(txtValorTasa.Text);
        }
    }
}