using System;

namespace SistemaCotizacion.Clases
{
    public class PlazoTasa
    {
        public int IdPlazoTasa { get; set; }
        public string Producto { get; set; }
        public int PlazoMeses { get; set; }
        public decimal TasaAnual { get; set; }
        public string Estado { get; set; }
    }
}