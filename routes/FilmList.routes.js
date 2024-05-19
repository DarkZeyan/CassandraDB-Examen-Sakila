import express from 'express';
import { createFilm, getAllFilms, getFilm, updateFilm } from '../controller/FilmlistController.js';

const filmListRouter = express.Router();

// Rutas para acceder a los films
filmListRouter.get('/', getAllFilms);
filmListRouter.get('/:id', getFilm);

// Rutas para crear un film
filmListRouter.post('/', createFilm);

// Rutas para actualizar un film
filmListRouter.put('/:id', updateFilm);

export default filmListRouter;