using System;

namespace SistemaCotizacion.Vistas
{
    public partial class MenuPrincipal : System.Web.UI.Page
    {
        // Se ejecuta cada vez que la página se carga.
        protected void Page_Load(object sender, EventArgs e)
        {
            // Verifica si el usuario tiene sesión activa.
            // Si no existe, lo redirige al login.
            if (Session["IdUsuario"] == null)
            {
                Response.Redirect("LoginForm.aspx");
                return;
            }

            // Solo se ejecuta la primera vez que se carga la página.
            if (!IsPostBack)
            {
                // Muestra el nombre del usuario en la barra superior.
                // Si no existe información en sesión, muestra "Invitado".
                lblUsuarioActual.Text = Session["NombreUsuario"] != null
                    ? Session["NombreCompleto"].ToString()
                    : "Invitado";

                // Obtiene el rol del usuario desde la sesión.
                int idRol = Session["IdRol"] != null ? Convert.ToInt32(Session["IdRol"]) : 0;

                // Si el usuario es Administrador (IdRol = 1)
                if (idRol == 1)
                {
                    // Muestra el menú y opciones administrativas.
                    menuAdmin.Visible = true;
                    cardProductos.Visible = true;
                    cardUsuarios.Visible = true;
                    cardReportes.Visible = true;
                }
                else // Usuario normal o cliente
                {
                    // Oculta las opciones administrativas.
                    menuAdmin.Visible = false;
                    cardProductos.Visible = false;
                    cardUsuarios.Visible = false;
                    cardReportes.Visible = false;
                }
            }
        }

        // Evento que se ejecuta al hacer clic en "Cerrar sesión".
        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            // Limpia los datos de la sesión actual.
            Session.Clear();

            // Finaliza completamente la sesión.
            Session.Abandon();

            // Redirige al usuario nuevamente al login.
            Response.Redirect("LoginForm.aspx");
        }
    }
}