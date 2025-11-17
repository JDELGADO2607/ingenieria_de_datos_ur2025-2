const express = require('express');
const router = express.Router();
const validateId = require('../middlewares/validateId');
const {
 obtenerTareas,
 obtenerTareaPorId,
 crearTarea,
 actualizarTarea,
 eliminarTarea,
 completarTarea,
 reabrirTarea,
 obtenerEstadisticas,
 obtenerPorPrioridad
} = require('../controllers/tareaController');
// Rutas especiales (deben ir ANTES de las rutas con :id)
router.get('/tareas/stats', obtenerEstadisticas);
router.get('/tareas/prioridad/:prioridad', obtenerPorPrioridad);
// Rutas CRUD principales
router.route('/tareas')
 .get(obtenerTareas)
 .post(crearTarea);
router.route('/tareas/:id')
 .get(validateId, obtenerTareaPorId)
 .put(validateId, actualizarTarea)
 .delete(validateId, eliminarTarea);
// Rutas para completar/reabrir
router.patch('/tareas/:id/completar', validateId, completarTarea);
router.patch('/tareas/:id/reabrir', validateId, reabrirTarea);
module.exports = router;
