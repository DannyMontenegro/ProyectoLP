var express = require('express');
var router = express.Router();

const Sequelize = require('sequelize');
const models = require('../models');

//get_users
router.get('/', async function(req, res, next) {
  
  try{
    usuarios = await models.User.findAll({
      include: [{ model: models.Student},{ model: models.Enterprise}]
    });
    res.json(usuarios);
  }catch(err){
    next(err);
  }
});


//create_user
router.post('/',async function(req,res,next){
  try{
    const { email, password, name, description, role} = req.body;
    let user = await models.User.create({
      email: email,
      password: password,
      name: name,
      description: description,
      role: role
    });

    return res.status(201).json({
      status: 201,
      payload: {
        user: user
      }
    })
  
  }catch(error){
    next(error);
  }
  

});



module.exports = router;
