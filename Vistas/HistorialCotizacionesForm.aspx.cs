using System;
using System.Data;
using System.Data.SqlClient;
using SistemaCotizacion.Utilidades;

namespace SistemaCotizacion.Vistas
{
    public partial class HistorialCotizaciones : System.Web.UI.Page
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
                CargarHistorial("", "");
                lblMensaje.Text = string.Empty;
            }
        }

        private void CargarHistorial(string cliente, string producto)
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_HistorialCotizaciones_Buscar", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Cliente", cliente);
                cmd.Parameters.AddWithValue("@Producto", producto);
                cmd.Parameters.AddWithValue("@IdUsuario", Convert.ToInt32(Session["IdUsuario"]));
                cmd.Parameters.AddWithValue("@IdClienteUsuario", ObtenerIdClienteDelUsuario(Convert.ToInt32(Session["IdUsuario"])));
                cmd.Parameters.AddWithValue("@EsAdministrador", Convert.ToInt32(Session["IdRol"]) == 1 ? 1 : 0);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvHistorialCotizaciones.DataSource = dt;
                gvHistorialCotizaciones.DataBind();
            }
        }

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

        protected void btnLimpiarHistorial_Click(object sender, EventArgs e)
        {
            txtBuscarClienteHistorial.Text = "";
            ddlProductoHistorial.SelectedIndex = 0;
            lblMensaje.Text = "";
            CargarHistorial("", "");
        }
    }
}