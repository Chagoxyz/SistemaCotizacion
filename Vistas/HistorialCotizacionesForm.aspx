<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HistorialCotizacionesForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.HistorialCotizaciones" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Historial de Cotizaciones</title>

    <%-- Hoja de estilos utilizada para dar formato a esta pantalla --%>
    <link href="../Estilos/HistorialCotizacionesStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">

        <%-- Barra superior con el título de la página y el enlace para volver al menú principal --%>
        <div class="topbar">
            <div class="logo">Historial de Cotizaciones</div>
            <a class="volver" href="MenuPrincipalForm.aspx">← Menú Principal</a>
        </div>

        <%-- Contenedor principal donde se muestra el formulario de búsqueda y la tabla de resultados --%>
        <div class="contenedor">
            <div class="card">

                <h2>Consulta de Historial</h2>

                <%-- Filtros para buscar cotizaciones por cliente o por producto --%>
                <div class="grid">
                    <div>
                        <label>Cliente</label>
                        <asp:TextBox ID="txtBuscarClienteHistorial" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <div>
                        <label>Producto</label>
                        <asp:DropDownList ID="ddlProductoHistorial" runat="server" CssClass="input">
                            <asp:ListItem Text="Todos" Value="" />
                            <asp:ListItem Text="CC" Value="CC" />
                            <asp:ListItem Text="CF" Value="CF" />
                            <asp:ListItem Text="DS" Value="DS" />
                            <asp:ListItem Text="DV" Value="DV" />
                        </asp:DropDownList>
                    </div>
                </div>

                <%-- Botones para ejecutar la búsqueda o limpiar los filtros --%>
                <div class="acciones">
                    <asp:Button ID="btnBuscarHistorial" runat="server" Text="Buscar" CssClass="btn-primary" OnClick="btnBuscarHistorial_Click" />
                    <asp:Button ID="btnLimpiarHistorial" runat="server" Text="Limpiar" CssClass="btn-sec" OnClick="btnLimpiarHistorial_Click" CausesValidation="false" />
                </div>

                <%-- Muestra mensajes de confirmación o error al usuario --%>
                <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje"></asp:Label>

                <h3 class="seccion">Resultados</h3>

                <%-- Tabla donde se muestran las cotizaciones encontradas según los filtros aplicados --%>
                <asp:GridView ID="gvHistorialCotizaciones" runat="server" CssClass="tabla" AutoGenerateColumns="False"
                         EmptyDataText="No hay cotizaciones para mostrar." ShowHeaderWhenEmpty="true">
                    <Columns>
                        <asp:BoundField HeaderText="Número" DataField="NumeroCotizacion" />
                        <asp:BoundField HeaderText="Cliente" DataField="Cliente" />
                        <asp:BoundField HeaderText="Usuario" DataField="Usuario" />
                        <asp:BoundField HeaderText="Producto" DataField="Producto" />
                        <asp:BoundField HeaderText="Monto" DataField="Monto" DataFormatString="{0:N2}" />
                        <asp:BoundField HeaderText="Plazo" DataField="Plazo" />
                        <asp:BoundField HeaderText="Fecha" DataField="Fecha" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" />
                    </Columns>
                </asp:GridView>

            </div>
        </div>

    </form>
</body>
</html>