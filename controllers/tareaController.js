const Tarea = require('../models/tareaModel');
// @desc    Obtener todas las tareas
// @route   GET /api/tareas
// @access  Public
exports.obtenerTareas = async (req, res) => {
 try {
   // Filtros opcionales desde query params
   const { completada, prioridad, categoria, buscar } = req.query;
   // Construir filtro
   let filtro = {};
   if (completada !== undefined) {
     filtro.completada = completada === 'true';
   }
   if (prioridad) {
     filtro.prioridad = prioridad;
   }
   if (categoria) {
     filtro.categoria = categoria;
   }
   if (buscar) {
     filtro.$or = [
       { titulo: { $regex: buscar, $options: 'i' } },
       { descripcion: { $regex: buscar, $options: 'i' } }
     ];
   }
   // Paginación
   const page = parseInt(req.query.page) || 1;
   const limit = parseInt(req.query.limit) || 10;
   const skip = (page - 1) * limit;
   // Ordenamiento
   const sortBy = req.query.sortBy || '-createdAt';
   // Ejecutar consulta
   const tareas = await Tarea.find(filtro)
     .sort(sortBy)
     .limit(limit)
     .skip(skip);
   // Contar total para paginación
   const total = await Tarea.countDocuments(filtro);
   res.status(200).json({
     success: true,
     count: tareas.length,
     total,
     totalPages: Math.ceil(total / limit),
     currentPage: page,
     data: tareas
   });
 } catch (error) {
   res.status(500).json({
     success: false,
     message: 'Error al obtener las tareas',
     error: error.message
   });
 }
};
// @desc    Obtener una tarea por ID
// @route   GET /api/tareas/:id
// @access  Public
exports.obtenerTareaPorId = async (req, res) => {
 try {
   const tarea = await Tarea.findById(req.params.id);
   if (!tarea) {
     return res.status(404).json({
       success: false,
       message: 'Tarea no encontrada'
     });
   }
   res.status(200).json({
     success: true,
     data: tarea
   });
 } catch (error) {
   res.status(500).json({
     success: false,
     message: 'Error al obtener la tarea',
     error: error.message
   });
 }
};
// @desc    Crear nueva tarea
// @route   POST /api/tareas
// @access  Public
exports.crearTarea = async (req, res) => {
 try {
   const tarea = await Tarea.create(req.body);
   res.status(201).json({
     success: true,
     message: 'Tarea creada exitosamente',
     data: tarea
   });
 } catch (error) {
   // Manejo de errores de validación
   if (error.name === 'ValidationError') {
     const messages = Object.values(error.errors).map(err => err.message);
     return res.status(400).json({
       success: false,
       message: 'Error de validación',
       errors: messages
     });
   }
   res.status(500).json({
     success: false,
     message: 'Error al crear la tarea',
     error: error.message
   });
 }
};
// @desc    Actualizar tarea
// @route   PUT /api/tareas/:id
// @access  Public
exports.actualizarTarea = async (req, res) => {
 try {
   const tarea = await Tarea.findByIdAndUpdate(
     req.params.id,
     req.body,
     {
       new: true, // Retornar documento actualizado
       runValidators: true // Ejecutar validaciones
     }
   );
   if (!tarea) {
     return res.status(404).json({
       success: false,
       message: 'Tarea no encontrada'
     });
   }
   res.status(200).json({
     success: true,
     message: 'Tarea actualizada exitosamente',
     data: tarea
   });
 } catch (error) {
   if (error.name === 'ValidationError') {
     const messages = Object.values(error.errors).map(err => err.message);
     return res.status(400).json({
       success: false,
       message: 'Error de validación',
       errors: messages
     });
   }
   res.status(500).json({
     success: false,
     message: 'Error al actualizar la tarea',
     error: error.message
   });
 }
};
// @desc    Eliminar tarea
// @route   DELETE /api/tareas/:id
// @access  Public
exports.eliminarTarea = async (req, res) => {
 try {
   const tarea = await Tarea.findByIdAndDelete(req.params.id);
   if (!tarea) {
     return res.status(404).json({
       success: false,
       message: 'Tarea no encontrada'
     });
   }
   res.status(200).json({
     success: true,
     message: 'Tarea eliminada exitosamente',
     data: {}
   });
 } catch (error) {
   res.status(500).json({
     success: false,
     message: 'Error al eliminar la tarea',
     error: error.message
   });
 }
};
// @desc    Completar tarea
// @route   PATCH /api/tareas/:id/completar
// @access  Public
exports.completarTarea = async (req, res) => {
 try {
   const tarea = await Tarea.findById(req.params.id);
   if (!tarea) {
     return res.status(404).json({
       success: false,
       message: 'Tarea no encontrada'
     });
   }
   await tarea.completar();
   res.status(200).json({
     success: true,
     message: 'Tarea completada',
     data: tarea
   });
 } catch (error) {
   res.status(500).json({
     success: false,
     message: 'Error al completar la tarea',
     error: error.message
   });
 }
};
// @desc    Reabrir tarea
// @route   PATCH /api/tareas/:id/reabrir
// @access  Public
exports.reabrirTarea = async (req, res) => {
 try {
   const tarea = await Tarea.findById(req.params.id);
   if (!tarea) {
     return res.status(404).json({
       success: false,
       message: 'Tarea no encontrada'
     });
   }
   await tarea.reabrir();
   res.status(200).json({
     success: true,
     message: 'Tarea reabierta',
     data: tarea
   });
 } catch (error) {
   res.status(500).json({
     success: false,
     message: 'Error al reabrir la tarea',
     error: error.message
   });
 }
};
// @desc    Obtener estadísticas
// @route   GET /api/tareas/stats
// @access  Public
exports.obtenerEstadisticas = async (req, res) => {
 try {
   const estadisticas = await Tarea.obtenerEstadisticas();
   res.status(200).json({
     success: true,
     data: estadisticas
   });
 } catch (error) {
   res.status(500).json({
     success: false,
     message: 'Error al obtener estadísticas',
     error: error.message
   });
 }
};
// @desc    Obtener tareas por prioridad
// @route   GET /api/tareas/prioridad/:prioridad
// @access  Public
exports.obtenerPorPrioridad = async (req, res) => {
 try {
   const { prioridad } = req.params;
   if (!['baja', 'media', 'alta'].includes(prioridad)) {
     return res.status(400).json({
       success: false,
       message: 'Prioridad no válida. Use: baja, media o alta'
     });
   }
   const tareas = await Tarea.obtenerPorPrioridad(prioridad);
   res.status(200).json({
     success: true,
     count: tareas.length,
     data: tareas
   });
 } catch (error) {
   res.status(500).json({
     success: false,
     message: 'Error al obtener tareas por prioridad',
     error: error.message
   });
 }
}
