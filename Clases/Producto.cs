using System;

namespace SistemaCotizacion.Clases
{
    public class Producto
    {
        public int IdProducto { get; set; }
        public string CodigoProducto { get; set; }
        public string NombreProducto { get; set; }
        public string Moneda { get; set; }
        public string Estado { get; set; }
    }
}