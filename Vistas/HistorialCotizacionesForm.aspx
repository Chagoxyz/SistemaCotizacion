<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HistorialCotizacionesForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.HistorialCotizaciones" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Historial de Cotizaciones</title>
    <link href="../Estilos/HistorialCotizacionesStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">

        <div class="topbar">
            <div class="logo">Historial de Cotizaciones</div>
            <a class="volver" href="MenuPrincipalForm.aspx">← Menú Principal</a>
        </div>

        <div class="contenedor">
            <div class="card">

                <h2>Consulta de Historial</h2>

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

                <div class="acciones">
                        <asp:Button ID="btnBuscarHistorial" runat="server" Text="Buscar" CssClass="btn-primary" OnClick="btnBuscarHistorial_Click" />
                        <asp:Button ID="btnLimpiarHistorial" runat="server" Text="Limpiar" CssClass="btn-sec" OnClick="btnLimpiarHistorial_Click" CausesValidation="false" />
                    </div>

                    <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje"></asp:Label>

                <h3 class="seccion">Resultados</h3>

                <asp:GridView ID="gvHistorialCotizaciones" runat="server" CssClass="tabla" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField HeaderText="Número" DataField="NumeroCotizacion" />
                        <asp:BoundField HeaderText="Cliente" DataField="Cliente" />
                        <asp:BoundField HeaderText="Producto" DataField="Producto" />
                        <asp:BoundField HeaderText="Monto" DataField="Monto" />
                        <asp:BoundField HeaderText="Plazo" DataField="Plazo" />
                        <asp:BoundField HeaderText="Fecha" DataField="Fecha" />
                    </Columns>
                </asp:GridView>

            </div>
        </div>

    </form>
</body>
</html>