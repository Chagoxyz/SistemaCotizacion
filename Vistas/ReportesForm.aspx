<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportesForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.Reportes" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reportes</title>
    <link href="../Estilos/ReportesStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">

        <div class="topbar">
            <div class="logo">Reportes del Sistema</div>
            <a class="volver" href="MenuPrincipalForm.aspx">← Menú Principal</a>
        </div>

        <div class="contenedor">
            <div class="card">

                <h2>Reportes por Cliente</h2>
                <p class="subtexto">
                    Selecciona un cliente para ver sus cotizaciones y exportarlas de forma individual o en conjunto.
                </p>

                <div class="grid">
                    <div>
                        <label>Cliente</label>
                        <asp:DropDownList ID="ddlClienteReporte" runat="server" CssClass="input"></asp:DropDownList>
                    </div>

                    <div>
                        <label>Formato</label>
                        <asp:DropDownList ID="ddlFormatoReporte" runat="server" CssClass="input">
                            <asp:ListItem Text="Excel" Value="Excel" />
                            <asp:ListItem Text="PDF" Value="PDF" />
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="acciones">
                    <asp:Button ID="btnBuscarReporte" runat="server" Text="Buscar Cotizaciones" CssClass="btn-primary" OnClick="btnBuscarReporte_Click" />
                    <asp:Button ID="btnExportarSeleccionada" runat="server" Text="Exportar Seleccionada" CssClass="btn-sec" OnClick="btnExportarSeleccionada_Click" />
                    <asp:Button ID="btnExportarTodas" runat="server" Text="Exportar Todas" CssClass="btn-primary" OnClick="btnExportarTodas_Click" />
                    <asp:Button ID="btnLimpiarReporte" runat="server" Text="Limpiar" CssClass="btn-sec" OnClick="btnLimpiarReporte_Click" CausesValidation="false" />
                </div>

                <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje"></asp:Label>

                <div class="seleccion-info">
                    <strong>Cotización seleccionada:</strong>
                    <asp:Label ID="lblCotizacionSeleccionada" runat="server" Text="Ninguna"></asp:Label>
                </div>

                <h3 class="seccion">Vista previa del reporte</h3>

                <asp:GridView ID="gvReportes" runat="server" CssClass="tabla" AutoGenerateColumns="False"
                    EmptyDataText="No hay cotizaciones para mostrar."
                    ShowHeaderWhenEmpty="true"
                    OnRowCommand="gvReportes_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Acción">
                            <ItemTemplate>
                                <asp:Button ID="btnSeleccionar" runat="server"
                                    Text="Seleccionar"
                                    CommandName="SeleccionarCotizacion"
                                    CommandArgument='<%# Eval("NumeroCotizacion") %>'
                                    CssClass="btn-mini" />
                            </ItemTemplate>
                        </asp:TemplateField>

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