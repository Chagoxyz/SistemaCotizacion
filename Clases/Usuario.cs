using System;

namespace SistemaCotizacion.Clases
{
    public class Usuario
    {
        public int IdUsuario { get; set; }
        public string NombreCompleto { get; set; }
        public string NombreUsuario { get; set; }
        public string Contrasena { get; set; }

        public Rol Rol { get; set; }

        public string Estado { get; set; }
    }
}