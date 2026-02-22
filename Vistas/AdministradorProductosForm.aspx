<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdministradorProductosForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.AdministradorProductos" %>

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
                    </div>

                    <div>
                        <label>Plazo</label>
                        <asp:DropDownList ID="ddlPlazoAdmin" runat="server" CssClass="input">
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
                        <label>Tasa Anual (%)</label>
                        <asp:TextBox ID="txtTasa" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                </div>

                <!-- BOTONES -->
                <div class="botones">
                    <asp:Button ID="btnAgregar" runat="server" Text="Agregar / Guardar" CssClass="btn-primary" />
                    <asp:Button ID="btnEditar" runat="server" Text="Editar" CssClass="btn-sec" />
                    <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn-danger" />
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
                                <asp:Button ID="btnSeleccionar" runat="server" Text="Seleccionar" CssClass="btn-mini" />
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