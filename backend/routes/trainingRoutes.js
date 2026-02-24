const express = require('express');
const router = express.Router();
const trainingController = require('../controllers/trainingController');

router.get('/programs', trainingController.getAllTrainingPrograms);
router.get('/employee-training', trainingController.getEmployeeTraining);
router.post('/programs', trainingController.createTrainingProgram);
router.post('/enroll', trainingController.enrollEmployee);

module.exports = router;
