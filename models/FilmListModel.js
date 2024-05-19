import db from '../database/db.js';
import { DataTypes } from "sequelize";

const FilmListModel = db.define('vw_film_list', {
    film_id: {type: DataTypes.INTEGER},
    title: {type: DataTypes.STRING},
    description: {type: DataTypes.STRING},
    release_year: {type: DataTypes.DATE},
    language: {type: DataTypes.STRING},
    original_language: {type: DataTypes.STRING},
    rental_duration: {type: DataTypes.INTEGER},
    length: {type: DataTypes.INTEGER},
    replacement_cost: {type: DataTypes.DOUBLE},
    rating: {type: DataTypes.STRING},
    special_features: {type: DataTypes.STRING}
},{
    freezeTableName: true,
    underscored: true,
    tableName: 'vw_film_list'
}
)

export default FilmListModel;