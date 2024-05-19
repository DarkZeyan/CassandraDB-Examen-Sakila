CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_film`(IN `p_title` VARCHAR(255), IN `p_description` TEXT, IN `p_release_year` YEAR, IN `p_category_id`, IN `p_language_id` TINYINT, IN `p_rental_duration` TINYINT, IN `p_rental_rate` DECIMAL(4,2), IN `p_length` SMALLINT, IN `p_replacement_cost` DECIMAL(5,2), IN `p_rating` ENUM('G','PG','PG-13','R','NC-17'), IN `p_special_features` SET('Trailers','Commentaries','Deleted Scenes','Behind the Scenes'))
BEGIN
    DECLARE new_film_id INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Ocurrio un error, hacer el rollback.
        ROLLBACK;
    END;
        DECLARE EXIT HANDLER FOR SQLSTATE '23000'
    BEGIN
        -- Llave duplicada
        ROLLBACK;
    END;

    -- Insertar nueva película en la tabla film
    INSERT INTO film(title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating, special_features)
    VALUES(p_title, p_description, p_release_year, p_language_id, p_rental_duration, p_rental_rate, p_length, p_replacement_cost, p_rating, p_special_features);
    
    -- Obtener el ID de la nueva película insertada
    SET new_film_id = LAST_INSERT_ID();
    
    -- Actualizar la tabla inventory
    INSERT INTO inventory(film_id, store_id)
    SELECT new_film_id, store_id
    FROM store;
    
    -- Insertar en la tabla film_category (relación many-to-many)
    IF p_category_id IS NOT NULL THEN
        INSERT INTO film_category(film_id, category_id)
        VALUES(new_film_id, p_category_id);
    ELSE
        INSERT INTO film_category(film_id, category_id)
        VALUES(new_film_id, 1); -- Cambiar el valor de category_id según sea necesario
    END IF;
    -- Actualizar la tabla film_actor (relación many-to-many)
    INSERT INTO film_actor(film_id, actor_id)
    SELECT new_film_id, actor_id
    FROM actor
    ORDER BY RAND() LIMIT 3; -- Cambia el valor de LIMIT según sea necesario

    -- Confirmar la transacción
    COMMIT;
END