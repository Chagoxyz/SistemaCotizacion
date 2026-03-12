using System;

namespace SistemaCotizacion.Clases
{
    public class Plazo
    {
        public int IdPlazo { get; set; }
        public string Descripcion { get; set; }
        public int Cantidad { get; set; }
        public string Tipo { get; set; }
        public string Estado { get; set; }
    }
}