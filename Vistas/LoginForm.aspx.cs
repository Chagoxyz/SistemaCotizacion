using System;
using System.Data;
using System.Data.SqlClient;
using SistemaCotizacion.Utilidades;

namespace SistemaCotizacion.Vistas
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMensaje.Text = string.Empty;
                Session.Clear();
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

                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("dbo.sp_Login_Validar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@NombreUsuario", txtUsuario.Text.Trim());
                    cmd.Parameters.AddWithValue("@Contrasena", txtPassword.Text.Trim());

                    cn.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        Session.Clear();

                        Session["IdUsuario"] = Convert.ToInt32(dr["IdUsuario"]);
                        Session["NombreCompleto"] = dr["NombreCompleto"].ToString();
                        Session["NombreUsuario"] = dr["NombreUsuario"].ToString();
                        Session["IdRol"] = Convert.ToInt32(dr["IdRol"]);

                        Response.Redirect("MenuPrincipalForm.aspx");
                    }
                    else
                    {
                        lblMensaje.ForeColor = System.Drawing.Color.Red;
                        lblMensaje.Text = "Usuario o contraseña incorrectos.";
                    }
                }
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al iniciar sesión: " + ex.Message;
            }
        }
    }
}