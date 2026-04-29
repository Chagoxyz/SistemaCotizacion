<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.Login" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - Sistema APF</title>

    <%-- Hoja de estilos para el diseño del login --%>
    <link href="../Estilos/LoginStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>

    <form id="form1" runat="server">

        <%-- Contenedor principal centrado en la pantalla --%>
        <div class="contenedor">

            <%-- Tarjeta donde se muestra el formulario de inicio de sesión --%>
            <div class="card-login">

                <%-- Título del sistema --%>
                <h2 class="titulo">Sistema de Cotización APF</h2>

                <%-- Resumen de validaciones: muestra errores si faltan campos obligatorios --%>
                <asp:ValidationSummary
                    ID="vsLogin"
                    runat="server"
                    CssClass="mensaje"
                    ForeColor="Red"
                    HeaderText="Por favor complete los siguientes campos:"
                    ValidationGroup="vgLogin" />

                <%-- Campo de usuario --%>
                <label class="label">Usuario</label>
                <asp:TextBox ID="txtUsuario" runat="server" CssClass="input"></asp:TextBox>

                <%-- Validación: el usuario no puede estar vacío --%>
                <asp:RequiredFieldValidator
                    ID="rfvUsuario"
                    runat="server"
                    ControlToValidate="txtUsuario"
                    ErrorMessage="El usuario es obligatorio."
                    ForeColor="Red"
                    Display="Dynamic"
                    ValidationGroup="vgLogin" />

                <%-- Campo de contraseña --%>
                <label class="label">Contraseña</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input"></asp:TextBox>

                <%-- Validación: la contraseña no puede estar vacía --%>
                <asp:RequiredFieldValidator
                    ID="rfvPassword"
                    runat="server"
                    ControlToValidate="txtPassword"
                    ErrorMessage="La contraseña es obligatoria."
                    ForeColor="Red"
                    Display="Dynamic"
                    ValidationGroup="vgLogin" />

                <%-- Botón que ejecuta el login y valida los campos --%>
                <asp:Button
                    ID="btnLogin"
                    runat="server"
                    Text="Ingresar"
                    CssClass="btn-login"
                    ValidationGroup="vgLogin"
                    OnClick="btnLogin_Click" />

                <%-- Mensaje para mostrar errores de login o confirmaciones --%>
                <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje"></asp:Label>

            </div>

        </div>

    </form>

</body>
</html>