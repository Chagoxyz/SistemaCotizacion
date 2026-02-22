<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HistorialForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.Historial" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Historial de Cotizaciones</title>
     <link href="../Estilos/HistorialStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>

    <form id="form1" runat="server">

        <!-- Barra superior -->
        <div class="topbar">
            <div class="logo">Historial de Cotizaciones</div>
            <a class="volver" href="MenuPrincipal.aspx">← Menú Principal</a>
        </div>

        <!-- Contenedor -->
        <div class="contenedor">

            <div class="card">

                <h2>Listado de Cotizaciones</h2>

                <!-- FILTROS -->
                <div class="filtros">

                    <div>
                        <label>Cliente</label>
                        <asp:TextBox ID="txtBuscarCliente" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <div>
                        <label>Producto</label>
                        <asp:DropDownList ID="ddlFiltroProducto" runat="server" CssClass="input">
                            <asp:ListItem Text="Todos" Value="" />
                            <asp:ListItem Text="Colón Crece" />
                            <asp:ListItem Text="Colón Futuro Plus" />
                            <asp:ListItem Text="Dólar Seguro" />
                            <asp:ListItem Text="Dólar Visión" />
                        </asp:DropDownList>
                    </div>

                    <div>
                        <label>Fecha</label>
                        <asp:TextBox ID="txtFecha" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                </div>

                <!-- BOTONES -->
                <div class="acciones">

                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn-primary" />
                    <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" CssClass="btn-sec" />

                </div>

                <!-- TABLA -->
                <asp:GridView ID="gvHistorial" runat="server"
                    CssClass="tabla"
                    AutoGenerateColumns="False">

                    <Columns>
                        <asp:BoundField HeaderText="N°" DataField="Numero" />
                        <asp:BoundField HeaderText="Cliente" DataField="Cliente" />
                        <asp:BoundField HeaderText="Producto" DataField="Producto" />
                        <asp:BoundField HeaderText="Monto" DataField="Monto" />
                        <asp:BoundField HeaderText="Plazo" DataField="Plazo" />
                        <asp:BoundField HeaderText="Fecha" DataField="Fecha" />

                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>
                                <asp:Button ID="btnVer" runat="server" Text="Ver" CssClass="btn-mini" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                </asp:GridView>

                <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje"></asp:Label>

            </div>

        </div>

    </form>

</body>
</html>