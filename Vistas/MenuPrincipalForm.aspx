<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MenuPrincipalForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.MenuPrincipal" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Menú Principal - Sistema APF</title>

    <%-- Hoja de estilos para el diseño del menú principal --%>
    <link href="../Estilos/MenuPrincipalStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>

<form id="form1" runat="server">

    <%-- Barra superior con el nombre del sistema y opciones del usuario --%>
    <div class="topbar">
        <div class="logo">Sistema de Cotización APF</div>

        <%-- Información del usuario logueado y botón de cerrar sesión --%>
        <div class="topbar-right">
            <span class="user">
                Usuario: 
                <strong><asp:Label ID="lblUsuarioActual" runat="server"></asp:Label></strong>
            </span>

            <%-- Botón para cerrar sesión --%>
            <asp:Button ID="btnCerrarSesion" runat="server" Text="Cerrar sesión"
                CssClass="btn-logout" CausesValidation="false" OnClick="btnCerrarSesion_Click" />
        </div>
    </div>

    <%-- Contenedor principal que divide el menú lateral y el contenido --%>
    <div class="layout">

        <%-- Sidebar (menú lateral de navegación) --%>
        <div class="sidebar">
            <h3 class="sidebar-title">Cotizaciones</h3>

            <%-- Opciones principales del usuario --%>
            <a class="nav-item" href="NuevaCotizacionForm.aspx">Nueva Cotización</a>
            <a class="nav-item" href="HistorialCotizacionesForm.aspx">Historial de Cotizaciones</a>
            <a class="nav-item" href="PerfilForm.aspx">Mi Perfil</a>

            <%-- Sección visible solo para administradores --%>
            <div id="menuAdmin" runat="server">
                <div class="separator"></div>

                <h3 class="sidebar-title">Mantenimientos</h3>

                <%-- Opciones de administración del sistema --%>
                <a class="nav-item" href="ProductosForm.aspx">Gestión de Productos</a>
                <a class="nav-item" href="UsuariosForm.aspx">Usuarios</a>
                <a class="nav-item" href="MonedasForm.aspx">Monedas</a>
                <a class="nav-item" href="PlazosForm.aspx">Plazos</a>
                <a class="nav-item" href="TasasForm.aspx">Tasas</a>
                <a class="nav-item" href="ReportesForm.aspx">Reportes</a>
            </div>
        </div>

        <%-- Contenido principal de la página --%>
        <div class="content">

            <%-- Tarjeta de bienvenida --%>
            <div class="card">
                <h2 class="titulo">Bienvenido al sistema</h2>
                <p class="texto">
                    Desde este menú puedes registrar nuevas cotizaciones de ahorro a plazo fijo (APF),
                    consultar tu historial y administrar tu información.
                </p>
            </div>

            <%-- Tarjetas de acceso rápido a funcionalidades principales --%>
            <div class="grid-cards">

                <%-- Acceso a nueva cotización --%>
                <a class="action-card" href="NuevaCotizacionForm.aspx">
                    <h3>Nueva Cotización</h3>
                    <p>Crear una cotización ingresando producto, monto y plazo.</p>
                </a>

                <%-- Acceso al historial --%>
                <a class="action-card" href="HistorialCotizacionesForm.aspx">
                    <h3>Historial</h3>
                    <p>Consultar las cotizaciones registradas en el sistema.</p>
                </a>

                <%-- Acceso al perfil del usuario --%>
                <a class="action-card" href="PerfilForm.aspx">
                    <h3>Mi Perfil</h3>
                    <p>Actualizar la información personal del usuario.</p>
                </a>

                <%-- Tarjetas visibles solo para administrador (controladas desde code-behind) --%>
                <a id="cardProductos" runat="server" class="action-card" href="ProductosForm.aspx">
                    <h3>Productos</h3>
                    <p>Gestionar los productos de inversión disponibles.</p>
                </a>

                <a id="cardUsuarios" runat="server" class="action-card" href="UsuariosForm.aspx">
                    <h3>Usuarios</h3>
                    <p>Administrar usuarios y roles del sistema.</p>
                </a>

                <a id="cardReportes" runat="server" class="action-card" href="ReportesForm.aspx">
                    <h3>Reportes</h3>
                    <p>Visualizar y preparar reportes del sistema.</p>
                </a>

            </div>

        </div>

    </div>

</form>

</body>
</html>