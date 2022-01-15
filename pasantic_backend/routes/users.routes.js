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

//view_user_profile
router.get('/:id',async (req, res, next)=>{
  try{
    
    const id = req.params.id;
    let user = await models.User.findByPk(id,{
      include: [{ model: models.Student},{ model: models.Enterprise}]
    });

    res.status(200).json({ 
      status: 200,
      payload: {
        user: user
      }
    });

  }catch(err){
    next(err);
  }
});

router.delete('/:id', async (req, res,next)=>{
  try{
    const id =  req.params.id;

    let user = await models.User.findByPk(id,{
      include: [{ model: models.Student},{ model: models.Enterprise}]
    });

    if(user.Student !=null){
      let intershipsStudent = await models.InternshipStudent.destroy({
        where:{
          idStudent : user.Student.id
        }
      });

      let student = await models.Student.destroy({
        where:{
          id: user.Student.id
        }
      })

      await models.User.destroy({
        where:{
          id: user.id
        }
      })
      

    }
    res.status(200).json({"sucess": "Cuenta eliminada satisfactoriamente"})

  }catch(err){
    next(err);
  }
});



module.exports = router;
