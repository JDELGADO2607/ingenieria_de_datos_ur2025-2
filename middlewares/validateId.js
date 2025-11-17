const mongoose = require('mongoose');

// Middleware para validar ObjectId de MongoDB

const validateId = (req, res, next) => {

  const id = req.params.id;

  if (!mongoose.Types.ObjectId.isValid(id)) {

    return res.status(400).json({

      success: false,

      message: 'ID no válido',

      error: `"${id}" no es un ObjectId válido de MongoDB`

    });

  }

  next();

};

module.exports = validateId;
