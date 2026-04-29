<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MonedasForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.Monedas" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestión de Monedas</title>

    <%-- Hoja de estilos específica para la pantalla de monedas --%>
    <link href="../Estilos/MonedasStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">

        <%-- Barra superior con título y navegación al menú principal --%>
        <div class="topbar">
            <div class="logo">Gestión de Monedas</div>
            <a class="volver" href="MenuPrincipalForm.aspx">← Menú Principal</a>
        </div>

        <%-- Contenedor principal de la pantalla --%>
        <div class="contenedor">
            <div class="card">

                <h2>Mantenimiento de Monedas</h2>

                <%-- Formulario para ingresar o editar datos de moneda --%>
                <div class="grid">

                    <%-- Campo para el código de la moneda (ej: USD, CRC) --%>
                    <div>
                        <label>Código de Moneda</label>
                        <asp:TextBox ID="txtCodigoMoneda" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <%-- Campo para el nombre completo de la moneda --%>
                    <div>
                        <label>Nombre de Moneda</label>
                        <asp:TextBox ID="txtNombreMoneda" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <%-- Campo para el símbolo de la moneda (ej: $, ₡, €) --%>
                    <div>
                        <label>Símbolo</label>
                        <asp:TextBox ID="txtSimboloMoneda" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <%-- Selección del estado de la moneda (Activa o Inactiva) --%>
                    <div>
                        <label>Estado</label>
                        <asp:DropDownList ID="ddlEstadoMoneda" runat="server" CssClass="input">
                            <asp:ListItem Text="Activo" Value="Activo" />
                            <asp:ListItem Text="Inactivo" Value="Inactivo" />
                        </asp:DropDownList>
                    </div>
                </div>

                <%-- Botones de acciones CRUD: guardar, editar y eliminar --%>
                <div class="acciones">
                    <asp:Button ID="btnGuardarMoneda" runat="server" Text="Guardar" CssClass="btn-primary" OnClick="btnGuardarMoneda_Click" />
                    <asp:Button ID="btnEditarMoneda" runat="server" Text="Editar" CssClass="btn-sec" OnClick="btnEditarMoneda_Click" />
                    <asp:Button ID="btnEliminarMoneda" runat="server" Text="Eliminar" CssClass="btn-danger" OnClick="btnEliminarMoneda_Click" />
                </div>

                <%-- Etiqueta para mostrar mensajes de error o confirmación --%>
                <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje"></asp:Label>

                <h3 class="seccion">Lista de Monedas</h3>

                <%-- Tabla que muestra todas las monedas registradas en el sistema --%>
                <asp:GridView ID="gvMonedas" runat="server" CssClass="tabla" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField HeaderText="Código" DataField="Codigo" />
                        <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                        <asp:BoundField HeaderText="Símbolo" DataField="Simbolo" />
                        <asp:BoundField HeaderText="Estado" DataField="Estado" />
                    </Columns>
                </asp:GridView>

            </div>
        </div>

    </form>
</body>
</html>