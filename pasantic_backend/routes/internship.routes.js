var express = require('express');
var router = express.Router();
const { PAGE_LIMIT_MAX,PAGE_START} = require('../constants/pagination.constants')
const { calculateOffset } = require('../helpers/calculations')
const Sequelize = require('sequelize');
const models = require('../models');

//get_internships
router.get('/', async (req, res, next) => {
    try { 
        const limit = parseInt(req.param("limit",PAGE_LIMIT_MAX));
        const offset = calculateOffset(limit,req.param("page",PAGE_START))

        internships = await models.Internship.findAll({
            limit: limit,
            offset: offset,
            include: [{ model: models.Enterprise },{model: models.InternshipStudent}]
        });
        res.status(200).json(internships);
    }catch(err) {
        next(err);
    }
});

//create_internship
router.post('/',async (req,res,next) => {
    try { 
        const { title, description, industry, internshipProcess, dateFrom,
             dateTo, location, workMode, payment, idEnterprise } = req.body;

        let internship = await models.Internship.create({
            title: title,
            description: description,
            industry: industry,
            isActive: true,
            isRecruiting: true,
            internshipProcess: internshipProcess,
            dateFrom: dateFrom,
            dateTo: dateTo,
            location: location,
            workMode: workMode,
            payment: payment,
            idEnterprise: idEnterprise,
        });

        return res.status(201).json({
            status: 201,
            payload: {
                internship: internship
            }
        });

    } catch(err) {
        next(err);
    }
});

router.get('/interns/:id', async (req, res, next)=>{
    try{
        const id = req.params.id

        let interns =await  models.InternshipStudent.findAll({
            where : {
                idInternship : id
            },
            include : [{model: models.Student}]
        })

        return res.status(200).json({
            status: 200,
            payload: {
                interns: interns
            }
        })

    }catch(err){
        next(err);
    }
})



module.exports =router;