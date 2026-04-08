using System.Configuration;
using System.Data.SqlClient;

namespace SistemaCotizacion.Utilidades
{
    public class ConexionDB
    {
        public static SqlConnection ObtenerConexion()
        {
            string cadena = ConfigurationManager.ConnectionStrings["cnSistemaCotizacion"].ConnectionString;
            return new SqlConnection(cadena);
        }
    }
}