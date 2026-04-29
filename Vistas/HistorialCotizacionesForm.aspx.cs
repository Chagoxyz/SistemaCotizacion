using System;
using System.Data;
using System.Data.SqlClient;
using SistemaCotizacion.Utilidades;

namespace SistemaCotizacion.Vistas
{
    public partial class HistorialCotizaciones : System.Web.UI.Page
    {
        // Se ejecuta al cargar la página.
        protected void Page_Load(object sender, EventArgs e)
        {
            // Valida que exista una sesión activa. Si no hay usuario logueado, regresa al login.
            if (Session["IdUsuario"] == null)
            {
                Response.Redirect("LoginForm.aspx");
                return;
            }

            // Carga el historial solo la primera vez que se abre la página.
            if (!IsPostBack)
            {
                CargarHistorial("", "");
                lblMensaje.Text = string.Empty;
            }
        }

        // Carga las cotizaciones desde la base de datos aplicando filtros de cliente, producto y rol.
        private void CargarHistorial(string cliente, string producto)
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_HistorialCotizaciones_Buscar", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                // Parámetros enviados al procedimiento almacenado.
                cmd.Parameters.AddWithValue("@Cliente", cliente);
                cmd.Parameters.AddWithValue("@Producto", producto);
                cmd.Parameters.AddWithValue("@IdUsuario", Convert.ToInt32(Session["IdUsuario"]));
                cmd.Parameters.AddWithValue("@IdClienteUsuario", ObtenerIdClienteDelUsuario(Convert.ToInt32(Session["IdUsuario"])));
                cmd.Parameters.AddWithValue("@EsAdministrador", Convert.ToInt32(Session["IdRol"]) == 1 ? 1 : 0);

                // Llena una tabla temporal con los resultados obtenidos.
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Muestra los datos en el GridView.
                gvHistorialCotizaciones.DataSource = dt;
                gvHistorialCotizaciones.DataBind();
            }
        }

        // Obtiene el IdCliente asociado al usuario logueado.
        // Esto permite que un cliente vea solo sus propias cotizaciones.
        private int ObtenerIdClienteDelUsuario(int idUsuario)
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                string sql = "SELECT ISNULL(IdCliente, 0) FROM Usuario WHERE IdUsuario = @IdUsuario";
                SqlCommand cmd = new SqlCommand(sql, cn);
                cmd.Parameters.AddWithValue("@IdUsuario", idUsuario);

                cn.Open();
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        // Ejecuta la búsqueda usando los filtros ingresados por el usuario.
        protected void btnBuscarHistorial_Click(object sender, EventArgs e)
        {
            try
            {
                CargarHistorial(txtBuscarClienteHistorial.Text.Trim(), ddlProductoHistorial.SelectedValue);
                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Consulta realizada correctamente.";
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al buscar historial: " + ex.Message;
            }
        }

        // Limpia los filtros y vuelve a cargar el historial completo permitido según el rol.
        protected void btnLimpiarHistorial_Click(object sender, EventArgs e)
        {
            txtBuscarClienteHistorial.Text = "";
            ddlProductoHistorial.SelectedIndex = 0;
            lblMensaje.Text = "";
            CargarHistorial("", "");
        }
    }
}