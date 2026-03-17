<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PlazosForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.Plazos" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestión de Plazos</title>
    <link href="../Estilos/PlazosStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">

        <div class="topbar">
            <div class="logo">Gestión de Plazos</div>
            <a class="volver" href="MenuPrincipalForm.aspx">← Menú Principal</a>
        </div>

        <div class="contenedor">
            <div class="card">

                <h2>Mantenimiento de Plazos</h2>

                <div class="grid">
                    <div>
                        <label>Descripción</label>
                        <asp:TextBox ID="txtDescripcionPlazo" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <div>
                        <label>Cantidad</label>
                        <asp:TextBox ID="txtCantidadPlazo" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <div>
                        <label>Tipo</label>
                        <asp:DropDownList ID="ddlTipoPlazo" runat="server" CssClass="input">
                            <asp:ListItem Text="Días" Value="Dias" />
                            <asp:ListItem Text="Meses" Value="Meses" />
                        </asp:DropDownList>
                    </div>

                    <div>
                        <label>Estado</label>
                        <asp:DropDownList ID="ddlEstadoPlazo" runat="server" CssClass="input">
                            <asp:ListItem Text="Activo" Value="Activo" />
                            <asp:ListItem Text="Inactivo" Value="Inactivo" />
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="acciones">
                        <asp:Button ID="btnGuardarPlazo" runat="server" Text="Guardar" CssClass="btn-primary" OnClick="btnGuardarPlazo_Click" />
                        <asp:Button ID="btnEditarPlazo" runat="server" Text="Editar" CssClass="btn-sec" OnClick="btnEditarPlazo_Click" />
                        <asp:Button ID="btnEliminarPlazo" runat="server" Text="Eliminar" CssClass="btn-danger" OnClick="btnEliminarPlazo_Click" />
                    </div>

                    <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje"></asp:Label>

                <h3 class="seccion">Lista de Plazos</h3>

                <asp:GridView ID="gvPlazos" runat="server" CssClass="tabla" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField HeaderText="Descripción" DataField="Descripcion" />
                        <asp:BoundField HeaderText="Cantidad" DataField="Cantidad" />
                        <asp:BoundField HeaderText="Tipo" DataField="Tipo" />
                        <asp:BoundField HeaderText="Estado" DataField="Estado" />
                    </Columns>
                </asp:GridView>

            </div>
        </div>

    </form>
</body>
</html>