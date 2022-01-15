'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    return queryInterface.bulkInsert('Enterprises',[{
      phone_number: '+593-4-2269-111',
      idUser: 9
    },{
      phone_number: '+593-4-2598-830',
      idUser: 10
    },{
      phone_number: '+593-4-5826-589',
      idUser: 11
    },{
      phone_number: '+593-4-5826-589',
      idUser: 16
    }]);
  },

  down: async (queryInterface, Sequelize) => {
    return queryInterface.bulkDelete('Enterprises', null, {});
  }
};
