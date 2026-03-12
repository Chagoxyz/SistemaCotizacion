using System;

namespace SistemaCotizacion.Clases
{
    public class Reporte
    {
        public int IdReporte { get; set; }
        public string TipoReporte { get; set; }
        public string Formato { get; set; }
        public DateTime FechaGeneracion { get; set; }
        public string UsuarioGenerador { get; set; }
    }
}