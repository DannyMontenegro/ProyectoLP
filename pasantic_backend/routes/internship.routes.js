var express = require('express');
var router = express.Router();

const Sequelize = require('sequelize');
const models = require('../models');

//get_internships
router.get('/', async (req, res, next) => {
    try { 
        internships = await models.Internship.findAll({
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

module.exports =router;