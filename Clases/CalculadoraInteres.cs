using System;
using System.Collections.Generic;

namespace SistemaCotizacion.Clases
{
    public class CalculadoraInteres
    {
        private const decimal IMPUESTO = 0.13m;

        public List<DetalleCotizacion> Calcular(decimal monto, decimal tasa, int plazo)
        {
            List<DetalleCotizacion> lista = new List<DetalleCotizacion>();

            decimal interesMensual = monto * (tasa / 100) / 360 * 30;
            decimal impuesto = interesMensual * IMPUESTO;
            decimal neto = interesMensual - impuesto;

            for (int i = 1; i <= plazo; i++)
            {
                lista.Add(new DetalleCotizacion
                {
                    Mes = i,
                    Monto = monto,
                    InteresBruto = interesMensual,
                    Impuesto = impuesto,
                    InteresNeto = neto
                });
            }

            return lista;
        }
    }
}