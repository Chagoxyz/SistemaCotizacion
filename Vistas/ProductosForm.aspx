<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductosForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.Productos" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mantenimiento de Productos</title>

    <%-- Hoja de estilos para la gestión de productos --%>
    <link href="/Estilos/ProductosStyles.css" rel="stylesheet" />
</head>
<body>
<form id="form1" runat="server">

    <%-- Barra superior con título y navegación --%>
    <div class="topbar">
        <div class="logo">Mantenimiento de Productos</div>
        <a class="volver" href="MenuPrincipalForm.aspx">← Menú Principal</a>
    </div>

    <%-- Contenedor principal --%>
    <div class="contenedor">
        <div class="card">

            <h2>Gestión de Productos</h2>

            <%-- Formulario de ingreso y edición de productos --%>
            <div class="grid">

                <%-- Código del producto (ej: CC, CF, DS, DV) --%>
                <div>
                    <label>Código</label>
                    <asp:TextBox ID="txtCodigo" runat="server" CssClass="input"></asp:TextBox>
                </div>

                <%-- Nombre del producto --%>
                <div>
                    <label>Nombre del Producto</label>
                    <asp:TextBox ID="txtNombreProducto" runat="server" CssClass="input"></asp:TextBox>
                </div>

                <%-- Selección del tipo de producto (relacionado con moneda/producto APF) --%>
                <div>
                    <label>Moneda</label>
                    <asp:DropDownList ID="ddlMoneda" runat="server" CssClass="input">
                        <asp:ListItem Text="Seleccione..." Value="" />
                        <asp:ListItem Text="Colón Crece (CC)" Value="CC" />
                        <asp:ListItem Text="Colón Futuro Plus (CF)" Value="CF" />
                        <asp:ListItem Text="Dólar Seguro (DS)" Value="DS" />
                        <asp:ListItem Text="Dólar Visión (DV)" Value="DV" />
                    </asp:DropDownList>
                </div>

                <%-- Estado del producto (activo o inactivo) --%>
                <div>
                    <label>Estado</label>
                    <asp:DropDownList ID="ddlEstadoProducto" runat="server" CssClass="input">
                        <asp:ListItem Text="Activo" Value="Activo" />
                        <asp:ListItem Text="Inactivo" Value="Inactivo" />
                    </asp:DropDownList>
                </div>
            </div>

            <%-- Botones de acción del CRUD --%>
           <div class="acciones">

                <%-- Guarda un nuevo producto --%>
                <asp:Button ID="btnGuardarProducto" runat="server" Text="Guardar" CssClass="btn-primary" OnClick="btnGuardarProducto_Click" />

                <%-- Edita un producto existente --%>
                <asp:Button ID="btnEditarProducto" runat="server" Text="Editar" CssClass="btn-sec" OnClick="btnEditarProducto_Click" />

                <%-- Elimina un producto --%>
                <asp:Button ID="btnEliminarProducto" runat="server" Text="Eliminar" CssClass="btn-danger" OnClick="btnEliminarProducto_Click" />

                <%-- Limpia el formulario --%>
                <asp:Button ID="btnLimpiarProducto" runat="server" Text="Limpiar" CssClass="btn-sec" OnClick="btnLimpiarProducto_Click" CausesValidation="false" />
            </div>

            <%-- Mensajes de éxito o error --%>
            <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje"></asp:Label>

            <%-- Tabla donde se listan los productos registrados --%>
            <h3 class="seccion">Lista de Productos</h3>

            <asp:GridView ID="gvProductos" runat="server" CssClass="tabla" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField HeaderText="Código" DataField="CodigoProducto" />
                    <asp:BoundField HeaderText="Nombre" DataField="NombreProducto" />
                    <asp:BoundField HeaderText="Moneda" DataField="Moneda" />
                    <asp:BoundField HeaderText="Estado" DataField="Estado" />
                </Columns>
            </asp:GridView>

        </div>
    </div>

</form>
</body>
</html>