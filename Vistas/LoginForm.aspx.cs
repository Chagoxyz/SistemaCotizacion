using System;
using System.Data;
using System.Data.SqlClient;
using SistemaCotizacion.Utilidades;

namespace SistemaCotizacion.Vistas
{
    public partial class Login : System.Web.UI.Page
    {
        // Se ejecuta cada vez que se carga la página.
        protected void Page_Load(object sender, EventArgs e)
        {
            // Solo se ejecuta la primera vez (no en postback)
            if (!IsPostBack)
            {
                // Limpia cualquier mensaje previo
                lblMensaje.Text = string.Empty;

                // Limpia la sesión para evitar datos anteriores
                Session.Clear();
            }
        }

        // Evento que se ejecuta cuando el usuario presiona el botón "Ingresar"
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                // Verifica que las validaciones del formulario sean correctas
                if (!Page.IsValid)
                {
                    lblMensaje.Text = "Por favor complete los campos requeridos.";
                    return;
                }

                // Abre conexión con la base de datos
                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    // Llama al procedimiento almacenado para validar el usuario
                    SqlCommand cmd = new SqlCommand("dbo.sp_Login_Validar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Envía los parámetros ingresados por el usuario
                    cmd.Parameters.AddWithValue("@NombreUsuario", txtUsuario.Text.Trim());
                    cmd.Parameters.AddWithValue("@Contrasena", txtPassword.Text.Trim());

                    cn.Open();

                    // Ejecuta la consulta y obtiene los datos
                    SqlDataReader dr = cmd.ExecuteReader();

                    // Si encuentra el usuario en la base de datos
                    if (dr.Read())
                    {
                        // Limpia la sesión actual
                        Session.Clear();

                        // Guarda los datos del usuario en sesión
                        Session["IdUsuario"] = Convert.ToInt32(dr["IdUsuario"]);
                        Session["NombreCompleto"] = dr["NombreCompleto"].ToString();
                        Session["NombreUsuario"] = dr["NombreUsuario"].ToString();
                        Session["IdRol"] = Convert.ToInt32(dr["IdRol"]);

                        // Redirige al menú principal
                        Response.Redirect("MenuPrincipalForm.aspx");
                    }
                    else
                    {
                        // Si el usuario no existe o la contraseña es incorrecta
                        lblMensaje.ForeColor = System.Drawing.Color.Red;
                        lblMensaje.Text = "Usuario o contraseña incorrectos.";
                    }
                }
            }
            catch (Exception ex)
            {
                // Manejo de errores en caso de fallo en la conexión o consulta
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al iniciar sesión: " + ex.Message;
            }
        }
    }
}