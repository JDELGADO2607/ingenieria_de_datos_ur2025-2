const mongoose = require('mongoose');

//definir Schema
const tareaSchema = new mongoose.Schema({
    titulo: {
        type: String,
        required: true,
        trim: true,
        minlength: 3,
        maxlength: 100
    },
    descripcion: {
        type: String,
        required: true,
        trim: true,
        minlength: 3,
        maxlength: 500
    },
    prioridad:{
        type: String,
        enum: ['baja', 'media', 'alta'],
        default: 'media',  
        message: '{VALUE} no es una prioridad válida'
    },
    categoria:{
        type: String,
        enum: ['trabajo', 'personal', 'estudios', 'otros'],
        default: 'otros',
        message: '{VALUE} no es una categoría válida'
    },
    estado:{
        type: String,
        enum: ['pendiente', 'en progreso', 'completada'],
        default: 'pendiente',
        message: '{VALUE} no es un estado válido'
    },
    fetchedAt:{
        type: Date,
        default: Date.now
    }
});

//accesos a datos repositories

module.exports = mongoose.model('Tarea', tareaSchema);
