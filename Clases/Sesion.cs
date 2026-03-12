using System;

namespace SistemaCotizacion.Clases
{
    public class Sesion
    {
        public int IdSesion { get; set; }
        public Usuario Usuario { get; set; }
        public DateTime FechaInicio { get; set; }
        public string Estado { get; set; }
    }
}