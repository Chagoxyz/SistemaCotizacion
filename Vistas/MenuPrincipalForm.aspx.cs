using System;

namespace SistemaCotizacion.Vistas
{
    public partial class MenuPrincipal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginForm.aspx");
        }
    }
}