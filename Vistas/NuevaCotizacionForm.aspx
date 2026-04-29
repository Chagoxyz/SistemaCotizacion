<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NuevaCotizacionForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.NuevaCotizacion" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Nueva Cotización</title>

    <%-- Estilos de la pantalla de nueva cotización --%>
    <link href="../Estilos/NuevaCotizacionStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>

    <form id="form1" runat="server">

        <%-- Barra superior con navegación --%>
        <div class="topbar">
            <div class="logo">Sistema APF</div>
            <div>
                <a class="volver" href="MenuPrincipalForm.aspx">← Volver al menú</a>
            </div>
        </div>

        <%-- CONTENEDOR PRINCIPAL: FORMULARIO --%>
        <div class="contenedor">

            <div class="card">

                <h2>Nueva Cotización</h2>

                <%-- Resumen de validaciones del formulario --%>
                <asp:ValidationSummary ID="vsResumen" runat="server"
                    CssClass="mensaje"
                    ForeColor="Red"
                    HeaderText="Por favor corrija los siguientes errores:"
                    ValidationGroup="vgCotizacion" />

                <%-- ================= DATOS DEL CLIENTE ================= --%>
                <h3 class="seccion">Datos del Cliente</h3>

                <div class="grid">

                    <%-- Cédula del cliente --%>
                    <div>
                        <label>Cédula</label>
                        <asp:TextBox ID="txtCedula" runat="server" CssClass="input"></asp:TextBox>

                        <%-- Validación obligatoria --%>
                        <asp:RequiredFieldValidator ID="rfvCedula" runat="server"
                            ControlToValidate="txtCedula"
                            ErrorMessage="La cédula es obligatoria."
                            ForeColor="Red"
                            Display="Dynamic"
                            ValidationGroup="vgCotizacion" />
                    </div>

                    <%-- Nombre del cliente --%>
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

                    <%-- Teléfono --%>
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

                    <%-- Correo electrónico --%>
                    <div>
                        <label>Correo</label>
                        <asp:TextBox ID="txtCorreo" runat="server" CssClass="input"></asp:TextBox>

                        <%-- Validación obligatoria --%>
                        <asp:RequiredFieldValidator ID="rfvCorreo" runat="server"
                            ControlToValidate="txtCorreo"
                            ErrorMessage="El correo es obligatorio."
                            ForeColor="Red"
                            Display="Dynamic"
                            ValidationGroup="vgCotizacion" />

                        <%-- Validación de formato de correo --%>
                        <asp:RegularExpressionValidator ID="revCorreo" runat="server"
                            ControlToValidate="txtCorreo"
                            ValidationExpression="\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+"
                            ErrorMessage="Ingrese un correo válido."
                            ForeColor="Red"
                            Display="Dynamic"
                            ValidationGroup="vgCotizacion" />
                    </div>

                </div>

                <%-- ================= DATOS DE LA INVERSIÓN ================= --%>
                <h3 class="seccion">Datos de la Inversión</h3>

                <div class="grid">

                    <%-- Selección de producto --%>
                    <div>
                        <label>Producto</label>
                        <asp:DropDownList ID="ddlProducto" runat="server" CssClass="input"
                            AutoPostBack="true"
                            OnSelectedIndexChanged="ddlProducto_SelectedIndexChanged">
                            <asp:ListItem Text="Seleccione..." Value="" />
                        </asp:DropDownList>

                        <asp:RequiredFieldValidator ID="rfvProducto" runat="server"
                            ControlToValidate="ddlProducto"
                            InitialValue=""
                            ErrorMessage="Debe seleccionar un producto."
                            ForeColor="Red"
                            Display="Dynamic"
                            ValidationGroup="vgCotizacion" />
                    </div>

                    <%-- Moneda (se llena automáticamente según producto) --%>
                    <div>
                        <label>Moneda</label>
                        <asp:TextBox ID="txtMoneda" runat="server" CssClass="input" ReadOnly="true"></asp:TextBox>
                    </div>

                    <%-- Plazo de inversión --%>
                    <div>
                        <label>Plazo</label>
                        <asp:DropDownList ID="ddlPlazo" runat="server" CssClass="input">
                            <asp:ListItem Text="Seleccione..." Value="" />
                        </asp:DropDownList>

                        <asp:RequiredFieldValidator ID="rfvPlazo" runat="server"
                            ControlToValidate="ddlPlazo"
                            InitialValue=""
                            ErrorMessage="Debe seleccionar un plazo."
                            ForeColor="Red"
                            Display="Dynamic"
                            ValidationGroup="vgCotizacion" />
                    </div>

                    <%-- Monto a invertir --%>
                    <div>
                        <label>Monto</label>
                        <asp:TextBox ID="txtMonto" runat="server" CssClass="input"></asp:TextBox>

                        <asp:RequiredFieldValidator ID="rfvMonto" runat="server"
                            ControlToValidate="txtMonto"
                            ErrorMessage="El monto es obligatorio."
                            ForeColor="Red"
                            Display="Dynamic"
                            ValidationGroup="vgCotizacion" />

                        <%-- Validación de formato numérico --%>
                        <asp:RegularExpressionValidator ID="revMonto" runat="server"
                            ControlToValidate="txtMonto"
                            ValidationExpression="^\d+(\.\d{1,2})?$"
                            ErrorMessage="Ingrese un monto válido."
                            ForeColor="Red"
                            Display="Dynamic"
                            ValidationGroup="vgCotizacion" />
                    </div>

                </div>

                <%-- BOTONES PRINCIPALES --%>
                <div class="botones">

                    <%-- Calcula la cotización --%>
                    <asp:Button ID="btnCalcular" runat="server" Text="Calcular"
                        CssClass="btn-primary"
                        ValidationGroup="vgCotizacion"
                        OnClick="btnCalcular_Click" />

                    <%-- Limpia el formulario --%>
                    <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar"
                        CssClass="btn-sec"
                        CausesValidation="false"
                        OnClick="btnLimpiar_Click" />

                    <%-- Guarda la cotización en la base de datos --%>
                    <asp:Button ID="Button1" runat="server" Text="Guardar Cotización" 
                        CssClass="btn-primary" 
                        CausesValidation="false" 
                        OnClick="btnGuardar_Click" />
                </div>

            </div>

        </div>

        <%-- ================= RESULTADOS DE LA COTIZACIÓN ================= --%>
        <div class="contenedor">

            <div class="card">

                <h2>Resumen de Cotización</h2>

                <%-- Datos generales de la cotización --%>
                <div class="resumen">
                    <div><strong>Cliente:</strong> <asp:Label ID="lblCliente" runat="server" /></div>
                    <div><strong>Producto:</strong> <asp:Label ID="lblProducto" runat="server" /></div>
                    <div><strong>Monto:</strong> <asp:Label ID="lblMonto" runat="server" /></div>
                    <div><strong>Plazo:</strong> <asp:Label ID="lblPlazo" runat="server" /></div>
                    <div><strong>Tasa:</strong> <asp:Label ID="lblTasa" runat="server" /></div>
                    <div><strong>Impuesto:</strong> 13%</div>
                </div>

                <%-- Totales calculados --%>
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

                <%-- Detalle mensual de la inversión --%>
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

                <%-- Botón final para guardar la cotización desde el resumen --%>
                <div class="acciones">
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cotización" CssClass="btn-primary" CausesValidation="false" OnClick="btnGuardar_Click" />
                </div>

                <%-- Mensajes al usuario --%>
                <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje" />

            </div>

        </div>

    </form>

</body>
</html>