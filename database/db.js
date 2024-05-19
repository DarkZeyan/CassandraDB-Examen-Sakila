import {Sequelize} from 'sequelize'

const db = new Sequelize('cassandravideo', 'admin', 'admin', {
    host: 'localhost',
    dialect: 'mysql',
    
});

export default db;