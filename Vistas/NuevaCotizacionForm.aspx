<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NuevaCotizacionForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.NuevaCotizacion" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Nueva Cotización</title>
    <link href="../Estilos/NuevaCotizacionStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>

    <form id="form1" runat="server">

        <!-- Barra superior -->
        <div class="topbar">
            <div class="logo">Sistema APF</div>
            <div>
                <a class="volver" href="MenuPrincipal.aspx">← Volver al menú</a>
            </div>
        </div>

        <!-- Contenedor -->
        <div class="contenedor">

            <div class="card">

                <h2>Nueva Cotización</h2>

                <!-- DATOS CLIENTE -->
                <h3 class="seccion">Datos del Cliente</h3>

                <div class="grid">

                    <div>
                        <label>Cédula</label>
                        <asp:TextBox ID="txtCedula" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <div>
                        <label>Nombre</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <div>
                        <label>Teléfono</label>
                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <div>
                        <label>Correo</label>
                        <asp:TextBox ID="txtCorreo" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                </div>

                <!-- DATOS INVERSIÓN -->
                <h3 class="seccion">Datos de la Inversión</h3>

                <div class="grid">

                    <div>
                        <label>Producto</label>
                        <asp:DropDownList ID="ddlProducto" runat="server" CssClass="input">
                            <asp:ListItem Text="Seleccione..." Value="" />
                            <asp:ListItem Text="Colón Crece (CC)" Value="CC" />
                            <asp:ListItem Text="Colón Futuro Plus (CF)" Value="CF" />
                            <asp:ListItem Text="Dólar Seguro (DS)" Value="DS" />
                            <asp:ListItem Text="Dólar Visión (DV)" Value="DV" />
                        </asp:DropDownList>
                    </div>

                    <div>
                        <label>Plazo</label>
                        <asp:DropDownList ID="ddlPlazo" runat="server" CssClass="input">
                            <asp:ListItem Text="Seleccione..." />
                             <asp:ListItem>15 días</asp:ListItem>
                             <asp:ListItem>1 mes</asp:ListItem>
                             <asp:ListItem>2 meses</asp:ListItem>
                             <asp:ListItem>3 meses</asp:ListItem>
                             <asp:ListItem>4 meses</asp:ListItem>
                             <asp:ListItem>5 meses</asp:ListItem>
                             <asp:ListItem>6 meses</asp:ListItem>
                             <asp:ListItem>7 meses</asp:ListItem>
                             <asp:ListItem>8 meses</asp:ListItem>
                             <asp:ListItem>9 meses</asp:ListItem>
                             <asp:ListItem>10 meses</asp:ListItem>
                             <asp:ListItem>11 meses</asp:ListItem>
                             <asp:ListItem>12 meses</asp:ListItem>
                             <asp:ListItem>13 meses</asp:ListItem>
                             <asp:ListItem>14 meses</asp:ListItem>
                             <asp:ListItem>15 meses</asp:ListItem>
                             <asp:ListItem>16 meses</asp:ListItem>
                             <asp:ListItem>17 meses</asp:ListItem>
                             <asp:ListItem>18 meses</asp:ListItem>
                             <asp:ListItem>19 meses</asp:ListItem>
                             <asp:ListItem>20 meses</asp:ListItem>
                             <asp:ListItem>21 meses</asp:ListItem>
                             <asp:ListItem>22 meses</asp:ListItem>
                             <asp:ListItem>23 meses</asp:ListItem>
                             <asp:ListItem>24 meses</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div>
                        <label>Monto</label>
                        <asp:TextBox ID="txtMonto" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                </div>

                <!-- BOTONES -->
                <div class="botones">

                    <asp:Button ID="btnCalcular" runat="server" Text="Calcular" CssClass="btn-primary" />

                    <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" CssClass="btn-sec" />

                </div>

            </div>

        </div>


        <!-- Barra superior -->
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

        </div>

        <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje"/>

    </div>

</div>

    </form>

</body>
</html>