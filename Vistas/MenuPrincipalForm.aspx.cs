using System;

namespace SistemaCotizacion.Vistas
{
    public partial class MenuPrincipal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IdUsuario"] == null)
            {
                Response.Redirect("LoginForm.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblUsuarioActual.Text = Session["NombreUsuario"] != null
                    ? Session["NombreCompleto"].ToString()
                    : "Invitado";

                int idRol = Session["IdRol"] != null ? Convert.ToInt32(Session["IdRol"]) : 0;

                if (idRol == 1) // Administrador
                {
                    menuAdmin.Visible = true;
                    cardProductos.Visible = true;
                    cardUsuarios.Visible = true;
                    cardReportes.Visible = true;
                }
                else // Usuario / Cliente
                {
                    menuAdmin.Visible = false;
                    cardProductos.Visible = false;
                    cardUsuarios.Visible = false;
                    cardReportes.Visible = false;
                }
            }
        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("LoginForm.aspx");
        }
    }
}