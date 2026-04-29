<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PlazosForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.Plazos" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestión de Plazos</title>

    <%-- Hoja de estilos para la pantalla de plazos --%>
    <link href="../Estilos/PlazosStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">

        <%-- Barra superior con navegación --%>
        <div class="topbar">
            <div class="logo">Gestión de Plazos</div>
            <a class="volver" href="MenuPrincipalForm.aspx">← Menú Principal</a>
        </div>

        <%-- Contenedor principal --%>
        <div class="contenedor">
            <div class="card">

                <h2>Mantenimiento de Plazos</h2>

                <%-- Formulario para crear/editar plazos --%>
                <div class="grid">

                    <%-- Descripción del plazo (ej: 12 meses, 15 días) --%>
                    <div>
                        <label>Descripción</label>
                        <asp:TextBox ID="txtDescripcionPlazo" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <%-- Cantidad numérica del plazo --%>
                    <div>
                        <label>Cantidad</label>
                        <asp:TextBox ID="txtCantidadPlazo" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <%-- Tipo de plazo: días o meses --%>
                    <div>
                        <label>Tipo</label>
                        <asp:DropDownList ID="ddlTipoPlazo" runat="server" CssClass="input">
                            <asp:ListItem Text="Días" Value="Dias" />
                            <asp:ListItem Text="Meses" Value="Meses" />
                        </asp:DropDownList>
                    </div>

                    <%-- Estado del plazo (activo/inactivo) --%>
                    <div>
                        <label>Estado</label>
                        <asp:DropDownList ID="ddlEstadoPlazo" runat="server" CssClass="input">
                            <asp:ListItem Text="Activo" Value="Activo" />
                            <asp:ListItem Text="Inactivo" Value="Inactivo" />
                        </asp:DropDownList>
                    </div>
                </div>

                <%-- Botones de acción --%>
                <div class="acciones">

                    <%-- Guarda un nuevo plazo --%>
                    <asp:Button ID="btnGuardarPlazo" runat="server" Text="Guardar" CssClass="btn-primary" OnClick="btnGuardarPlazo_Click" />

                    <%-- Edita un plazo existente --%>
                    <asp:Button ID="btnEditarPlazo" runat="server" Text="Editar" CssClass="btn-sec" OnClick="btnEditarPlazo_Click" />

                    <%-- Elimina un plazo --%>
                    <asp:Button ID="btnEliminarPlazo" runat="server" Text="Eliminar" CssClass="btn-danger" OnClick="btnEliminarPlazo_Click" />
                </div>

                <%-- Mensajes de sistema (éxito o error) --%>
                <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje"></asp:Label>

                <%-- Listado de plazos registrados --%>
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