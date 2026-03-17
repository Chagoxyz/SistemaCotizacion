using System;

namespace SistemaCotizacion.Vistas
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMensaje.Text = string.Empty;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsValid)
                {
                    lblMensaje.Text = "Por favor complete los campos requeridos.";
                    return;
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Ingreso correcto.";

                Response.Redirect("MenuPrincipalForm.aspx");
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Ocurrió un error al ingresar: " + ex.Message;
            }
        }
    }
}