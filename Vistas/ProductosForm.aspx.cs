using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using SistemaCotizacion.Utilidades;

namespace SistemaCotizacion.Vistas
{
    public partial class Productos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarMonedas();
                CargarProductos();
                lblMensaje.Text = string.Empty;
            }
        }

        private void CargarMonedas()
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_Moneda_ListarActivas", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Quita monedas vacías que vengan de la base de datos
                for (int i = dt.Rows.Count - 1; i >= 0; i--)
                {
                    if (string.IsNullOrWhiteSpace(dt.Rows[i]["NombreMoneda"].ToString()))
                    {
                        dt.Rows.RemoveAt(i);
                    }
                }

                ddlMoneda.Items.Clear();
                ddlMoneda.DataSource = dt;
                ddlMoneda.DataTextField = "NombreMoneda";
                ddlMoneda.DataValueField = "IdMoneda";
                ddlMoneda.DataBind();
                ddlMoneda.Items.Insert(0, new ListItem("Seleccione...", "0"));
            }
        }

        private void CargarProductos()
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_Producto_Listar", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvProductos.DataSource = dt;
                gvProductos.DataBind();
            }
        }

        protected void btnGuardarProducto_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlMoneda.SelectedValue == "0")
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Debe seleccionar una moneda.";
                    return;
                }

                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("dbo.sp_Producto_Insertar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CodigoProducto", txtCodigo.Text.Trim());
                    cmd.Parameters.AddWithValue("@NombreProducto", txtNombreProducto.Text.Trim());
                    cmd.Parameters.AddWithValue("@IdMoneda", Convert.ToInt32(ddlMoneda.SelectedValue));
                    cmd.Parameters.AddWithValue("@Estado", ddlEstadoProducto.SelectedValue);

                    cn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Producto guardado correctamente.";
                Limpiar();
                CargarProductos();
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al guardar producto: " + ex.Message;
            }
        }

        protected void btnEditarProducto_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlMoneda.SelectedValue == "0")
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Debe seleccionar una moneda.";
                    return;
                }

                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("dbo.sp_Producto_Actualizar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CodigoProducto", txtCodigo.Text.Trim());
                    cmd.Parameters.AddWithValue("@NombreProducto", txtNombreProducto.Text.Trim());
                    cmd.Parameters.AddWithValue("@IdMoneda", Convert.ToInt32(ddlMoneda.SelectedValue));
                    cmd.Parameters.AddWithValue("@Estado", ddlEstadoProducto.SelectedValue);

                    cn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Producto actualizado correctamente.";
                Limpiar();
                CargarProductos();
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al editar producto: " + ex.Message;
            }
        }

        protected void btnEliminarProducto_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("dbo.sp_Producto_Eliminar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CodigoProducto", txtCodigo.Text.Trim());

                    cn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Producto eliminado correctamente.";
                Limpiar();
                CargarProductos();
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al eliminar producto: " + ex.Message;
            }
        }

        protected void btnLimpiarProducto_Click(object sender, EventArgs e)
        {
            Limpiar();
            lblMensaje.Text = "";
        }

        private void Limpiar()
        {
            txtCodigo.Text = "";
            txtNombreProducto.Text = "";
            ddlMoneda.SelectedIndex = 0;
            ddlEstadoProducto.SelectedIndex = 0;
        }
    }
}