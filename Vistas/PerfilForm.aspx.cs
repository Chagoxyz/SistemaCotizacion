using System;
using System.Data;
using System.Data.SqlClient;
using SistemaCotizacion.Utilidades;

namespace SistemaCotizacion.Vistas
{
    public partial class Perfil : System.Web.UI.Page
    {
        // ================= CARGA DE LA PÁGINA =================
        protected void Page_Load(object sender, EventArgs e)
        {
            // Validación de sesión activa
            if (Session["IdUsuario"] == null)
            {
                Response.Redirect("LoginForm.aspx");
            }

            // Solo en la primera carga
            if (!IsPostBack)
            {
                CargarPerfil();
                lblMensaje.Text = string.Empty;
            }
        }

        // ================= CARGAR DATOS DEL PERFIL =================
        private void CargarPerfil()
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                // Llama al procedimiento almacenado para obtener datos del usuario
                SqlCommand cmd = new SqlCommand("dbo.sp_Perfil_Obtener", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdUsuario", Convert.ToInt32(Session["IdUsuario"]));

                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                // Si encuentra datos, los carga en los campos
                if (dr.Read())
                {
                    txtNombrePerfil.Text = dr["NombreCompleto"].ToString();
                    txtCorreoPerfil.Text = dr["NombreUsuario"].ToString(); // aquí usas usuario como correo
                    txtTelefonoPerfil.Text = ""; // no se está manejando en BD
                    txtContrasenaPerfil.Text = dr["Contrasena"].ToString();
                }
            }
        }

        // ================= GUARDAR CAMBIOS =================
        protected void btnGuardarPerfil_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    // Procedimiento almacenado para actualizar datos
                    SqlCommand cmd = new SqlCommand("dbo.sp_Perfil_Actualizar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@IdUsuario", Convert.ToInt32(Session["IdUsuario"]));
                    cmd.Parameters.AddWithValue("@NombreCompleto", txtNombrePerfil.Text.Trim());
                    cmd.Parameters.AddWithValue("@NombreUsuario", txtCorreoPerfil.Text.Trim());
                    cmd.Parameters.AddWithValue("@Contrasena", txtContrasenaPerfil.Text.Trim());

                    cn.Open();
                    cmd.ExecuteNonQuery();
                }

                // Mensaje de éxito
                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Perfil actualizado correctamente.";
            }
            catch (Exception ex)
            {
                // Manejo de errores
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al guardar perfil: " + ex.Message;
            }
        }

        // ================= CANCELAR CAMBIOS =================
        protected void btnCancelarPerfil_Click(object sender, EventArgs e)
        {
            // Recarga los datos originales
            CargarPerfil();

            // Limpia mensaje
            lblMensaje.Text = "";
        }
    }
}