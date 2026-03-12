<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MenuPrincipalForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.MenuPrincipal" UnobtrusiveValidationMode="None" %>

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
            <asp:Button ID="btnCerrarSesion" runat="server" Text="Cerrar sesión" CssClass="btn-logout" CausesValidation="false" />
        </div>
    </div>

    <!-- Contenido principal -->
    <div class="layout">

        <!-- Menú lateral -->
        <div class="sidebar">
            <h3 class="sidebar-title">Cotizaciones</h3>

            <a class="nav-item" href="NuevaCotizacionForm.aspx">Nueva Cotización</a>
            <a class="nav-item" href="HistorialCotizaciones.aspx">Historial de Cotizaciones</a>
            <a class="nav-item" href="Reportes.aspx">Reportes</a>
            <a class="nav-item" href="Perfil.aspx">Mi Perfil</a>

            <div class="separator"></div>

            <h3 class="sidebar-title">Mantenimientos</h3>

            <a class="nav-item" href="Productos.aspx">Gestión de Productos</a>
            <a class="nav-item" href="Usuarios.aspx">Usuarios</a>
            <a class="nav-item" href="Monedas.aspx">Monedas</a>
            <a class="nav-item" href="Plazos.aspx">Plazos</a>
            <a class="nav-item" href="Tasas.aspx">Tasas</a>
            <a class="nav-item" href="AdministradorProductosForm.aspx">Productos / Tasas / Plazos</a>
        </div>

        <!-- Área central -->
        <div class="content">

            <div class="card">
                <h2 class="titulo">Bienvenido al sistema</h2>
                <p class="texto">
                    Desde este menú puedes registrar nuevas cotizaciones de ahorro a plazo fijo (APF),
                    consultar el historial, administrar parámetros del sistema y generar reportes.
                </p>
            </div>

            <div class="grid-cards">

                <a class="action-card" href="NuevaCotizacionForm.aspx">
                    <h3>Nueva Cotización</h3>
                    <p>Crear una cotización ingresando producto, monto y plazo.</p>
                </a>

                <a class="action-card" href="HistorialCotizaciones.aspx">
                    <h3>Historial</h3>
                    <p>Consultar las cotizaciones registradas en el sistema.</p>
                </a>

                <a class="action-card" href="Reportes.aspx">
                    <h3>Reportes</h3>
                    <p>Visualizar y preparar reportes en PDF o Excel.</p>
                </a>

                <a class="action-card" href="Productos.aspx">
                    <h3>Productos</h3>
                    <p>Gestionar los productos de inversión disponibles.</p>
                </a>

                <a class="action-card" href="Usuarios.aspx">
                    <h3>Usuarios</h3>
                    <p>Administrar usuarios y roles del sistema.</p>
                </a>

                <a class="action-card" href="Perfil.aspx">
                    <h3>Mi Perfil</h3>
                    <p>Actualizar la información personal del usuario.</p>
                </a>

            </div>

        </div>

    </div>

</form>

</body>
</html>