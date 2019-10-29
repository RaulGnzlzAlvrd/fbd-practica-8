Integrantes:
 - Almanza Ibarra Raziel (313126691)
 - González Alvarado Raúl (313245312)
 - Gutiérrez Velázquez Héctor Ernesto (313701063)

Intrucciones para ejecutar los scripts.

Instrucciones de ejecución.

Usando Docker:

1) Lo primero que tenemos que hacer es asegurarnos de que nuestra contenedor se esté ejecutando.

sudo docker ps -a

2) Si su STATUS es 'Up' entonces podemos continuar, si no lo podemos iniciar con el comando:

sudo docker start [NOMBRE_CONTENEDOR]

3) Luego copiamos nuestro archivo .sql en el directorio raíz de nuestro contenedor.

sudo docker cp sql/ddl/[NOMBRE_ARCHIVO].sql [NOMBRE_CONTENEDOR]:/ 

4) Entramos a nuestro contenedor:

sudo docker exec -it [NOMBRE_CONTENEDOR] bash
 
5) Ahora desde el directorio donde se encuentra nuestro script .sql, basta con ejecutar el script desde la linea de comandos:

sqlcmd -S localhost -U SA -P "[PASSWORD]" -i [NOMBRE_SCRIPT].sql

Nota1: El comando debe de ejecutarse con el usuario SA ya que usa la base de datos master.

Nota2: Puede que en algunos casos se deba especificar el path completo para el comando sqlcmd. Para la versión de Docker el path es '/opt/mssql-tools/bin' con lo que el comando quedaría: 

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "[PASSWORD]" -i [NOMBRE_ARCHIVO].sql
