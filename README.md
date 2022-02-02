# ProyectoLP
## Introducción
Pasantic es una aplicación que brinda a empresas y estudiantes un medio de comunicación en el cual las empresas presentan sus ofertas de pasantías, los estudiantes postulan las ofertas y por último la empresa se encarga de aceptar postulantes. 

## Backend
* Dentro del directorio del [backend](https://github.com/DannyMontenegro/ProyectoLP/tree/main/pasantic_backend) crear una carpeta llamada "config" y dentro de dicha carpeta crear el archivo "config.json" con la siguiente información: ```{
  "development": {
    "username": "",
    "password": "",
    "database": "pasantic",
    "host": "127.0.0.1",
    "dialect": "mysql"
  },
    "test": {
      "username": "root",
      "password": null,
      "database": "database_test",
      "host": "127.0.0.1",
      "dialect": "mysql"
    },
    "production": {
      "username": "root",
      "password": null,
      "database": "database_production",
      "host": "127.0.0.1",
      "dialect": "mysql"
    }
  }```. Debe ingresar las credenciales de su base de datos en los campos username y password de "development".</br>
* Iniciar el servidor con npm run devstart

## Frontend
Se está utilizando Flutter junto con Android Studio, para ejecutar el apk es preferible emular un dispositivo Pixel 5 (1080 x 2340).

## Desarrolladores 
* [Miguel Licea](https://github.com/miglcesp01)
* [Raúl Villao](https://github.com/Rv2719)
* [Danny Montenegro](https://github.com/DannyMontenegro)
