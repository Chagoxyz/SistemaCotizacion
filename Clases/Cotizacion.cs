using System;
using System.Collections.Generic;

namespace SistemaCotizacion.Clases
{
    public class Cotizacion
    {
        public int NumeroCotizacion { get; set; }
        public Cliente Cliente { get; set; }
        public Producto Producto { get; set; }

        public decimal Monto { get; set; }
        public int PlazoMeses { get; set; }
        public decimal TasaAnual { get; set; }

        public decimal TotalInteresBruto { get; set; }
        public decimal TotalImpuesto { get; set; }
        public decimal TotalNeto { get; set; }

        public DateTime FechaCotizacion { get; set; }

        public List<DetalleCotizacion> Detalles { get; set; }

        public Cotizacion()
        {
            Detalles = new List<DetalleCotizacion>();
        }
    }
}