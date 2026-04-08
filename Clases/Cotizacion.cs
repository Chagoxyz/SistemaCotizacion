using System;
using System.Collections.Generic;

namespace SistemaCotizacion.Clases
{
    public class Cotizacion
    {
        public int IdCotizacion { get; set; }
        public int NumeroCotizacion { get; set; }
        public int IdCliente { get; set; }
        public int IdProducto { get; set; }
        public int IdPlazo { get; set; }
        public int IdTasa { get; set; }
        public decimal Monto { get; set; }
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