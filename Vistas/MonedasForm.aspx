<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MonedasForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.Monedas" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestión de Monedas</title>
    <link href="../Estilos/MonedasStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">

        <div class="topbar">
            <div class="logo">Gestión de Monedas</div>
            <a class="volver" href="MenuPrincipalForm.aspx">← Menú Principal</a>
        </div>

        <div class="contenedor">
            <div class="card">

                <h2>Mantenimiento de Monedas</h2>

                <div class="grid">
                    <div>
                        <label>Código de Moneda</label>
                        <asp:TextBox ID="txtCodigoMoneda" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <div>
                        <label>Nombre de Moneda</label>
                        <asp:TextBox ID="txtNombreMoneda" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <div>
                        <label>Símbolo</label>
                        <asp:TextBox ID="txtSimboloMoneda" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <div>
                        <label>Estado</label>
                        <asp:DropDownList ID="ddlEstadoMoneda" runat="server" CssClass="input">
                            <asp:ListItem Text="Activo" Value="Activo" />
                            <asp:ListItem Text="Inactivo" Value="Inactivo" />
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="acciones">
                        <asp:Button ID="btnGuardarMoneda" runat="server" Text="Guardar" CssClass="btn-primary" OnClick="btnGuardarMoneda_Click" />
                        <asp:Button ID="btnEditarMoneda" runat="server" Text="Editar" CssClass="btn-sec" OnClick="btnEditarMoneda_Click" />
                        <asp:Button ID="btnEliminarMoneda" runat="server" Text="Eliminar" CssClass="btn-danger" OnClick="btnEliminarMoneda_Click" />
                    </div>

                    <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje"></asp:Label>

                <h3 class="seccion">Lista de Monedas</h3>

                <asp:GridView ID="gvMonedas" runat="server" CssClass="tabla" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField HeaderText="Código" DataField="Codigo" />
                        <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                        <asp:BoundField HeaderText="Símbolo" DataField="Simbolo" />
                        <asp:BoundField HeaderText="Estado" DataField="Estado" />
                    </Columns>
                </asp:GridView>

            </div>
        </div>

    </form>
</body>
</html>