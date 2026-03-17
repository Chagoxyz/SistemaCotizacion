<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NuevaCotizacionForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.NuevaCotizacion" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Nueva Cotización</title>
    <link href="../Estilos/NuevaCotizacionStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>

    <form id="form1" runat="server">

        <div class="topbar">
            <div class="logo">Sistema APF</div>
            <div>
                <a class="volver" href="MenuPrincipalForm.aspx">← Volver al menú</a>
            </div>
        </div>

        <div class="contenedor">

            <div class="card">

                <h2>Nueva Cotización</h2>

                <asp:ValidationSummary ID="vsResumen" runat="server"
                    CssClass="mensaje"
                    ForeColor="Red"
                    HeaderText="Por favor corrija los siguientes errores:"
                    ValidationGroup="vgCotizacion" />

                <h3 class="seccion">Datos del Cliente</h3>

                <div class="grid">

                    <div>
                        <label>Cédula</label>
                        <asp:TextBox ID="txtCedula" runat="server" CssClass="input"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCedula" runat="server"
                            ControlToValidate="txtCedula"
                            ErrorMessage="La cédula es obligatoria."
                            ForeColor="Red"
                            Display="Dynamic"
                            ValidationGroup="vgCotizacion" />
                    </div>

                    <div>
                        <label>Nombre</label>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="input"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvNombre" runat="server"
                            ControlToValidate="txtNombre"
                            ErrorMessage="El nombre es obligatorio."
                            ForeColor="Red"
                            Display="Dynamic"
                            ValidationGroup="vgCotizacion" />
                    </div>

                    <div>
                        <label>Teléfono</label>
                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="input"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvTelefono" runat="server"
                            ControlToValidate="txtTelefono"
                            ErrorMessage="El teléfono es obligatorio."
                            ForeColor="Red"
                            Display="Dynamic"
                            ValidationGroup="vgCotizacion" />
                    </div>

                    <div>
                        <label>Correo</label>
                        <asp:TextBox ID="txtCorreo" runat="server" CssClass="input"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCorreo" runat="server"
                            ControlToValidate="txtCorreo"
                            ErrorMessage="El correo es obligatorio."
                            ForeColor="Red"
                            Display="Dynamic"
                            ValidationGroup="vgCotizacion" />
                        <asp:RegularExpressionValidator ID="revCorreo" runat="server"
                            ControlToValidate="txtCorreo"
                            ValidationExpression="\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+"
                            ErrorMessage="Ingrese un correo válido."
                            ForeColor="Red"
                            Display="Dynamic"
                            ValidationGroup="vgCotizacion" />
                    </div>

                </div>

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
                        <asp:RequiredFieldValidator ID="rfvProducto" runat="server"
                            ControlToValidate="ddlProducto"
                            InitialValue=""
                            ErrorMessage="Debe seleccionar un producto."
                            ForeColor="Red"
                            Display="Dynamic"
                            ValidationGroup="vgCotizacion" />
                    </div>

                    <div>
                        <label>Plazo</label>
                        <asp:DropDownList ID="ddlPlazo" runat="server" CssClass="input">
                            <asp:ListItem Text="Seleccione..." Value="" />
                            <asp:ListItem Text="15 días" Value="15 días" />
                            <asp:ListItem Text="1 mes" Value="1 mes" />
                            <asp:ListItem Text="2 meses" Value="2 meses" />
                            <asp:ListItem Text="3 meses" Value="3 meses" />
                            <asp:ListItem Text="4 meses" Value="4 meses" />
                            <asp:ListItem Text="5 meses" Value="5 meses" />
                            <asp:ListItem Text="6 meses" Value="6 meses" />
                            <asp:ListItem Text="7 meses" Value="7 meses" />
                            <asp:ListItem Text="8 meses" Value="8 meses" />
                            <asp:ListItem Text="9 meses" Value="9 meses" />
                            <asp:ListItem Text="10 meses" Value="10 meses" />
                            <asp:ListItem Text="11 meses" Value="11 meses" />
                            <asp:ListItem Text="12 meses" Value="12 meses" />
                            <asp:ListItem Text="13 meses" Value="13 meses" />
                            <asp:ListItem Text="14 meses" Value="14 meses" />
                            <asp:ListItem Text="15 meses" Value="15 meses" />
                            <asp:ListItem Text="16 meses" Value="16 meses" />
                            <asp:ListItem Text="17 meses" Value="17 meses" />
                            <asp:ListItem Text="18 meses" Value="18 meses" />
                            <asp:ListItem Text="19 meses" Value="19 meses" />
                            <asp:ListItem Text="20 meses" Value="20 meses" />
                            <asp:ListItem Text="21 meses" Value="21 meses" />
                            <asp:ListItem Text="22 meses" Value="22 meses" />
                            <asp:ListItem Text="23 meses" Value="23 meses" />
                            <asp:ListItem Text="24 meses" Value="24 meses" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvPlazo" runat="server"
                            ControlToValidate="ddlPlazo"
                            InitialValue=""
                            ErrorMessage="Debe seleccionar un plazo."
                            ForeColor="Red"
                            Display="Dynamic"
                            ValidationGroup="vgCotizacion" />
                    </div>

                    <div>
                        <label>Monto</label>
                        <asp:TextBox ID="txtMonto" runat="server" CssClass="input"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvMonto" runat="server"
                            ControlToValidate="txtMonto"
                            ErrorMessage="El monto es obligatorio."
                            ForeColor="Red"
                            Display="Dynamic"
                            ValidationGroup="vgCotizacion" />
                        <asp:RegularExpressionValidator ID="revMonto" runat="server"
                            ControlToValidate="txtMonto"
                            ValidationExpression="^\d+(\.\d{1,2})?$"
                            ErrorMessage="Ingrese un monto válido."
                            ForeColor="Red"
                            Display="Dynamic"
                            ValidationGroup="vgCotizacion" />
                    </div>

                </div>

                <div class="botones">
                    <asp:Button ID="btnCalcular" runat="server" Text="Calcular"
                        CssClass="btn-primary"
                        ValidationGroup="vgCotizacion"
                        OnClick="btnCalcular_Click" />

                    <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar"
                        CssClass="btn-sec"
                        CausesValidation="false"
                        OnClick="btnLimpiar_Click" />
                </div>

            </div>

        </div>

        <div class="contenedor">

            <div class="card">

                <h2>Resumen de Cotización</h2>

                <div class="resumen">
                    <div><strong>Cliente:</strong> <asp:Label ID="lblCliente" runat="server" /></div>
                    <div><strong>Producto:</strong> <asp:Label ID="lblProducto" runat="server" /></div>
                    <div><strong>Monto:</strong> <asp:Label ID="lblMonto" runat="server" /></div>
                    <div><strong>Plazo:</strong> <asp:Label ID="lblPlazo" runat="server" /></div>
                    <div><strong>Tasa:</strong> <asp:Label ID="lblTasa" runat="server" /></div>
                    <div><strong>Impuesto:</strong> 13%</div>
                </div>

                <h3 class="seccion">Totales</h3>

                <div class="totales">
                    <div class="total-box">
                        <span>Interés Bruto</span>
                        <asp:Label ID="lblBruto" runat="server" CssClass="total-valor" />
                    </div>

                    <div class="total-box">
                        <span>Impuesto</span>
                        <asp:Label ID="lblImpuesto" runat="server" CssClass="total-valor" />
                    </div>

                    <div class="total-box destacado">
                        <span>Total Neto</span>
                        <asp:Label ID="lblNeto" runat="server" CssClass="total-valor" />
                    </div>
                </div>

                <h3 class="seccion">Detalle Mensual</h3>

                <asp:GridView ID="gvDetalle" runat="server"
                    CssClass="tabla"
                    AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField HeaderText="Mes" DataField="Mes" />
                        <asp:BoundField HeaderText="Monto" DataField="Monto" DataFormatString="{0:N2}" />
                        <asp:BoundField HeaderText="Interés Bruto" DataField="Bruto" DataFormatString="{0:N2}" />
                        <asp:BoundField HeaderText="Impuesto" DataField="Impuesto" DataFormatString="{0:N2}" />
                        <asp:BoundField HeaderText="Interés Neto" DataField="Neto" DataFormatString="{0:N2}" />
                    </Columns>
                </asp:GridView>

                <div class="acciones">
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cotización" CssClass="btn-primary" CausesValidation="false" />
                </div>

                <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje" />

            </div>

        </div>

    </form>

</body>
</html>