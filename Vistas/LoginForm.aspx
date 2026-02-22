<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.Login" %>

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

            <label class="label">Usuario</label>
            <asp:TextBox ID="txtUsuario" runat="server" CssClass="input"></asp:TextBox>

            <label class="label">Contraseña</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input"></asp:TextBox>

            <asp:Button ID="btnLogin" runat="server" Text="Ingresar" CssClass="btn-login" />

            <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje"></asp:Label>

        </div>

    </div>

</form>

</body>
</html>