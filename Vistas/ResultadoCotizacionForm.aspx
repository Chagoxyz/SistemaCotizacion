<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResultadoCotizacionForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.ResultadoCotizacion" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Resultado de Cotización</title>
    <link href="../Estilos/ResultadoCotizacionStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>

    <form id="form1" runat="server">

        <!-- Barra superior -->
        <div class="topbar">
            <div class="logo">Resultado de Cotización</div>
            <a class="volver" href="MenuPrincipal.aspx">← Menú</a>
        </div>

        <div class="contenedor">

            <div class="card">

                <h2>Resumen de Cotización</h2>

                <!-- DATOS GENERALES -->
                <div class="resumen">

                    <div><strong>Cliente:</strong> <asp:Label ID="lblCliente" runat="server"/></div>
                    <div><strong>Producto:</strong> <asp:Label ID="lblProducto" runat="server"/></div>
                    <div><strong>Monto:</strong> <asp:Label ID="lblMonto" runat="server"/></div>
                    <div><strong>Plazo:</strong> <asp:Label ID="lblPlazo" runat="server"/></div>
                    <div><strong>Tasa:</strong> <asp:Label ID="lblTasa" runat="server"/></div>
                    <div><strong>Impuesto:</strong> 13%</div>

                </div>

                <!-- RESULTADOS -->
                <h3 class="seccion">Totales</h3>

                <div class="totales">

                    <div class="total-box">
                        <span>Interés Bruto</span>
                        <asp:Label ID="lblBruto" runat="server" CssClass="total-valor"/>
                    </div>

                    <div class="total-box">
                        <span>Impuesto</span>
                        <asp:Label ID="lblImpuesto" runat="server" CssClass="total-valor"/>
                    </div>

                    <div class="total-box destacado">
                        <span>Total Neto</span>
                        <asp:Label ID="lblNeto" runat="server" CssClass="total-valor"/>
                    </div>

                </div>

                <!-- TABLA DETALLE -->
                <h3 class="seccion">Detalle Mensual</h3>

                <asp:GridView ID="gvDetalle" runat="server"
                    CssClass="tabla"
                    AutoGenerateColumns="False">

                    <Columns>
                        <asp:BoundField HeaderText="Mes" DataField="Mes"/>
                        <asp:BoundField HeaderText="Monto" DataField="Monto"/>
                        <asp:BoundField HeaderText="Interés Bruto" DataField="Bruto"/>
                        <asp:BoundField HeaderText="Impuesto" DataField="Impuesto"/>
                        <asp:BoundField HeaderText="Interés Neto" DataField="Neto"/>
                    </Columns>

                </asp:GridView>

                <!-- BOTONES -->
                <div class="acciones">

                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cotización" CssClass="btn-primary"/>
                    <asp:Button ID="btnPDF" runat="server" Text="Exportar PDF" CssClass="btn-sec"/>
                    <asp:Button ID="btnExcel" runat="server" Text="Exportar Excel" CssClass="btn-sec"/>

                </div>

                <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje"/>

            </div>

        </div>

    </form>

</body>
</html>