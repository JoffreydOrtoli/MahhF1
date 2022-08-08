const express = require('express');
const router = express.Router();
const controller = require('../controllers/controller');

// Gestion des erreurs
const routerWrapper = require('../middlewares/routerWrapper');
const handleError = require('../middlewares/handleError');

router
  .get('/', routerWrapper(controller.home))
  .get('/rankdrivers', routerWrapper(controller.getAllDriversRank))
  .get('/driver/:driverId', routerWrapper(controller.driverPage))
  .get('/team/:teamId', routerWrapper(controller.teamPage))
  .get('/backoffice', routerWrapper(controller.backOffice))
  .post('/backoffice/newQualif', routerWrapper(controller.createNewQualif))
  .post('/backoffice/newRaceQualif', routerWrapper(controller.createNewRaceQualif))
  .post('/backoffice/newRace', routerWrapper(controller.createNewRace));

router.use(handleError);

module.exports = router;
