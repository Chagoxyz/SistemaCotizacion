using System;
using System.Data;
using System.Data.SqlClient;
using SistemaCotizacion.Utilidades;

namespace SistemaCotizacion.Vistas
{
    public partial class Plazos : System.Web.UI.Page
    {
        // ================= CARGA DE LA PÁGINA =================
        protected void Page_Load(object sender, EventArgs e)
        {
            // Solo ejecuta al cargar por primera vez
            if (!IsPostBack)
            {
                CargarPlazos();
                lblMensaje.Text = string.Empty;
            }
        }

        // ================= CARGAR DATOS =================
        private void CargarPlazos()
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                // Llamado al procedimiento que lista todos los plazos
                SqlCommand cmd = new SqlCommand("dbo.sp_Plazo_Listar", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Carga los datos en el GridView
                gvPlazos.DataSource = dt;
                gvPlazos.DataBind();
            }
        }

        // ================= GUARDAR =================
        protected void btnGuardarPlazo_Click(object sender, EventArgs e)
        {
            try
            {
                // Validación antes de guardar
                if (!ValidarCamposPlazo())
                    return;

                int cantidad = Convert.ToInt32(txtCantidadPlazo.Text.Trim());

                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    // Inserta nuevo plazo
                    SqlCommand cmd = new SqlCommand("dbo.sp_Plazo_Insertar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Descripcion", txtDescripcionPlazo.Text.Trim());
                    cmd.Parameters.AddWithValue("@Cantidad", cantidad);
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

        // ================= EDITAR =================
        protected void btnEditarPlazo_Click(object sender, EventArgs e)
        {
            try
            {
                // Validación antes de editar
                if (!ValidarCamposPlazo())
                    return;

                int cantidad = Convert.ToInt32(txtCantidadPlazo.Text.Trim());

                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    // Actualiza el plazo existente
                    SqlCommand cmd = new SqlCommand("dbo.sp_Plazo_Actualizar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Descripcion", txtDescripcionPlazo.Text.Trim());
                    cmd.Parameters.AddWithValue("@Cantidad", cantidad);
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

        // ================= ELIMINAR =================
        protected void btnEliminarPlazo_Click(object sender, EventArgs e)
        {
            try
            {
                // Validación básica
                if (string.IsNullOrWhiteSpace(txtDescripcionPlazo.Text))
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Debe ingresar la descripción del plazo que desea eliminar.";
                    return;
                }

                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    // Elimina el plazo por descripción
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

        // ================= VALIDACIONES =================
        private bool ValidarCamposPlazo()
        {
            // Verifica campos vacíos
            if (string.IsNullOrWhiteSpace(txtDescripcionPlazo.Text) ||
                string.IsNullOrWhiteSpace(txtCantidadPlazo.Text) ||
                string.IsNullOrWhiteSpace(ddlTipoPlazo.SelectedValue) ||
                string.IsNullOrWhiteSpace(ddlEstadoPlazo.SelectedValue))
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Debe completar todos los campos antes de continuar.";
                return false;
            }

            // Verifica que cantidad sea número
            int cantidad;
            if (!int.TryParse(txtCantidadPlazo.Text.Trim(), out cantidad))
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "La cantidad debe ser un número válido.";
                return false;
            }

            // Verifica valor lógico
            if (cantidad <= 0)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "La cantidad debe ser mayor a cero.";
                return false;
            }

            return true;
        }

        // ================= LIMPIAR FORMULARIO =================
        private void Limpiar()
        {
            txtDescripcionPlazo.Text = "";
            txtCantidadPlazo.Text = "";
            ddlTipoPlazo.SelectedIndex = 0;
            ddlEstadoPlazo.SelectedIndex = 0;
        }
    }
}