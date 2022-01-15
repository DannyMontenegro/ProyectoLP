'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    return queryInterface.bulkInsert('Students',[{
      degree: 'Computacion',
      linkedinProfile: 'https://www.linkedin.com/in/miguel-licea/',
      idUser: 14
    },{
      degree: 'Computacion',
      linkedinProfile: 'https://www.linkedin.com/in/raul-josue-villao-rodr%C3%ADguez-82756322b/',
      idUser: 13
    },{
      degree: 'Computacion',
      linkedinProfile: 'https://www.linkedin.com/in/danny-montenegro-1839b01b4',
      idUser: 12
    },{
      degree: 'Computacion',
      linkedinProfile: 'https://www.linkedin.com/in/rodrigo-saraguro-bravo-3b362639/',
      idUser: 15
    }]);
  },

  down: async (queryInterface, Sequelize) => {
    return queryInterface.bulkDelete('Students', null, {});
  }
};
