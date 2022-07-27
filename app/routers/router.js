const express = require('express');
const router = express.Router();
const controller = require('../controllers/controller');

// Gestion des erreurs
const routerWrapper = require('../middlewares/routerWrapper');
const handleError = require('../middlewares/handleError');

router
  .get('/', routerWrapper(controller.home))
  .get('/backoffice', routerWrapper(controller.backOffice))
  .post('/backoffice/newRace', routerWrapper(controller.createNewRace));

router.use(handleError);

module.exports = router;
