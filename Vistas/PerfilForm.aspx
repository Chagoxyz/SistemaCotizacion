<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PerfilForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.Perfil" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mi Perfil</title>

    <%-- Hoja de estilos para la vista de perfil --%>
    <link href="../Estilos/PerfilStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">

        <%-- Barra superior con título y navegación al menú principal --%>
        <div class="topbar">
            <div class="logo">Mantenimiento de Mi Perfil</div>
            <a class="volver" href="MenuPrincipalForm.aspx">← Menú Principal</a>
        </div>

        <%-- Contenedor principal de la página --%>
        <div class="contenedor">
            <div class="card">

                <h2>Información Personal</h2>

                <%-- Formulario de datos del usuario --%>
                <div class="grid">

                    <%-- Campo para el nombre completo del usuario --%>
                    <div>
                        <label>Nombre Completo</label>
                        <asp:TextBox ID="txtNombrePerfil" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <%-- Campo para el correo electrónico --%>
                    <div>
                        <label>Correo</label>
                        <asp:TextBox ID="txtCorreoPerfil" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <%-- Campo para el teléfono --%>
                    <div>
                        <label>Teléfono</label>
                        <asp:TextBox ID="txtTelefonoPerfil" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <%-- Campo para actualizar la contraseña --%>
                    <div>
                        <label>Contraseña</label>
                        <asp:TextBox ID="txtContrasenaPerfil" runat="server" CssClass="input" TextMode="Password"></asp:TextBox>
                    </div>
                </div>

                <%-- Botones de acción del formulario --%>
                <div class="acciones">

                    <%-- Guarda los cambios realizados en el perfil --%>
                    <asp:Button ID="btnGuardarPerfil" runat="server" Text="Guardar Cambios" CssClass="btn-primary" OnClick="btnGuardarPerfil_Click" />

                    <%-- Cancela la operación y limpia o recarga los datos --%>
                    <asp:Button ID="btnCancelarPerfil" runat="server" Text="Cancelar" CssClass="btn-sec" OnClick="btnCancelarPerfil_Click" CausesValidation="false" />
                </div>

                <%-- Etiqueta para mostrar mensajes de éxito o error --%>
                <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje"></asp:Label>

            </div>
        </div>

    </form>
</body>
</html>