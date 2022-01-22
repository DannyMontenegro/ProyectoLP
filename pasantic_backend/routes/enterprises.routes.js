var express = require('express');
var router = express.Router();

const { validatePagination} = require('../validations/pagination.validator')
const Sequelize = require('sequelize');
const models = require('../models');
//const transporter = require('../constants/mail.constants');

// Enviar correo
// let mailOptions = {
//   from: process.env.MAIL_SENDER_USER,
//   to: updatedUser.Email,
//   subject: 'Confirmacion de Actualizacion de Contrasena',
//   text: `Estimado ${teacher.FirstName} ${teacher.LastName},\nSus credenciales han sido actualizadas con exito en el sistema. Sus credenciales son: \nUsuario: ${updatedUser.UserName} \nContrasena: ${newPass} \n\nEste mensaje ha sido generado de forma automatica, por favor, no responda a este remitente.`
// };
// transporter.sendMail(mailOptions, function(error, info){
//   if (error) {
//     console.log(error);
//   } else {
//     console.log('Email sent: ' + info.response);
//   }
// });

//get_enterprises
router.get('/', async function(req, res, next) {
  try{
    enterprises = await models.Enterprise.findAll({
      include: [{ model: models.User},{model: models.Internship}]
    });
    res.status(200).json(enterprises);
  }catch(err){
    next(err);
  }
});

//create_enterpise
router.post('/',validatePagination(),async function(req,res,next){
  try{
    const { phone_number, idUser} = req.body;

    let enterprise = await models.Enterprise.create({
      phone_number: phone_number,
      idUser: idUser
    });

    return res.status(201).json({
      status: 201,
      payload: {
        enterprise: enterprise,
      }
    });
  }catch(err){
    next(err);
  }
});

//get_enterprise_id
router.get('/:id',async function(req,res,next){
  try{
    const id = req.params.id
    const enterprise = await models.Enterprise.findByPk(id,{
      include: [{model: models.User,},{model: models.Internship}]
    });

    return res.status(200).json({
      status: 200,
      payload: {
        enterprise: enterprise,
      }
    })
  }catch(err){
    next(err);
  }
});

module.exports = router;