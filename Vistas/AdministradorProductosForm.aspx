<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministradorProductosForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.AdministradorProductos" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Administración de Productos</title>
    <link href="../Estilos/AdministradorProductosStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>

    <form id="form1" runat="server">

        <!-- Barra superior -->
        <div class="topbar">
            <div class="logo">Sistema APF - Administrador</div>
            <div>
                <a class="volver" href="MenuPrincipal.aspx">← Volver al menú</a>
            </div>
        </div>

        <div class="contenedor">

            <div class="card">

                <h2>Administración de Productos / Tasas / Plazos</h2>

                <asp:ValidationSummary ID="vsResumen" runat="server"
                    CssClass="mensaje"
                    ForeColor="Red"
                    HeaderText="Por favor corrija los siguientes errores:" />

                <!-- FILTROS -->
                <div class="filtros">

                    <div>
                        <label>Producto</label>
                        <asp:DropDownList ID="ddlProductoAdmin" runat="server" CssClass="input">
                            <asp:ListItem Text="Seleccione..." Value="" />
                            <asp:ListItem Text="Colón Crece (CC)" Value="CC" />
                            <asp:ListItem Text="Colón Futuro Plus (CF)" Value="CF" />
                            <asp:ListItem Text="Dólar Seguro (DS)" Value="DS" />
                            <asp:ListItem Text="Dólar Visión (DV)" Value="DV" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator
                            ID="rfvProductoAdmin"
                            runat="server"
                            ControlToValidate="ddlProductoAdmin"
                            InitialValue=""
                            ErrorMessage="Debe seleccionar un producto."
                            ForeColor="Red"
                            Display="Dynamic" />
                    </div>

                    <div>
                        <label>Plazo</label>
                        <asp:DropDownList ID="ddlPlazoAdmin" runat="server" CssClass="input">
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
                        <asp:RequiredFieldValidator
                            ID="rfvPlazoAdmin"
                            runat="server"
                            ControlToValidate="ddlPlazoAdmin"
                            InitialValue=""
                            ErrorMessage="Debe seleccionar un plazo."
                            ForeColor="Red"
                            Display="Dynamic" />
                    </div>

                    <div>
                        <label>Tasa Anual (%)</label>
                        <asp:TextBox ID="txtTasa" runat="server" CssClass="input"></asp:TextBox>

                        <asp:RequiredFieldValidator
                            ID="rfvTasa"
                            runat="server"
                            ControlToValidate="txtTasa"
                            ErrorMessage="La tasa anual es obligatoria."
                            ForeColor="Red"
                            Display="Dynamic" />

                        <asp:RegularExpressionValidator
                            ID="revTasa"
                            runat="server"
                            ControlToValidate="txtTasa"
                            ValidationExpression="^\d+(\.\d{1,4})?$"
                            ErrorMessage="Ingrese una tasa válida. Ejemplo: 4.10"
                            ForeColor="Red"
                            Display="Dynamic" />
                    </div>

                </div>

                <!-- BOTONES -->
                <div class="botones">
                    <asp:Button ID="btnAgregar" runat="server" Text="Agregar / Guardar" CssClass="btn-primary" ValidationGroup="vgAdminProductos" />
                    <asp:Button ID="btnEditar" runat="server" Text="Editar" CssClass="btn-sec" ValidationGroup="vgAdminProductos" />
                    <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn-danger" CausesValidation="false" />
                </div>

                <!-- TABLA -->
                <h3 class="seccion">Tabla de Tasas Configuradas</h3>

                <asp:GridView ID="gvTasas" runat="server" CssClass="tabla"
                    AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField HeaderText="Producto" DataField="Producto" />
                        <asp:BoundField HeaderText="Plazo" DataField="Plazo" />
                        <asp:BoundField HeaderText="Tasa Anual" DataField="Tasa" />
                        <asp:TemplateField HeaderText="Acción">
                            <ItemTemplate>
                                <asp:Button ID="btnSeleccionar" runat="server" Text="Seleccionar" CssClass="btn-mini" CausesValidation="false" />
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