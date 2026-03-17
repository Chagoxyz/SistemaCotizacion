using System;
using System.Collections.Generic;

namespace SistemaCotizacion.Clases
{
    public class CalculadoraInteres
    {
        private const decimal IMPUESTO = 0.13m;

        public List<DetalleCotizacion> CalcularDetalle(decimal monto, decimal tasaAnual, int plazoMeses)
        {
            List<DetalleCotizacion> lista = new List<DetalleCotizacion>();

            decimal interesMensual = monto * (tasaAnual / 100m) / 360m * 30m;
            decimal impuestoMensual = interesMensual * IMPUESTO;
            decimal netoMensual = interesMensual - impuestoMensual;

            for (int i = 1; i <= plazoMeses; i++)
            {
                lista.Add(new DetalleCotizacion
                {
                    Mes = i,
                    Monto = monto,
                    InteresBruto = interesMensual,
                    Impuesto = impuestoMensual,
                    InteresNeto = netoMensual
                });
            }

            return lista;
        }
    }
}