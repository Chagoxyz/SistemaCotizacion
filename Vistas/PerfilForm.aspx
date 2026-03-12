<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PerfilForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.Perfil" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mi Perfil</title>
    <link href="../Estilos/PerfilStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">

        <div class="topbar">
            <div class="logo">Mantenimiento de Mi Perfil</div>
            <a class="volver" href="MenuPrincipalForm.aspx">← Menú Principal</a>
        </div>

        <div class="contenedor">
            <div class="card">

                <h2>Información Personal</h2>

                <div class="grid">
                    <div>
                        <label>Nombre Completo</label>
                        <asp:TextBox ID="txtNombrePerfil" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <div>
                        <label>Correo</label>
                        <asp:TextBox ID="txtCorreoPerfil" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <div>
                        <label>Teléfono</label>
                        <asp:TextBox ID="txtTelefonoPerfil" runat="server" CssClass="input"></asp:TextBox>
                    </div>

                    <div>
                        <label>Contraseña</label>
                        <asp:TextBox ID="txtContrasenaPerfil" runat="server" CssClass="input" TextMode="Password"></asp:TextBox>
                    </div>
                </div>

                <div class="acciones">
                    <asp:Button ID="btnGuardarPerfil" runat="server" Text="Guardar Cambios" CssClass="btn-primary" />
                    <asp:Button ID="btnCancelarPerfil" runat="server" Text="Cancelar" CssClass="btn-sec" />
                </div>

            </div>
        </div>

    </form>
</body>
</html>