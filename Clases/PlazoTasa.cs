using System;

namespace SistemaCotizacion.Clases
{
    public class PlazoTasa
    {
        public int IdTasa { get; set; }
        public int IdProducto { get; set; }
        public int IdPlazo { get; set; }
        public decimal TasaAnual { get; set; }
        public string Estado { get; set; }
    }
}