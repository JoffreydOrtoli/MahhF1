const express = require('express');
const router = express.Router();
const controller = require('../controllers/controller');
// // Gestion des erreurs
const routerWrapper = require('../middlewares/routerWrapper');
const handleError = require('../middlewares/handleError');

router
  .route('/')
  .get(routerWrapper(controller.getExample));

router.use(handleError);

module.exports = router;
