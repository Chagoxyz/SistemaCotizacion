using System.Configuration;
using System.Data.SqlClient;

namespace SistemaCotizacion.Utilidades
{
    public class ConexionDB
    {
        public static SqlConnection ObtenerConexion()
        {
            string cadena = ConfigurationManager.ConnectionStrings["ConexionDB"].ConnectionString;
            return new SqlConnection(cadena);
        }
    }
}