using System;
using System.Data;
using System.Data.SqlClient;
using SistemaCotizacion.Utilidades;

namespace SistemaCotizacion.Vistas
{
    public partial class Perfil : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IdUsuario"] == null)
            {
                Response.Redirect("LoginForm.aspx");
            }

            if (!IsPostBack)
            {
                CargarPerfil();
                lblMensaje.Text = string.Empty;
            }
        }

        private void CargarPerfil()
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_Perfil_Obtener", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdUsuario", Convert.ToInt32(Session["IdUsuario"]));

                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtNombrePerfil.Text = dr["NombreCompleto"].ToString();
                    txtCorreoPerfil.Text = dr["NombreUsuario"].ToString();
                    txtTelefonoPerfil.Text = "";
                    txtContrasenaPerfil.Text = dr["Contrasena"].ToString();
                }
            }
        }

        protected void btnGuardarPerfil_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("dbo.sp_Perfil_Actualizar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@IdUsuario", Convert.ToInt32(Session["IdUsuario"]));
                    cmd.Parameters.AddWithValue("@NombreCompleto", txtNombrePerfil.Text.Trim());
                    cmd.Parameters.AddWithValue("@NombreUsuario", txtCorreoPerfil.Text.Trim());
                    cmd.Parameters.AddWithValue("@Contrasena", txtContrasenaPerfil.Text.Trim());

                    cn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Perfil actualizado correctamente.";
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al guardar perfil: " + ex.Message;
            }
        }

        protected void btnCancelarPerfil_Click(object sender, EventArgs e)
        {
            CargarPerfil();
            lblMensaje.Text = "";
        }
    }
}