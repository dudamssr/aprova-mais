const express = require("express");
const router = express.Router();

const verificarAdmin = require("../middlewares/admin.middleware");

const {
    adicionar,
    listar,
    buscar,
    atualizar,
    excluir
} = require("../controller/materia.controller");

router.post("/adicionar", verificarAdmin, adicionar);

router.get("/listar", listar);
router.get("/buscar/:id", buscar);

router.put("/atualizar/:id", verificarAdmin, atualizar);

router.delete("/excluir/:id", verificarAdmin, excluir);

module.exports = router;