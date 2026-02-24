const express = require('express');
const router = express.Router();
const performanceController = require('../controllers/performanceController');

router.get('/appraisals', performanceController.getAllAppraisals);
router.get('/cycles', performanceController.getPerformanceCycles);
router.post('/appraisals', performanceController.createAppraisal);
router.get('/dashboard', performanceController.getDashboardStats);

module.exports = router;
