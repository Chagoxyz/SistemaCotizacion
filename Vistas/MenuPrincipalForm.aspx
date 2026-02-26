<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MenuPrincipalForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.MenuPrincipal" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Menú Principal - Sistema APF</title>
    <link href="../Estilos/MenuPrincipalStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>

    <form id="form1" runat="server">

        <!-- Barra superior -->
        <div class="topbar">
            <div class="logo">Sistema de Cotización APF</div>

            <div class="topbar-right">
                <span class="user">Usuario: <strong>Invitado</strong></span>
                <asp:Button ID="btnCerrarSesion" runat="server" Text="Cerrar sesión" CssClass="btn-logout" />
            </div>
        </div>

        <!-- Contenido principal -->
        <div class="layout">

            <!-- Menú lateral -->
            <div class="sidebar">
                <h3 class="sidebar-title">Menú</h3>

                <a class="nav-item" href="NuevaCotizacion.aspx">Nueva Cotización</a>
                <a class="nav-item" href="Historial.aspx">Historial</a>
                <a class="nav-item" href="Reportes.aspx">Reportes</a>

                <div class="separator"></div>

                <!-- Administrador puede ocultarla luego por rol -->
                <h3 class="sidebar-title">Administrador</h3>
                <a class="nav-item" href="AdminProductos.aspx">Productos / Tasas</a>
                <a class="nav-item" href="AdminUsuarios.aspx">Usuarios</a>
                <a class="nav-item" href="AdminCotizaciones.aspx">Todas las Cotizaciones</a>
            </div>

            <!-- Área central -->
            <div class="content">

                <div class="card">
                    <h2 class="titulo">Bienvenido al sistema</h2>
                    <p class="texto">
                        Desde este menú puedes crear nuevas cotizaciones de ahorro a plazo fijo (APF),
                        consultar tu historial y generar reportes en PDF o Excel.
                    </p>
                </div>

                <div class="grid-cards">

                    <a class="action-card" href="NuevaCotizacion.aspx">
                        <h3>Nueva Cotización</h3>
                        <p>Crear una cotización seleccionando producto, monto y plazo.</p>
                    </a>

                    <a class="action-card" href="Historial.aspx">
                        <h3>Historial</h3>
                        <p>Ver y administrar cotizaciones previas.</p>
                    </a>

                    <a class="action-card" href="Reportes.aspx">
                        <h3>Reportes</h3>
                        <p>Exportar cotizaciones a PDF o Excel.</p>
                    </a>

                </div>

            </div>

        </div>

    </form>

</body>
</html>