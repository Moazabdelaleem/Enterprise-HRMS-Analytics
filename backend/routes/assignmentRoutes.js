const express = require('express');
const router = express.Router();
const assignmentController = require('../controllers/assignmentController');

router.post('/', assignmentController.createAssignment);
router.get('/', assignmentController.getAllAssignments);
router.put('/:id', assignmentController.updateAssignment);
router.get('/employee/:employeeId', assignmentController.getAssignmentsByEmployee);

module.exports = router;
