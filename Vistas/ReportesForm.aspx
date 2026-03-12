<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportesForm.aspx.cs" Inherits="SistemaCotizacion.Vistas.Reportes" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reportes</title>
    <link href="../Estilos/ReportesStyles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">

        <div class="topbar">
            <div class="logo">Reportes del Sistema</div>
            <a class="volver" href="MenuPrincipalForm.aspx">← Menú Principal</a>
        </div>

        <div class="contenedor">
            <div class="card">

                <h2>Generación de Reportes</h2>

                <div class="grid">
                    <div>
                        <label>Tipo de Reporte</label>
                        <asp:DropDownList ID="ddlTipoReporte" runat="server" CssClass="input">
                            <asp:ListItem Text="Seleccione..." Value="" />
                            <asp:ListItem Text="Cotizaciones por Usuario" Value="Usuario" />
                            <asp:ListItem Text="Cotizaciones por Producto" Value="Producto" />
                            <asp:ListItem Text="Cotizaciones por Fecha" Value="Fecha" />
                        </asp:DropDownList>
                    </div>

                    <div>
                        <label>Formato</label>
                        <asp:DropDownList ID="ddlFormatoReporte" runat="server" CssClass="input">
                            <asp:ListItem Text="PDF" Value="PDF" />
                            <asp:ListItem Text="Excel" Value="Excel" />
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="acciones">
                    <asp:Button ID="btnGenerarReporte" runat="server" Text="Generar Reporte" CssClass="btn-primary" />
                    <asp:Button ID="btnLimpiarReporte" runat="server" Text="Limpiar" CssClass="btn-sec" />
                </div>

                <h3 class="seccion">Vista previa del reporte</h3>

                <asp:GridView ID="gvReportes" runat="server" CssClass="tabla" AutoGenerateColumns="True"></asp:GridView>

            </div>
        </div>

    </form>
</body>
</html>