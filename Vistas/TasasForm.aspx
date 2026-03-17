<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TasasForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.Tasas" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestión de Tasas</title>
    <link href="../Estilos/TasasStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">

        <div class="topbar">
            <div class="logo">Gestión de Tasas</div>
            <a class="volver" href="MenuPrincipalForm.aspx">← Menú Principal</a>
        </div>

        <div class="contenedor">
            <div class="card">

                <h2>Mantenimiento de Tasas</h2>

                <div class="grid">
                    <div>
                        <label>Producto</label>
                        <asp:DropDownList ID="ddlProductoTasa" runat="server" CssClass="input">
                            <asp:ListItem Text="Seleccione..." Value="" />
                            <asp:ListItem Text="Colón Crece (CC)" Value="CC" />
                            <asp:ListItem Text="Colón Futuro Plus (CF)" Value="CF" />
                            <asp:ListItem Text="Dólar Seguro (DS)" Value="DS" />
                            <asp:ListItem Text="Dólar Visión (DV)" Value="DV" />
                        </asp:DropDownList>
                    </div>

                    <div>
                        <label>Moneda</label>
                        <asp:DropDownList ID="ddlMonedaTasa" runat="server" CssClass="input">
                            <asp:ListItem Text="Colones" Value="CRC" />
                            <asp:ListItem Text="Dólares" Value="USD" />
                        </asp:DropDownList>
                    </div>

                    <div>
                        <label>Plazo</label>
                        <asp:TextBox ID="txtPlazoTasa" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <div>
                        <label>Tasa Anual (%)</label>
                        <asp:TextBox ID="txtValorTasa" runat="server" CssClass="input"></asp:TextBox>
                    </div>
                </div>

                <div class="acciones">
                        <asp:Button ID="btnGuardarTasa" runat="server" Text="Guardar" CssClass="btn-primary" OnClick="btnGuardarTasa_Click" />
                        <asp:Button ID="btnEditarTasa" runat="server" Text="Editar" CssClass="btn-sec" OnClick="btnEditarTasa_Click" />
                        <asp:Button ID="btnEliminarTasa" runat="server" Text="Eliminar" CssClass="btn-danger" OnClick="btnEliminarTasa_Click" />
                    </div>

                    <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje"></asp:Label>

                <h3 class="seccion">Lista de Tasas</h3>

                <asp:GridView ID="gvTasas" runat="server" CssClass="tabla" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField HeaderText="Producto" DataField="Producto" />
                        <asp:BoundField HeaderText="Moneda" DataField="Moneda" />
                        <asp:BoundField HeaderText="Plazo" DataField="Plazo" />
                        <asp:BoundField HeaderText="Tasa Anual" DataField="Tasa" />
                    </Columns>
                </asp:GridView>

            </div>
        </div>

    </form>
</body>
</html>