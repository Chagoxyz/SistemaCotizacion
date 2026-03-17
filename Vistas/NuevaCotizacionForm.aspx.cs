using System;
using System.Collections.Generic;
using System.Web.UI;
using SistemaCotizacion.Clases;

namespace SistemaCotizacion.Vistas
{
    public partial class NuevaCotizacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnCalcular_Click(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsValid)
                {
                    return;
                }

                decimal monto = Convert.ToDecimal(txtMonto.Text);
                string producto = ddlProducto.SelectedItem.Text;
                string plazoTexto = ddlPlazo.SelectedValue;

                int meses = ObtenerMeses(plazoTexto);
                decimal tasa = ObtenerTasa(ddlProducto.SelectedValue, plazoTexto);

                CalculadoraInteres calculadora = new CalculadoraInteres();

                List<DetalleCotizacion> detalle = calculadora.CalcularDetalle(monto, tasa, meses);

                decimal totalBruto = 0;
                decimal totalImpuesto = 0;
                decimal totalNeto = 0;

                var listaMostrar = new List<object>();

                foreach (var item in detalle)
                {
                    totalBruto += item.InteresBruto;
                    totalImpuesto += item.Impuesto;
                    totalNeto += item.InteresNeto;

                    listaMostrar.Add(new
                    {
                        Mes = item.Mes,
                        Monto = item.Monto,
                        Bruto = item.InteresBruto,
                        Impuesto = item.Impuesto,
                        Neto = item.InteresNeto
                    });
                }

                lblCliente.Text = txtNombre.Text;
                lblProducto.Text = producto;
                lblMonto.Text = monto.ToString("N2");
                lblPlazo.Text = plazoTexto;
                lblTasa.Text = tasa.ToString("N2") + "%";

                lblBruto.Text = totalBruto.ToString("N2");
                lblImpuesto.Text = totalImpuesto.ToString("N2");
                lblNeto.Text = totalNeto.ToString("N2");

                gvDetalle.DataSource = listaMostrar;
                gvDetalle.DataBind();

                lblMensaje.Text = "Cotización calculada correctamente.";
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Ocurrió un error al calcular la cotización: " + ex.Message;
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtCedula.Text = "";
            txtNombre.Text = "";
            txtTelefono.Text = "";
            txtCorreo.Text = "";
            txtMonto.Text = "";

            ddlProducto.SelectedIndex = 0;
            ddlPlazo.SelectedIndex = 0;

            lblCliente.Text = "";
            lblProducto.Text = "";
            lblMonto.Text = "";
            lblPlazo.Text = "";
            lblTasa.Text = "";
            lblBruto.Text = "";
            lblImpuesto.Text = "";
            lblNeto.Text = "";
            lblMensaje.Text = "";

