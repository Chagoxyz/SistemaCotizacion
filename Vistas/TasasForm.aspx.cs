using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using SistemaCotizacion.Utilidades;

namespace SistemaCotizacion.Vistas
{
    public partial class Tasas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarProductos();
                CargarMonedas();
                CargarPlazos();
                CargarTasas();
                lblMensaje.Text = string.Empty;
            }
        }

        private void CargarProductos()
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_Producto_ListarActivos", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlProductoTasa.DataSource = dt;
                ddlProductoTasa.DataTextField = "NombreProducto";
                ddlProductoTasa.DataValueField = "IdProducto";
                ddlProductoTasa.DataBind();
                ddlProductoTasa.Items.Insert(0, new ListItem("Seleccione...", ""));
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

                ddlMonedaTasa.DataSource = dt;
                ddlMonedaTasa.DataTextField = "NombreMoneda";
                ddlMonedaTasa.DataValueField = "IdMoneda";
                ddlMonedaTasa.DataBind();
                ddlMonedaTasa.Items.Insert(0, new ListItem("Seleccione...", ""));
            }
        }

        private void CargarPlazos()
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_Plazo_ListarActivos", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlPlazoTasa.DataSource = dt;
                ddlPlazoTasa.DataTextField = "Descripcion";
                ddlPlazoTasa.DataValueField = "IdPlazo";
                ddlPlazoTasa.DataBind();
                ddlPlazoTasa.Items.Insert(0, new ListItem("Seleccione...", ""));
            }
        }

        private void CargarTasas()
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_Tasa_Listar", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvTasas.DataSource = dt;
                gvTasas.DataBind();
            }
        }

        protected void btnGuardarTasa_Click(object sender, EventArgs e)
        {
            try
            {
                if (!ValidarCampos())
                    return;

                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("dbo.sp_Tasa_Insertar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@IdProducto", Convert.ToInt32(ddlProductoTasa.SelectedValue));
                    cmd.Parameters.AddWithValue("@IdPlazo", Convert.ToInt32(ddlPlazoTasa.SelectedValue));
                    cmd.Parameters.AddWithValue("@TasaAnual", Convert.ToDecimal(txtValorTasa.Text.Trim()));
                    cmd.Parameters.AddWithValue("@Estado", "Activo");

                    cn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "La tasa se guardó correctamente.";
                Limpiar();
                CargarTasas();
            }
            catch (SqlException ex)
            {
                if (ex.Number == 2627 || ex.Number == 2601)
                {
                    lblMensaje.ForeColor = System.Drawing.Color.DarkOrange;
                    lblMensaje.Text = "Ya existe una tasa registrada para ese producto y plazo. Puedes usar el botón Editar para actualizarla.";
                }
                else
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "No fue posible guardar la tasa: " + ex.Message;
                }
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "No fue posible guardar la tasa: " + ex.Message;
            }
        }

        protected void btnEditarTasa_Click(object sender, EventArgs e)
        {
            try
            {
                if (!ValidarCampos())
                    return;

                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("dbo.sp_Tasa_Actualizar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@IdProducto", Convert.ToInt32(ddlProductoTasa.SelectedValue));
                    cmd.Parameters.AddWithValue("@IdPlazo", Convert.ToInt32(ddlPlazoTasa.SelectedValue));
                    cmd.Parameters.AddWithValue("@TasaAnual", Convert.ToDecimal(txtValorTasa.Text.Trim()));

                    cn.Open();
                    int filas = cmd.ExecuteNonQuery();

                    if (filas == 0)
                    {
                        lblMensaje.ForeColor = System.Drawing.Color.DarkOrange;
                        lblMensaje.Text = "No se encontró una tasa registrada para ese producto y plazo.";
                        return;
                    }
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "La tasa se actualizó correctamente.";
                Limpiar();
                CargarTasas();
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "No fue posible editar la tasa: " + ex.Message;
            }
        }

        protected void btnEliminarTasa_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlProductoTasa.SelectedValue == "" || ddlPlazoTasa.SelectedValue == "")
                {
                    lblMensaje.ForeColor = System.Drawing.Color.DarkOrange;
                    lblMensaje.Text = "Selecciona el producto y el plazo que deseas eliminar.";
                    return;
                }

                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("dbo.sp_Tasa_Eliminar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@IdProducto", Convert.ToInt32(ddlProductoTasa.SelectedValue));
                    cmd.Parameters.AddWithValue("@IdPlazo", Convert.ToInt32(ddlPlazoTasa.SelectedValue));

                    cn.Open();
                    int filas = cmd.ExecuteNonQuery();

                    if (filas == 0)
                    {
                        lblMensaje.ForeColor = System.Drawing.Color.DarkOrange;
                        lblMensaje.Text = "No existe una tasa registrada con ese producto y plazo.";
                        return;
                    }
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "La tasa se eliminó correctamente.";
                Limpiar();
                CargarTasas();
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "No fue posible eliminar la tasa: " + ex.Message;
            }
        }

        private bool ValidarCampos()
        {
            if (ddlProductoTasa.SelectedValue == "")
            {
                lblMensaje.ForeColor = System.Drawing.Color.DarkOrange;
                lblMensaje.Text = "Selecciona un producto.";
                return false;
            }

            if (ddlMonedaTasa.SelectedValue == "")
            {
                lblMensaje.ForeColor = System.Drawing.Color.DarkOrange;
                lblMensaje.Text = "Selecciona una moneda.";
                return false;
            }

            if (ddlPlazoTasa.SelectedValue == "")
            {
                lblMensaje.ForeColor = System.Drawing.Color.DarkOrange;
                lblMensaje.Text = "Selecciona un plazo.";
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtValorTasa.Text))
            {
                lblMensaje.ForeColor = System.Drawing.Color.DarkOrange;
                lblMensaje.Text = "Ingresa la tasa anual.";
                return false;
            }

            return true;
        }

        private void Limpiar()
        {
            ddlProductoTasa.SelectedIndex = 0;
            ddlMonedaTasa.SelectedIndex = 0;
            ddlPlazoTasa.SelectedIndex = 0;
            txtValorTasa.Text = "";
        }
    }
}