using System;
using System.Data;
using System.Data.SqlClient;
using SistemaCotizacion.Utilidades;

namespace SistemaCotizacion.Vistas
{
    public partial class Monedas : System.Web.UI.Page
    {
        // Se ejecuta cada vez que se carga la página
        protected void Page_Load(object sender, EventArgs e)
        {
            // Solo carga los datos la primera vez (evita recargar en postback)
            if (!IsPostBack)
            {
                CargarMonedas();
                lblMensaje.Text = string.Empty;
            }
        }

        // Método que consulta todas las monedas desde la base de datos
        // y las muestra en el GridView
        private void CargarMonedas()
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                // Llama al procedimiento almacenado que lista las monedas
                SqlCommand cmd = new SqlCommand("dbo.sp_Moneda_Listar", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                // Se llena un DataTable con los resultados
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Se asigna la información al GridView
                gvMonedas.DataSource = dt;
                gvMonedas.DataBind();
            }
        }

        // Evento para guardar una nueva moneda
        protected void btnGuardarMoneda_Click(object sender, EventArgs e)
        {
            try
            {
                // VALIDACIÓN: evita guardar campos vacíos
                if (string.IsNullOrWhiteSpace(txtCodigoMoneda.Text) ||
                    string.IsNullOrWhiteSpace(txtNombreMoneda.Text) ||
                    string.IsNullOrWhiteSpace(txtSimboloMoneda.Text))
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Debe completar todos los campos antes de guardar.";
                    return;
                }

                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    // Llama al procedimiento almacenado para insertar moneda
                    SqlCommand cmd = new SqlCommand("dbo.sp_Moneda_Insertar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Parámetros enviados al procedimiento
                    cmd.Parameters.AddWithValue("@CodigoMoneda", txtCodigoMoneda.Text.Trim());
                    cmd.Parameters.AddWithValue("@NombreMoneda", txtNombreMoneda.Text.Trim());
                    cmd.Parameters.AddWithValue("@Simbolo", txtSimboloMoneda.Text.Trim());
                    cmd.Parameters.AddWithValue("@Estado", ddlEstadoMoneda.SelectedValue);

                    cn.Open();
                    cmd.ExecuteNonQuery();
                }

                // Mensaje de éxito
                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Moneda guardada correctamente.";

                // Limpia campos y recarga la tabla
                Limpiar();
                CargarMonedas();
            }
            catch (Exception ex)
            {
                // Manejo de errores
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al guardar moneda: " + ex.Message;
            }
        }

        // Evento para editar una moneda existente
        protected void btnEditarMoneda_Click(object sender, EventArgs e)
        {
            try
            {
                // VALIDACIÓN: evita editar con campos vacíos
                if (string.IsNullOrWhiteSpace(txtCodigoMoneda.Text) ||
                    string.IsNullOrWhiteSpace(txtNombreMoneda.Text) ||
                    string.IsNullOrWhiteSpace(txtSimboloMoneda.Text))
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Debe completar todos los campos antes de editar.";
                    return;
                }

                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    // Llama al procedimiento almacenado para actualizar moneda
                    SqlCommand cmd = new SqlCommand("dbo.sp_Moneda_Actualizar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@CodigoMoneda", txtCodigoMoneda.Text.Trim());
                    cmd.Parameters.AddWithValue("@NombreMoneda", txtNombreMoneda.Text.Trim());
                    cmd.Parameters.AddWithValue("@Simbolo", txtSimboloMoneda.Text.Trim());
                    cmd.Parameters.AddWithValue("@Estado", ddlEstadoMoneda.SelectedValue);

                    cn.Open();
                    cmd.ExecuteNonQuery();
                }

                // Mensaje de éxito
                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Moneda actualizada correctamente.";

                Limpiar();
                CargarMonedas();
            }
            catch (Exception ex)
            {
                // Manejo de errores
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al editar moneda: " + ex.Message;
            }
        }

        // Evento para eliminar una moneda
        protected void btnEliminarMoneda_Click(object sender, EventArgs e)
        {
            try
            {
                // VALIDACIÓN: debe ingresar el código para eliminar
                if (string.IsNullOrWhiteSpace(txtCodigoMoneda.Text))
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Debe ingresar el código de la moneda a eliminar.";
                    return;
                }

                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    // Llama al procedimiento almacenado para eliminar moneda
                    SqlCommand cmd = new SqlCommand("dbo.sp_Moneda_Eliminar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@CodigoMoneda", txtCodigoMoneda.Text.Trim());

                    cn.Open();
                    cmd.ExecuteNonQuery();
                }

                // Mensaje de éxito
                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Moneda eliminada correctamente.";

                Limpiar();
                CargarMonedas();
            }
            catch (Exception ex)
            {
                // Manejo de errores
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al eliminar moneda: " + ex.Message;
            }
        }

        // Limpia los campos del formulario
        private void Limpiar()
        {
            txtCodigoMoneda.Text = "";
            txtNombreMoneda.Text = "";
            txtSimboloMoneda.Text = "";
            ddlEstadoMoneda.SelectedIndex = 0;
        }
    }
}