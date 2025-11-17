
// Middleware global de manejo de errores

const errorHandler = (err, req, res, next) => {

  console.error('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

  console.error('❌ ERROR CAPTURADO:');

  console.error('Nombre:', err.name);

  console.error('Mensaje:', err.message);

  console.error('Stack:', err.stack);

  console.error('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

  // Error de Cast (ID inválido)

  if (err.name === 'CastError') {

    return res.status(400).json({

      success: false,

      message: 'Recurso no encontrado',

      error: 'ID no válido'

    });

  }

  // Error de validación

  if (err.name === 'ValidationError') {

    const messages = Object.values(err.errors).map(error => error.message);

    return res.status(400).json({

      success: false,

      message: 'Error de validación',

      errors: messages

    });

  }

  // Error de duplicado

  if (err.code === 11000) {

    const field = Object.keys(err.keyPattern)[0];

    return res.status(400).json({

      success: false,

      message: 'Valor duplicado',

      error: `El campo "${field}" ya existe en la base de datos`

    });

  }

  // Error genérico

  res.status(err.statusCode || 500).json({

    success: false,

    message: err.message || 'Error del servidor',

    ...(process.env.NODE_ENV === 'development' && { stack: err.stack })

  });

};

module.exports = errorHandler;
