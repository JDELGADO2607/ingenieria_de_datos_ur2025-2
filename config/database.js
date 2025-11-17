const mongoose = require('mongoose');

const connectDB = async () => {
  try {
    const conn= await mongoose.connect(process.env.MONGO_URI);
    console.log(`MongoDB Connected: ${conn.connection.host}`);
  } catch (error) {
    console.error(`Error AL CONECTAR LA bd: ${error.message}`);
    process.exit(1);
  }
};
  // EVENTO DE CONEXION

  mongoose.connection.on('disconnected', () => {
    console.log('MongoDB disconnected');
    });

mongoose.connection.on('error', () => {
    console.log('MongoDB connection error');
    });

// cerrar conexion al terminar la app

process.on('SIGINT', async () => {
    await mongoose.connection.close();
    console.log('MongoDB disconnected through app termination');
    process.exit(0);
    });
module.exports = connectDB;
