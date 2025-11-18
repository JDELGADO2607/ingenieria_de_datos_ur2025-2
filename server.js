require('dotenv').config();

const express = require('express');

const cors = require('cors');

const connectDB = require('./config/database');

const errorHandler = require('./middlewares/errorHandler');

const tareaRoutes = require('./routes/tareaRoutes');

// Crear aplicación Express

const app = express();

// Conectar a MongoDB

connectDB();

// Middlewares

app.use(cors());

app.use(express.json());

app.use(express.urlencoded({ extended: true }));

// Logger middleware (solo en desarrollo)

if (process.env.NODE_ENV === 'development') {

  app.use((req, res, next) => {

    console.log(`${req.method} ${req.path} - ${new Date().toISOString()}`);

    next();

  });

}

// Ruta raíz

app.get('/', (req, res) => {

  res.json({

    message: '🚀 API de Gestión de Tareas',

    version: '1.0.0',

    endpoints: {

      tareas: {

        obtenerTodas: 'GET /api/tareas',

        obtenerPorId: 'GET /api/tareas/:id',

        crear: 'POST /api/tareas',

        actualizar: 'PUT /api/tareas/:id',

        eliminar: 'DELETE /api/tareas/:id',

        completar: 'PATCH /api/tareas/:id/completar',

        reabrir: 'PATCH /api/tareas/:id/reabrir',

        estadisticas: 'GET /api/tareas/stats',

        porPrioridad: 'GET /api/tareas/prioridad/:prioridad'

      }

    },

    parametrosQuery: {

      filtros: 'completada, prioridad, categoria, buscar',

      paginacion: 'page, limit',

      ordenamiento: 'sortBy'

    }

  });

});

// Montar rutas

app.use('/api', tareaRoutes);

// Middleware de manejo de errores (debe ir después de las rutas)

app.use(errorHandler);

// Ruta 404

app.use((req, res) => {

  res.status(404).json({

    success: false,

    message: 'Ruta no encontrada',

    path: req.path

  });

});

// Puerto y servidor

const PORT = 3000 || 3000;

const server = app.listen(PORT, () => {

  console.log('');

  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

  console.log('🚀 SERVIDOR EXPRESS INICIADO');

  console.log(`📡 Puerto: ${PORT}`);

  console.log(`🌍 Entorno: ${process.env.NODE_ENV || 'development'}`);

  console.log(`🔗 URL: http://localhost:${PORT}`);

  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

  console.log('');

});

// Manejo de errores no capturados

process.on('unhandledRejection', (err) => {

  console.error('❌ UNHANDLED REJECTION:', err);

  server.close(() => process.exit(1));

});

process.on('uncaughtException', (err) => {

  console.error('❌ UNCAUGHT EXCEPTION:', err);

  process.exit(1);

});
 
