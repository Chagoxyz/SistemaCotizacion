using System;
using System.Data;
using System.Data.SqlClient;
using SistemaCotizacion.Utilidades;

namespace SistemaCotizacion.Vistas
{
    public partial class Usuarios : System.Web.UI.Page
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
                CargarUsuarios();
                lblMensaje.Text = string.Empty;
            }
        }

        private void CargarUsuarios()
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_Usuario_Listar", cn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvUsuarios.DataSource = dt;
                gvUsuarios.DataBind();
            }
        }

        private int ObtenerRolUsuario()
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_Rol_ObtenerIdPorNombre", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@NombreRol", "Usuario");

                cn.Open();
                object result = cmd.ExecuteScalar();

                if (result == null)
                    throw new Exception("No existe el rol Usuario.");

                return Convert.ToInt32(result);
            }
        }

        private int ObtenerOCrearClienteDesdeUsuario(string cedula, string nombre, string telefono, string correo)
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                cn.Open();

                SqlCommand cmdBuscar = new SqlCommand("dbo.sp_Cliente_ObtenerPorIdentificacion", cn);
                cmdBuscar.CommandType = CommandType.StoredProcedure;
                cmdBuscar.Parameters.AddWithValue("@Identificacion", cedula);

                object result = cmdBuscar.ExecuteScalar();

                if (result != null)
                    return Convert.ToInt32(result);

                SqlCommand cmdInsert = new SqlCommand("dbo.sp_Cliente_Insertar", cn);
                cmdInsert.CommandType = CommandType.StoredProcedure;
                cmdInsert.Parameters.AddWithValue("@Identificacion", cedula);
                cmdInsert.Parameters.AddWithValue("@NombreCompleto", nombre);
                cmdInsert.Parameters.AddWithValue("@Telefono", telefono);
                cmdInsert.Parameters.AddWithValue("@Correo", correo);

                return Convert.ToInt32(cmdInsert.ExecuteScalar());
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtNombreCompleto.Text) ||
                    string.IsNullOrWhiteSpace(txtNombreUsuario.Text) ||
                    string.IsNullOrWhiteSpace(txtContrasena.Text) ||
                    string.IsNullOrWhiteSpace(txtCedulaCliente.Text) ||
                    string.IsNullOrWhiteSpace(txtTelefonoCliente.Text) ||
                    string.IsNullOrWhiteSpace(txtCorreoCliente.Text))
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Debe completar todos los campos del usuario y del cliente.";
                    return;
                }

                int idRol = ObtenerRolUsuario();
                int idCliente = ObtenerOCrearClienteDesdeUsuario(
                    txtCedulaCliente.Text.Trim(),
                    txtNombreCompleto.Text.Trim(),
                    txtTelefonoCliente.Text.Trim(),
                    txtCorreoCliente.Text.Trim()
                );

                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("dbo.sp_Usuario_Insertar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@NombreCompleto", txtNombreCompleto.Text.Trim());
                    cmd.Parameters.AddWithValue("@NombreUsuario", txtNombreUsuario.Text.Trim());
                    cmd.Parameters.AddWithValue("@Contrasena", txtContrasena.Text.Trim());
                    cmd.Parameters.AddWithValue("@IdRol", idRol);
                    cmd.Parameters.AddWithValue("@IdCliente", idCliente);
                    cmd.Parameters.AddWithValue("@Estado", ddlEstado.SelectedValue);

                    cn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Usuario guardado correctamente.";
                Limpiar();
                CargarUsuarios();
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al guardar usuario: " + ex.Message;
            }
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtNombreCompleto.Text) ||
                    string.IsNullOrWhiteSpace(txtNombreUsuario.Text) ||
                    string.IsNullOrWhiteSpace(txtContrasena.Text) ||
                    string.IsNullOrWhiteSpace(txtCedulaCliente.Text) ||
                    string.IsNullOrWhiteSpace(txtTelefonoCliente.Text) ||
                    string.IsNullOrWhiteSpace(txtCorreoCliente.Text))
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Debe completar todos los campos del usuario y del cliente.";
                    return;
                }

                int idRol = ObtenerRolUsuario();
                int idCliente = ObtenerOCrearClienteDesdeUsuario(
                    txtCedulaCliente.Text.Trim(),
                    txtNombreCompleto.Text.Trim(),
                    txtTelefonoCliente.Text.Trim(),
                    txtCorreoCliente.Text.Trim()
                );

                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("dbo.sp_Usuario_Actualizar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@NombreCompleto", txtNombreCompleto.Text.Trim());
                    cmd.Parameters.AddWithValue("@NombreUsuario", txtNombreUsuario.Text.Trim());
                    cmd.Parameters.AddWithValue("@Contrasena", txtContrasena.Text.Trim());
                    cmd.Parameters.AddWithValue("@IdRol", idRol);
                    cmd.Parameters.AddWithValue("@IdCliente", idCliente);
                    cmd.Parameters.AddWithValue("@Estado", ddlEstado.SelectedValue);

                    cn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Usuario actualizado correctamente.";
                Limpiar();
                CargarUsuarios();
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al editar usuario: " + ex.Message;
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection cn = ConexionDB.ObtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("dbo.sp_Usuario_Eliminar", cn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@NombreUsuario", txtNombreUsuario.Text.Trim());

                    cn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Usuario eliminado correctamente.";
                Limpiar();
                CargarUsuarios();
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al eliminar usuario: " + ex.Message;
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Limpiar();
            lblMensaje.Text = "";
        }

        private void Limpiar()
        {
            txtNombreCompleto.Text = "";
            txtNombreUsuario.Text = "";
            txtContrasena.Text = "";
            txtCedulaCliente.Text = "";
            txtTelefonoCliente.Text = "";
            txtCorreoCliente.Text = "";
            ddlEstado.SelectedIndex = 0;
        }
    }
}