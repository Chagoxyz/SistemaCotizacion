using System;
using System.Data;
using System.Data.SqlClient;
using SistemaCotizacion.Utilidades;

namespace SistemaCotizacion.Vistas
{
    public partial class Plazos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarPlazos();
                lblMensaje.Text = string.Empty;
            }
        }

        private void CargarPlazos()
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_Plazo_Listar", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvPlazos.DataSource = dt;
                gvPlazos.DataBind();
            }
        }

        protected void btnGuardarPlazo_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("dbo.sp_Plazo_Insertar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Descripcion", txtDescripcionPlazo.Text.Trim());
                    cmd.Parameters.AddWithValue("@Cantidad", Convert.ToInt32(txtCantidadPlazo.Text.Trim()));
                    cmd.Parameters.AddWithValue("@Tipo", ddlTipoPlazo.SelectedValue);
                    cmd.Parameters.AddWithValue("@Estado", ddlEstadoPlazo.SelectedValue);

                    cn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Plazo guardado correctamente.";
                Limpiar();
                CargarPlazos();
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al guardar plazo: " + ex.Message;
            }
        }

        protected void btnEditarPlazo_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("dbo.sp_Plazo_Actualizar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Descripcion", txtDescripcionPlazo.Text.Trim());
                    cmd.Parameters.AddWithValue("@Cantidad", Convert.ToInt32(txtCantidadPlazo.Text.Trim()));
                    cmd.Parameters.AddWithValue("@Tipo", ddlTipoPlazo.SelectedValue);
                    cmd.Parameters.AddWithValue("@Estado", ddlEstadoPlazo.SelectedValue);

                    cn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Plazo actualizado correctamente.";
                Limpiar();
                CargarPlazos();
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al editar plazo: " + ex.Message;
            }
        }

        protected void btnEliminarPlazo_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("dbo.sp_Plazo_Eliminar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Descripcion", txtDescripcionPlazo.Text.Trim());

                    cn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Plazo eliminado correctamente.";
                Limpiar();
                CargarPlazos();
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al eliminar plazo: " + ex.Message;
            }
        }

        private void Limpiar()
        {
            txtDescripcionPlazo.Text = "";
            txtCantidadPlazo.Text = "";
            ddlTipoPlazo.SelectedIndex = 0;
            ddlEstadoPlazo.SelectedIndex = 0;
        }
    }
}