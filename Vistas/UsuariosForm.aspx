<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsuariosForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.Usuarios" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mantenimiento de Usuarios</title>
    <link href="/Estilos/UsuariosStyles.css" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server">

    <div class="topbar">
        <div class="logo">Mantenimiento de Usuarios</div>
        <a class="volver" href="MenuPrincipalForm.aspx">← Menú Principal</a>
    </div>

    <div class="contenedor">
        <div class="card">
            <h2>Gestión de Usuarios</h2>

            <div class="grid">

                <!-- LO QUE YA TENÍAS -->
                <div>
                    <label>Nombre Completo</label>
                    <asp:TextBox ID="txtNombreCompleto" runat="server" CssClass="input"></asp:TextBox>
                </div>

                <div>
                    <label>Nombre de Usuario</label>
                    <asp:TextBox ID="txtNombreUsuario" runat="server" CssClass="input"></asp:TextBox>
                </div>

                <div>
                    <label>Contraseña</label>
                    <asp:TextBox ID="txtContrasena" runat="server" CssClass="input" TextMode="Password"></asp:TextBox>
                </div>

                <div>
                    <label>Estado</label>
                    <asp:DropDownList ID="ddlEstado" runat="server" CssClass="input">
                        <asp:ListItem Text="Activo" Value="Activo" />
                        <asp:ListItem Text="Inactivo" Value="Inactivo" />
                    </asp:DropDownList>
                </div>

                <!-- NUEVO: DATOS DEL CLIENTE -->
                <div>
                    <label>Cédula</label>
                    <asp:TextBox ID="txtCedulaCliente" runat="server" CssClass="input"></asp:TextBox>
                </div>

                <div>
                    <label>Teléfono</label>
                    <asp:TextBox ID="txtTelefonoCliente" runat="server" CssClass="input"></asp:TextBox>
                </div>

                <div>
                    <label>Correo</label>
                    <asp:TextBox ID="txtCorreoCliente" runat="server" CssClass="input"></asp:TextBox>
                </div>

            </div>

            <!-- BOTONES (NO SE TOCAN) -->
            <div class="acciones">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn-primary" OnClick="btnGuardar_Click" />
                <asp:Button ID="btnEditar" runat="server" Text="Editar" CssClass="btn-sec" OnClick="btnEditar_Click" />
                <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn-danger" OnClick="btnEliminar_Click" />
                <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" CssClass="btn-sec" OnClick="btnLimpiar_Click" CausesValidation="false" />
            </div>

            <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje"></asp:Label>

            <h3 class="seccion">Lista de Usuarios</h3>

            <asp:GridView ID="gvUsuarios" runat="server" CssClass="tabla" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField HeaderText="ID" DataField="IdUsuario" />
                    <asp:BoundField HeaderText="Nombre" DataField="NombreCompleto" />
                    <asp:BoundField HeaderText="Usuario" DataField="NombreUsuario" />
                    <asp:BoundField HeaderText="Rol" DataField="Rol" />
                    <asp:BoundField HeaderText="Estado" DataField="Estado" />
                </Columns>
            </asp:GridView>

        </div>
    </div>

</form>
</body>
</html>