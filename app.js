import express from 'express';
import cors from 'cors';

import db from './database/db.js';
import filmListRouter from './routes/FilmList.routes.js';

const app = express();
app.use( cors() );
app.use( express.json() );
app.use('/films', filmListRouter);

try {
    await db.authenticate();
    console.log('Conectado a la Base de datos');
} catch (error) {
    console.log('Error de conexión');
}

app.get('/', (req,res) => {
    res.send('Hola mundo')
});

app.listen(8000, () => {
    console.log('Server running in http://localhost:8000/');
})