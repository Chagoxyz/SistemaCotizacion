using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using SistemaCotizacion.Clases;
using SistemaCotizacion.Utilidades;

namespace SistemaCotizacion.Vistas
{
    public partial class NuevaCotizacion : System.Web.UI.Page
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
                CargarProductos();

                ddlPlazo.Items.Clear();
                ddlPlazo.Items.Insert(0, new ListItem("Seleccione...", ""));
                txtMoneda.Text = "";
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

                ddlProducto.DataSource = dt;
                ddlProducto.DataTextField = "NombreProducto";
                ddlProducto.DataValueField = "CodigoProducto";
                ddlProducto.DataBind();
                ddlProducto.Items.Insert(0, new ListItem("Seleccione...", ""));
            }
        }

        private void CargarPlazosPorProducto(int idProducto)
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_Plazo_ListarPorProducto", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdProducto", idProducto);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlPlazo.DataSource = dt;
                ddlPlazo.DataTextField = "Descripcion";
                ddlPlazo.DataValueField = "Descripcion";
                ddlPlazo.DataBind();
                ddlPlazo.Items.Insert(0, new ListItem("Seleccione...", ""));
            }
        }

        private void CargarMonedaPorProducto(string codigoProducto)
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_Producto_ObtenerMonedaPorCodigo", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CodigoProducto", codigoProducto);

                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtMoneda.Text = dr["NombreMoneda"].ToString();
                }
                else
                {
                    txtMoneda.Text = "";
                }
            }
        }

        protected void ddlProducto_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlPlazo.Items.Clear();
            ddlPlazo.Items.Insert(0, new ListItem("Seleccione...", ""));
            txtMoneda.Text = "";

            if (string.IsNullOrWhiteSpace(ddlProducto.SelectedValue))
                return;

            int idProducto = ObtenerIdProducto(ddlProducto.SelectedValue);
            CargarPlazosPorProducto(idProducto);
            CargarMonedaPorProducto(ddlProducto.SelectedValue);
        }

        protected void btnCalcular_Click(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsValid)
                    return;

                decimal monto = Convert.ToDecimal(txtMonto.Text.Trim());
                string codigoProducto = ddlProducto.SelectedValue;
                string plazoTexto = ddlPlazo.SelectedValue;

                int idProducto = ObtenerIdProducto(codigoProducto);
                int idPlazo = ObtenerIdPlazo(plazoTexto);
                decimal tasa = ObtenerTasa(idProducto, idPlazo);
                int meses = ObtenerMeses(plazoTexto);

                CalculadoraInteres calculadora = new CalculadoraInteres();
                List<DetalleCotizacion> detalle = calculadora.CalcularDetalle(monto, tasa, meses);

                decimal totalBruto = 0;
                decimal totalImpuesto = 0;
                decimal totalNeto = 0;

                var listaMostrar = new List<object>();

                foreach (var item in detalle)
                {
                    totalBruto += item.InteresBruto;
                    totalImpuesto += item.Impuesto;
                    totalNeto += item.InteresNeto;

                    listaMostrar.Add(new
                    {
                        Mes = item.Mes,
                        Monto = item.Monto,
                        Bruto = item.InteresBruto,
                        Impuesto = item.Impuesto,
                        Neto = item.InteresNeto
                    });
                }

                // Admin puede cotizar a cualquier cliente escrito en pantalla.
                // Usuario normal cotiza para sí mismo.
                if (Convert.ToInt32(Session["IdRol"]) == 1)
                {
                    lblCliente.Text = txtNombre.Text.Trim();
                }
                else
                {
                    lblCliente.Text = Session["NombreCompleto"].ToString();
                    txtNombre.Text = Session["NombreCompleto"].ToString();
                }

                lblProducto.Text = ddlProducto.SelectedItem.Text;
                lblMonto.Text = monto.ToString("N2");
                lblPlazo.Text = plazoTexto;
                lblTasa.Text = tasa.ToString("N4") + "%";
                lblBruto.Text = totalBruto.ToString("N2");
                lblImpuesto.Text = totalImpuesto.ToString("N2");
                lblNeto.Text = totalNeto.ToString("N2");

                gvDetalle.DataSource = listaMostrar;
                gvDetalle.DataBind();

                ViewState["IdProducto"] = idProducto;
                ViewState["IdPlazo"] = idPlazo;
                ViewState["Tasa"] = tasa;
                ViewState["TotalBruto"] = totalBruto;
                ViewState["TotalImpuesto"] = totalImpuesto;
                ViewState["TotalNeto"] = totalNeto;
                Session["DetalleActual"] = detalle;

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Cotización calculada correctamente.";
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al calcular la cotización: " + ex.Message;
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            SqlConnection cn = null;
            SqlTransaction tr = null;

            try
            {
                if (Session["IdUsuario"] == null)
                    throw new Exception("Sesión expirada. Inicie sesión nuevamente.");

                if (Session["DetalleActual"] == null)
                    throw new Exception("Primero debe calcular la cotización.");

                List<DetalleCotizacion> detalle = (List<DetalleCotizacion>)Session["DetalleActual"];
                int idProducto = Convert.ToInt32(ViewState["IdProducto"]);
                int idPlazo = Convert.ToInt32(ViewState["IdPlazo"]);
                decimal tasa = Convert.ToDecimal(ViewState["Tasa"]);
                decimal totalBruto = Convert.ToDecimal(ViewState["TotalBruto"]);
                decimal totalImpuesto = Convert.ToDecimal(ViewState["TotalImpuesto"]);
                decimal totalNeto = Convert.ToDecimal(ViewState["TotalNeto"]);
                decimal monto = Convert.ToDecimal(txtMonto.Text.Trim());

                cn = ConexionDB.ObtenerConexion();
                cn.Open();
                tr = cn.BeginTransaction();

                int idCliente = ObtenerOCrearCliente(cn, tr);
                int idTasa = ObtenerIdTasa(cn, tr, idProducto, idPlazo);
                int numeroCotizacion = ObtenerSiguienteNumeroCotizacion(cn, tr);

                SqlCommand cmdCot = new SqlCommand("dbo.sp_Cotizacion_Insertar", cn, tr);
                cmdCot.CommandType = CommandType.StoredProcedure;
                cmdCot.Parameters.AddWithValue("@NumeroCotizacion", numeroCotizacion);
                cmdCot.Parameters.AddWithValue("@IdCliente", idCliente);
                cmdCot.Parameters.AddWithValue("@IdProducto", idProducto);
                cmdCot.Parameters.AddWithValue("@IdPlazo", idPlazo);
                cmdCot.Parameters.AddWithValue("@IdTasa", idTasa);
                cmdCot.Parameters.AddWithValue("@IdUsuario", Convert.ToInt32(Session["IdUsuario"]));
                cmdCot.Parameters.AddWithValue("@Monto", monto);
                cmdCot.Parameters.AddWithValue("@TasaAnual", tasa);
                cmdCot.Parameters.AddWithValue("@TotalInteresBruto", totalBruto);
                cmdCot.Parameters.AddWithValue("@TotalImpuesto", totalImpuesto);
                cmdCot.Parameters.AddWithValue("@TotalNeto", totalNeto);

                int idCotizacion = Convert.ToInt32(cmdCot.ExecuteScalar());

                foreach (var item in detalle)
                {
                    SqlCommand cmdDet = new SqlCommand("dbo.sp_DetalleCotizacion_Insertar", cn, tr);
                    cmdDet.CommandType = CommandType.StoredProcedure;
                    cmdDet.Parameters.AddWithValue("@IdCotizacion", idCotizacion);
                    cmdDet.Parameters.AddWithValue("@Mes", item.Mes);
                    cmdDet.Parameters.AddWithValue("@Monto", item.Monto);
                    cmdDet.Parameters.AddWithValue("@InteresBruto", item.InteresBruto);
                    cmdDet.Parameters.AddWithValue("@Impuesto", item.Impuesto);
                    cmdDet.Parameters.AddWithValue("@InteresNeto", item.InteresNeto);
                    cmdDet.ExecuteNonQuery();
                }

                tr.Commit();

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Cotización guardada correctamente. Número: " + numeroCotizacion;
            }
            catch (Exception ex)
            {
                if (tr != null)
                    tr.Rollback();

                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al guardar cotización: " + ex.Message;
            }
            finally
            {
                if (cn != null && cn.State == ConnectionState.Open)
                    cn.Close();
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtCedula.Text = "";
            txtNombre.Text = "";
            txtTelefono.Text = "";
            txtCorreo.Text = "";
            txtMonto.Text = "";

            ddlProducto.SelectedIndex = 0;
            ddlPlazo.Items.Clear();
            ddlPlazo.Items.Insert(0, new ListItem("Seleccione...", ""));
            txtMoneda.Text = "";

            lblCliente.Text = "";
            lblProducto.Text = "";
            lblMonto.Text = "";
            lblPlazo.Text = "";
            lblTasa.Text = "";
            lblBruto.Text = "";
            lblImpuesto.Text = "";
            lblNeto.Text = "";
            lblMensaje.Text = "";

            gvDetalle.DataSource = null;
            gvDetalle.DataBind();

            Session["DetalleActual"] = null;
        }

        private int ObtenerIdProducto(string codigoProducto)
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_Producto_ObtenerIdPorCodigo", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CodigoProducto", codigoProducto);

                cn.Open();
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        private int ObtenerIdPlazo(string descripcion)
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_Plazo_ObtenerIdPorDescripcion", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Descripcion", descripcion);

                cn.Open();
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        private decimal ObtenerTasa(int idProducto, int idPlazo)
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_Tasa_ObtenerPorProductoYPlazo", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdProducto", idProducto);
                cmd.Parameters.AddWithValue("@IdPlazo", idPlazo);

                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                    return Convert.ToDecimal(dr["TasaAnual"]);

                throw new Exception("No existe una tasa configurada para el producto y plazo seleccionados.");
            }
        }

        private int ObtenerMeses(string plazoTexto)
        {
            if (plazoTexto == "15 días")
                return 1;

            return Convert.ToInt32(plazoTexto.Replace(" meses", "").Replace(" mes", ""));
        }

        private int ObtenerOCrearCliente(SqlConnection cn, SqlTransaction tr)
        {
            // Si es administrador, puede buscar o crear cliente según la cédula escrita.
            if (Convert.ToInt32(Session["IdRol"]) == 1)
            {
                SqlCommand cmdBuscar = new SqlCommand("dbo.sp_Cliente_ObtenerPorIdentificacion", cn, tr);
                cmdBuscar.CommandType = CommandType.StoredProcedure;
                cmdBuscar.Parameters.AddWithValue("@Identificacion", txtCedula.Text.Trim());

                object result = cmdBuscar.ExecuteScalar();

                if (result != null)
                    return Convert.ToInt32(result);

                SqlCommand cmdInsert = new SqlCommand("dbo.sp_Cliente_Insertar", cn, tr);
                cmdInsert.CommandType = CommandType.StoredProcedure;
                cmdInsert.Parameters.AddWithValue("@Identificacion", txtCedula.Text.Trim());
                cmdInsert.Parameters.AddWithValue("@NombreCompleto", txtNombre.Text.Trim());
                cmdInsert.Parameters.AddWithValue("@Telefono", txtTelefono.Text.Trim());
                cmdInsert.Parameters.AddWithValue("@Correo", txtCorreo.Text.Trim());

                return Convert.ToInt32(cmdInsert.ExecuteScalar());
            }
            else
            {
                // Si es cliente normal, SIEMPRE usar el cliente ligado al usuario
                SqlCommand cmd = new SqlCommand("SELECT IdCliente FROM dbo.Usuario WHERE IdUsuario = @IdUsuario", cn, tr);
                cmd.Parameters.AddWithValue("@IdUsuario", Convert.ToInt32(Session["IdUsuario"]));

                object result = cmd.ExecuteScalar();

                if (result == null || result == DBNull.Value)
                    throw new Exception("Su usuario no está asociado a un cliente. Debe asignarse primero en mantenimiento de usuarios.");

                return Convert.ToInt32(result);
            }
        }

        private int ObtenerIdTasa(SqlConnection cn, SqlTransaction tr, int idProducto, int idPlazo)
        {
            SqlCommand cmd = new SqlCommand("dbo.sp_Tasa_ObtenerPorProductoYPlazo", cn, tr);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IdProducto", idProducto);
            cmd.Parameters.AddWithValue("@IdPlazo", idPlazo);

            SqlDataReader dr = cmd.ExecuteReader();
            int idTasa = 0;

            if (dr.Read())
                idTasa = Convert.ToInt32(dr["IdTasa"]);

            dr.Close();

            return idTasa;
        }

        private int ObtenerSiguienteNumeroCotizacion(SqlConnection cn, SqlTransaction tr)
        {
            SqlCommand cmd = new SqlCommand("dbo.sp_Cotizacion_ObtenerSiguienteNumero", cn, tr);
            cmd.CommandType = CommandType.StoredProcedure;
            return Convert.ToInt32(cmd.ExecuteScalar());
        }
    }
}