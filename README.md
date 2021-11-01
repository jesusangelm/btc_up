# BtcUp

Aplicacion Elixir **experimental** para persistir en una Base de datos PostgreSQL los precios diarios
de Bitcoin. El dataset de precios desde el 2009 al 2021 fue tomado de [btc-historical-price
](https://github.com/davidmunozlahoz/btc-historical-price)

Las fechas faltantes provienen de la API de [Coindesk](https://old.coindesk.com/coindesk-api)

## Uso

Actualmente ejecuto esta app en una Raspberry PI 4, `Quantum` se encarga de ejecutar a la hora especificada el
`DailyUpdater` el cual sera usado como proceso secundario encargado de hacer las peticiones a 
la API de Coindesk. Esta informacion luego es persistida en PostgreSQL. Yo visualizo los datos mediante un 
dashboard en Grafana conectado a la base de datos.


La aplicacion fue realizada bajo fines didacticos como practica para aprender el lenguaje [Elixir](https://elixir-lang.org/)
