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
        <a class="volver" href="MenuPrincipal.aspx">← Menú Principal</a>
    </div>

    <div class="contenedor">
        <div class="card">
            <h2>Gestión de Usuarios</h2>

            <div class="grid">
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
            </div>

            <div class="acciones">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn-primary" />
                <asp:Button ID="btnEditar" runat="server" Text="Editar" CssClass="btn-sec" />
                <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn-danger" />
                <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" CssClass="btn-sec" />
            </div>

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