using iTextSharp.text;
using iTextSharp.text.pdf;
using SistemaCotizacion.Utilidades;
using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaCotizacion.Vistas
{
    public partial class Reportes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IdUsuario"] == null)
            {
                Response.Redirect("LoginForm.aspx");
                return;
            }

            if (!IsPostBack)
            {
                CargarClientes();
                gvReportes.DataSource = null;
                gvReportes.DataBind();
                lblMensaje.Text = string.Empty;
                lblCotizacionSeleccionada.Text = "Ninguna";
                ViewState["NumeroCotizacionSeleccionada"] = null;
            }
        }

        private void CargarClientes()
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                string sql = @"SELECT DISTINCT c.IdCliente, c.NombreCompleto
                               FROM Cliente c
                               INNER JOIN Cotizacion co ON c.IdCliente = co.IdCliente
                               ORDER BY c.NombreCompleto";

                SqlCommand cmd = new SqlCommand(sql, cn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlClienteReporte.DataSource = dt;
                ddlClienteReporte.DataTextField = "NombreCompleto";
                ddlClienteReporte.DataValueField = "IdCliente";
                ddlClienteReporte.DataBind();
                ddlClienteReporte.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Seleccione...", ""));
            }
        }

        private DataTable ObtenerReportePorCliente(int idCliente, int? numeroCotizacion = null)
        {
            using (SqlConnection cn = ConexionDB.ObtenerConexion())
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_Reporte_CotizacionesPorCliente", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdCliente", idCliente);

                if (numeroCotizacion.HasValue)
                    cmd.Parameters.AddWithValue("@NumeroCotizacion", numeroCotizacion.Value);
                else
                    cmd.Parameters.AddWithValue("@NumeroCotizacion", DBNull.Value);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        protected void btnBuscarReporte_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(ddlClienteReporte.SelectedValue))
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Debe seleccionar un cliente.";
                    return;
                }

                int idCliente = Convert.ToInt32(ddlClienteReporte.SelectedValue);
                DataTable dt = ObtenerReportePorCliente(idCliente);

                gvReportes.DataSource = dt;
                gvReportes.DataBind();

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Vista previa generada correctamente.";
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al generar reporte: " + ex.Message;
            }
        }

        protected void gvReportes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "SeleccionarCotizacion")
            {
                ViewState["NumeroCotizacionSeleccionada"] = Convert.ToInt32(e.CommandArgument);
                lblCotizacionSeleccionada.Text = "Cotización #" + e.CommandArgument.ToString();
                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Cotización seleccionada correctamente.";
            }
        }

        protected void btnExportarSeleccionada_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(ddlClienteReporte.SelectedValue))
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Debe seleccionar un cliente.";
                    return;
                }

                if (ViewState["NumeroCotizacionSeleccionada"] == null)
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Debe seleccionar una cotización en la tabla.";
                    return;
                }

                int idCliente = Convert.ToInt32(ddlClienteReporte.SelectedValue);
                int numeroCotizacion = Convert.ToInt32(ViewState["NumeroCotizacionSeleccionada"]);
                DataTable dt = ObtenerReportePorCliente(idCliente, numeroCotizacion);

                Exportar(dt, "Cotizacion_" + numeroCotizacion);
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al exportar la cotización seleccionada: " + ex.Message;
            }
        }

        protected void btnExportarTodas_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(ddlClienteReporte.SelectedValue))
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Debe seleccionar un cliente.";
                    return;
                }

                int idCliente = Convert.ToInt32(ddlClienteReporte.SelectedValue);
                string nombreCliente = ddlClienteReporte.SelectedItem.Text.Replace(" ", "_");
                DataTable dt = ObtenerReportePorCliente(idCliente);

                Exportar(dt, "Cotizaciones_" + nombreCliente);
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al exportar las cotizaciones: " + ex.Message;
            }
        }

        private void Exportar(DataTable dt, string nombreArchivo)
        {
            if (dt == null || dt.Rows.Count == 0)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "No hay datos para exportar.";
                return;
            }

            if (ddlFormatoReporte.SelectedValue == "Excel")
            {
                ExportarExcel(dt, nombreArchivo);
            }
            else
            {
                ExportarPdf(dt, nombreArchivo);
            }
        }

        private void ExportarPdf(DataTable dt, string nombreArchivo)
        {
            using (MemoryStream ms = new MemoryStream())
            {
                using (Document doc = new Document(PageSize.A4.Rotate(), 20f, 20f, 20f, 20f))
                {
                    PdfWriter.GetInstance(doc, ms);
                    doc.Open();

                    var tituloFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 16);
                    var textoFont = FontFactory.GetFont(FontFactory.HELVETICA, 10);
                    var encabezadoFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 10, BaseColor.WHITE);

                    Paragraph titulo = new Paragraph("Reporte de Cotizaciones por Cliente", tituloFont);
                    titulo.Alignment = Element.ALIGN_CENTER;
                    titulo.SpacingAfter = 15f;
                    doc.Add(titulo);

                    Paragraph cliente = new Paragraph("Cliente: " + ddlClienteReporte.SelectedItem.Text, textoFont);
                    cliente.SpacingAfter = 10f;
                    doc.Add(cliente);

                    PdfPTable tabla = new PdfPTable(dt.Columns.Count);
                    tabla.WidthPercentage = 100;

                    foreach (DataColumn col in dt.Columns)
                    {
                        PdfPCell celda = new PdfPCell(new Phrase(col.ColumnName, encabezadoFont));
                        celda.BackgroundColor = new BaseColor(22, 147, 165);
                        celda.HorizontalAlignment = Element.ALIGN_CENTER;
                        celda.Padding = 6f;
                        tabla.AddCell(celda);
                    }

                    foreach (DataRow row in dt.Rows)
                    {
                        foreach (object item in row.ItemArray)
                        {
                            PdfPCell celda = new PdfPCell(new Phrase(item.ToString(), textoFont));
                            celda.Padding = 5f;
                            tabla.AddCell(celda);
                        }
                    }

                    doc.Add(tabla);
                    doc.Close();
                }

                byte[] bytes = ms.ToArray();

                Response.Clear();
                Response.ClearContent();
                Response.ClearHeaders();
                Response.Buffer = true;
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", "attachment; filename=" + nombreArchivo + ".pdf");
                Response.BinaryWrite(bytes);
                Response.Flush();
                Response.SuppressContent = true;
                HttpContext.Current.ApplicationInstance.CompleteRequest();
            }
        }

        private void ExportarExcel(DataTable dt, string nombreArchivo)
        {
            GridView gvExport = new GridView();
            gvExport.DataSource = dt;
            gvExport.DataBind();

            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    gvExport.RenderControl(hw);
                    string contenido = sw.ToString();

                    Response.Clear();
                    Response.ClearContent();
                    Response.ClearHeaders();
                    Response.Buffer = true;
                    Response.ContentType = "application/vnd.ms-excel";
                    Response.AddHeader("Content-Disposition", "attachment; filename=" + nombreArchivo + ".xls");
                    Response.Write(contenido);
                    Response.Flush();
                    Response.SuppressContent = true;
                    HttpContext.Current.ApplicationInstance.CompleteRequest();
                }
            }
        }

        protected void btnLimpiarReporte_Click(object sender, EventArgs e)
        {
            ddlClienteReporte.SelectedIndex = 0;
            ddlFormatoReporte.SelectedIndex = 0;
            lblMensaje.Text = "";
            lblCotizacionSeleccionada.Text = "Ninguna";
            ViewState["NumeroCotizacionSeleccionada"] = null;
            gvReportes.DataSource = null;
            gvReportes.DataBind();
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
        }
    }
}