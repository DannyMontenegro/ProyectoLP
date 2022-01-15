'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    return queryInterface.bulkInsert('Users',[{
      email:'espol@espol.edu.ec',
      password: 'espol',
      name: 'ESPOL',
      description: 'Escuela Superior Politecnica del Litoral',
      role: 'empresa',
    }, {
      email: 'tia@tia.com',
      password: 'tia',
      name: 'TIA',
      description: 'Tiendas Industriales Asociadas',
      role: 'empresa',
    },  {
      email: 'rodaltech@rodaltech.com',
      password: 'rodaltech',
      name: 'Rodaltech',
      description: 'Avanzando hacia la Industria4.0',
      role: 'empresa',
    }, {
      email: 'danny@danny.com',
      password: 'danny',
      name: 'Danny Montenegro',
      description: 'Estudiante de Ingenieria en Computacion',
      role: 'estudiante',
    }, {
      email: 'josue@josue.com',
      password: 'josue',
      name: 'Josue Villao',
      description: 'Estudiante de Ingenieria en Computacion',
      role: 'estudiante',
    }, {
      email: 'miguel@miguel.com',
      password: 'miguel',
      name: 'Miguel Licea',
      description: 'Estudiante de Ingenieria en Computacion',
      role: 'estudiante',
    }, {
      email: 'rodrigo_estudiante@rodrigo_estudiante.com',
      password: 'rodrigo_estudiante',
      name: 'Rodrigo Saraguro',
      description: 'Estudiante de Ingenieria en Computacion',
      role: 'estudiante',
    }, {
      email: 'rodrigo_empresa@rodrigo_empresa.com',
      password: 'rodrigo_empresa',
      name: 'Rodrigo Saraguro',
      description: 'Empresa de creaciond de proyectos informaticos',
      role: 'estudiante',
    }])
  },

  down: async (queryInterface, Sequelize) => {
    return queryInterface.bulkDelete('Users', null, {});
  }
};
