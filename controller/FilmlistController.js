import FilmListModel from "../models/FilmListModel.js";

export const getAllFilms = async (req, res) => {
    try {
        const films = await FilmListModel.findAll({
            attributes: { exclude: ['id', 'createdt', 'updatedAt'] }
        });
        res.json(films);
    } catch (error) {
        res.json({ message: error.message });
    }
}

export const getFilm = async (req, res) => {
    try {
        const film = await FilmListModel.findAll({
            attributes: { exclude: ['id', 'createdAt', 'updatedAt'] },
            where: {film_id: req.params.id}
        });
        res.json(film);
    } catch (error) {
        res.json({ message: error.message });
    }
}

export const createFilm = async (req, res) => {
    try {
        await FilmListModel.create(req.body);
        res.json({ "message": "Registro creado exitosamente" });
    } catch (error) {
        res.json({ message: error.message });
    }
}

export const updateFilm = async (req, res) => {
    try {
        await FilmListModel.update(req.body, {
            attributes: { exclude: ['id', 'createdAt', 'updatedAt'] },
            where: {id: req.params.id}
        });
        res.json({ "message": "Registro actualizado exitosamente" });
    } catch (error) {
        res.json({ message: error.message });
    }
}

