
const express = require("express");
const router = express.Router();

const { autenticarToken } = require("../middlewares/auth.middleware");

const {
    listar,
    adicionar,
    atualizar,
    excluir
} = require("../controller/agenda.controller");

router.get("/listar", listar);
router.post("/adicionar",  adicionar);
router.put("/atualizar/:id", atualizar);
router.delete("/excluir/:id", excluir);

module.exports = router;