            gvDetalle.DataSource = null;
            gvDetalle.DataBind();
        }

        private int ObtenerMeses(string plazoTexto)
        {
            switch (plazoTexto)
            {
                case "15 días": return 1;
                case "1 mes": return 1;
                case "2 meses": return 2;
                case "3 meses": return 3;
                case "4 meses": return 4;
                case "5 meses": return 5;
                case "6 meses": return 6;
                case "7 meses": return 7;
                case "8 meses": return 8;
                case "9 meses": return 9;
                case "10 meses": return 10;
                case "11 meses": return 11;
                case "12 meses": return 12;
                case "13 meses": return 13;
                case "14 meses": return 14;
                case "15 meses": return 15;
                case "16 meses": return 16;
                case "17 meses": return 17;
                case "18 meses": return 18;
                case "19 meses": return 19;
                case "20 meses": return 20;
                case "21 meses": return 21;
                case "22 meses": return 22;
                case "23 meses": return 23;
                case "24 meses": return 24;
                default: return 0;
            }
        }

        private decimal ObtenerTasa(string producto, string plazo)
        {
            if (producto == "CC")
            {
                switch (plazo)
                {
                    case "15 días": return 3.1500m;
                    case "1 mes": return 3.2500m;
                    case "2 meses": return 3.4000m;
                    case "3 meses": return 3.6000m;
                    case "4 meses": return 3.7500m;
                    case "5 meses": return 3.9000m;
                    case "6 meses": return 4.1000m;
                    case "7 meses": return 4.2500m;
                    case "8 meses": return 4.4000m;
                    case "9 meses": return 4.5500m;
                    case "10 meses": return 4.7000m;
                    case "11 meses": return 4.8500m;
                    case "12 meses": return 5.0000m;
                    case "13 meses": return 5.1000m;
                    case "14 meses": return 5.2000m;
                    case "15 meses": return 5.3000m;
                    case "16 meses": return 5.4000m;
                    case "17 meses": return 5.5000m;
                    case "18 meses": return 5.6500m;
                    case "19 meses": return 5.8000m;
                    case "20 meses": return 5.9500m;
                    case "21 meses": return 6.1000m;
                    case "22 meses": return 6.2500m;
                    case "23 meses": return 6.4000m;
                    case "24 meses": return 6.5500m;
                }
            }

            if (producto == "CF")
            {
                switch (plazo)
                {
                    case "3 meses": return 3.8500m;
                    case "4 meses": return 4.0000m;
                    case "5 meses": return 4.1500m;
                    case "6 meses": return 4.3500m;
                    case "7 meses": return 4.5000m;
                    case "8 meses": return 4.6500m;
                    case "9 meses": return 4.8000m;
                    case "10 meses": return 4.9500m;
                    case "11 meses": return 5.1000m;
                    case "12 meses": return 5.3000m;
                    case "13 meses": return 5.4000m;
                    case "14 meses": return 5.5000m;
                    case "15 meses": return 5.6000m;
                    case "16 meses": return 5.7000m;
                    case "17 meses": return 5.8000m;
                    case "18 meses": return 5.9500m;
                    case "19 meses": return 6.1000m;
                    case "20 meses": return 6.2500m;
                    case "21 meses": return 6.4000m;
                    case "22 meses": return 6.5500m;
                    case "23 meses": return 6.7000m;
                    case "24 meses": return 6.9000m;
                }
            }

            if (producto == "DS")
            {
                switch (plazo)
                {
                    case "1 mes": return 1.0000m;
                    case "2 meses": return 1.2500m;
                    case "3 meses": return 1.5000m;
                    case "4 meses": return 1.6500m;
                    case "5 meses": return 1.8000m;
                    case "6 meses": return 2.0000m;
                    case "7 meses": return 2.1500m;
                    case "8 meses": return 2.3000m;
                    case "9 meses": return 2.4500m;
                    case "10 meses": return 2.6000m;
                    case "11 meses": return 2.7500m;
                    case "12 meses": return 2.9000m;
                    case "13 meses": return 3.0000m;
                    case "14 meses": return 3.1000m;
                    case "15 meses": return 3.2000m;
                    case "16 meses": return 3.3000m;
                    case "17 meses": return 3.4000m;
                    case "18 meses": return 3.5500m;
                    case "19 meses": return 3.7000m;
                    case "20 meses": return 3.8500m;
                    case "21 meses": return 4.0000m;
                    case "22 meses": return 4.1500m;
                    case "23 meses": return 4.3000m;
                    case "24 meses": return 4.4500m;
                }
            }

            if (producto == "DV")
            {
                switch (plazo)
                {
                    case "3 meses": return 2.7500m;
                    case "4 meses": return 2.9000m;
                    case "5 meses": return 3.0500m;
                    case "6 meses": return 3.2500m;
                    case "7 meses": return 3.4000m;
                    case "8 meses": return 3.5500m;
                    case "9 meses": return 3.7000m;
                    case "10 meses": return 3.8500m;
                    case "11 meses": return 4.0000m;
                    case "12 meses": return 4.2000m;
                    case "13 meses": return 4.3000m;
                    case "14 meses": return 4.4000m;
                    case "15 meses": return 4.5000m;
                    case "16 meses": return 4.6000m;
                    case "17 meses": return 4.7000m;
                    case "18 meses": return 4.8500m;
                    case "19 meses": return 5.0000m;
                    case "20 meses": return 5.1500m;
                    case "21 meses": return 5.3000m;
                    case "22 meses": return 5.4500m;
                    case "23 meses": return 5.6000m;
                    case "24 meses": return 6.8500m;
                }
            }

            return 0;
        }
    }
}