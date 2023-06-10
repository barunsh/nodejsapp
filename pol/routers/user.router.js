const router = require('express').Router();
const UserController = require("../controller/user.controller");

router.post('/login',UserController.login );
router.post('/registration',UserController.register );

module.exports = router;