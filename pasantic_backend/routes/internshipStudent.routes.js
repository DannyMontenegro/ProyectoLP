var express = require('express');
var router = express.Router();

const Sequelize = require('sequelize');
const models = require('../models');


router.get('/', async (req, res, next) =>{
    try {
        internshipsStudents = await models.InternshipStudent.findAll({
            include: [{ model: models.Student},{ model: models.Internship}]
        });
    }catch(err){
        next(err);
    }
});

router.post('/', async (req, res, next) =>{
    try {
        const {idStudent,idInternship} = req.body;

        let internshipStudent = await models.InternshipStudent.create({
            status: 'En Elección',
            idStudent: idStudent,
            idInternship: idInternship
        });

        res.status(201).json({
            status: 201,
            payload: {
                internshipStudent: internshipStudent
            }
        });

    } catch (error) {
        next(e)
    }
});

router.put('/studentAccept', async (req, res, next) =>{
    try {
        const { idStudent,idInternship} = req.body;

        //Modificando el estudiante aprobado
        await models.InternshipStudent.update({
            status:"Aprobado"
        },{
            where: {
                idStudent: idStudent,
                idInternship: idInternship
            }
        });

        //Modificando los estudiantes no aprobados
        await models.InternshipStudent.update({
            status:"Denegado"
        },{
            where: {
                idStudent: {
                    [Sequelize.Op.ne]:idStudent
                },
                idInternship: idInternship
            }
        });


        //Modificando las pasantias a eliminacion logica
        await models.Internship.update({
            isActive: false,
            isRecruiting: false
        },{
            where:{
                id : idInternship
            }
        });

        let internship = await models.Internship.findByPk(idInternship,{
            include: [{model:models.Enterprise },{model: models.InternshipStudent}]
        });
        
        res.status(200).json({
            status: 200,
            payload: {
                internship: internship
            }
        });

    }catch (err){
        next(err);
    }
});

module.exports =router;