using System;

namespace SistemaCotizacion.Clases
{
    public class DetalleCotizacion
    {
        public int Mes { get; set; }
        public decimal Monto { get; set; }
        public decimal InteresBruto { get; set; }
        public decimal Impuesto { get; set; }
        public decimal InteresNeto { get; set; }
    }
}