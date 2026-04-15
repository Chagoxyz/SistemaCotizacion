using System;
using System.Data;
using System.Data.SqlClient;
using SistemaCotizacion.Utilidades;

namespace SistemaCotizacion.Vistas
{
    public partial class Monedas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarMonedas();
                lblMensaje.Text = string.Empty;
            }
        }

        private void CargarMonedas()
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_Moneda_Listar", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvMonedas.DataSource = dt;
                gvMonedas.DataBind();
            }
        }

        protected void btnGuardarMoneda_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("dbo.sp_Moneda_Insertar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CodigoMoneda", txtCodigoMoneda.Text.Trim());
                    cmd.Parameters.AddWithValue("@NombreMoneda", txtNombreMoneda.Text.Trim());
                    cmd.Parameters.AddWithValue("@Simbolo", txtSimboloMoneda.Text.Trim());
                    cmd.Parameters.AddWithValue("@Estado", ddlEstadoMoneda.SelectedValue);

                    cn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Moneda guardada correctamente.";
                Limpiar();
                CargarMonedas();
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al guardar moneda: " + ex.Message;
            }
        }

        protected void btnEditarMoneda_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("dbo.sp_Moneda_Actualizar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CodigoMoneda", txtCodigoMoneda.Text.Trim());
                    cmd.Parameters.AddWithValue("@NombreMoneda", txtNombreMoneda.Text.Trim());
                    cmd.Parameters.AddWithValue("@Simbolo", txtSimboloMoneda.Text.Trim());
                    cmd.Parameters.AddWithValue("@Estado", ddlEstadoMoneda.SelectedValue);

                    cn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Moneda actualizada correctamente.";
                Limpiar();
                CargarMonedas();
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al editar moneda: " + ex.Message;
            }
        }

        protected void btnEliminarMoneda_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("dbo.sp_Moneda_Eliminar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CodigoMoneda", txtCodigoMoneda.Text.Trim());

                    cn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Moneda eliminada correctamente.";
                Limpiar();
                CargarMonedas();
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al eliminar moneda: " + ex.Message;
            }
        }

        private void Limpiar()
        {
            txtCodigoMoneda.Text = "";
            txtNombreMoneda.Text = "";
            txtSimboloMoneda.Text = "";
            ddlEstadoMoneda.SelectedIndex = 0;
        }
    }
}