<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.Login" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - Sistema APF</title>
    <link href="../Estilos/LoginStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>

    <form id="form1" runat="server">

        <div class="contenedor">

            <div class="card-login">

                <h2 class="titulo">Sistema de Cotización APF</h2>

                <asp:ValidationSummary
                    ID="vsLogin"
                    runat="server"
                    CssClass="mensaje"
                    ForeColor="Red"
                    HeaderText="Por favor complete los siguientes campos:"
                    ValidationGroup="vgLogin" />

                <label class="label">Usuario</label>
                <asp:TextBox ID="txtUsuario" runat="server" CssClass="input"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="rfvUsuario"
                    runat="server"
                    ControlToValidate="txtUsuario"
                    ErrorMessage="El usuario es obligatorio."
                    ForeColor="Red"
                    Display="Dynamic"
                    ValidationGroup="vgLogin" />

                <label class="label">Contraseña</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="rfvPassword"
                    runat="server"
                    ControlToValidate="txtPassword"
                    ErrorMessage="La contraseña es obligatoria."
                    ForeColor="Red"
                    Display="Dynamic"
                    ValidationGroup="vgLogin" />

                <asp:Button
                    ID="btnLogin"
                    runat="server"
                    Text="Ingresar"
                    CssClass="btn-login"
                    ValidationGroup="vgLogin" />

                <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje"></asp:Label>

            </div>

        </div>

    </form>

</body>
</html>