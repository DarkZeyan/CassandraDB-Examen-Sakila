import Pagination from 'react-bootstrap/Pagination'
import { useEffect, useState } from "react"


function App() {

  const [films, setFilms] = useState([]);
  const [currentPage, setCurrentPage] = useState(1);
  const filmsPerPage = 10;
  const [startPage, setStartPage] = useState(1);
  const pagesToShow = 5;


  const fetchFilms = () => {
    fetch("http://localhost:8000/films")
      .then((response) => response.json())
      .then((data) => setFilms(data.reverse()));
  };

  useEffect(fetchFilms, []);

  const renderFilms = (films) => {
    if (films) {
      return (
        films.slice((currentPage - 1) * filmsPerPage, currentPage * filmsPerPage).map((film) => (
          <tr key={film.id}>
            <td className="table-dark">{film.title}</td>
            <td className="table-dark">{film.description}</td>
            <td className="table-dark">{film.language}</td>
            <td className="table-dark">{film.original_language}</td>
            <td className="table-dark">{film.rental_duration}</td>
            <td className="table-dark">{film.rental_rate}</td>
            <td className="table-dark">{film.length} minutos</td>
            <td className="table-dark">{film.replacement_cost}</td>
            <td className="table-dark">{film.rating}</td>
            <td className="table-dark">{film.special_features}</td>
          </tr>
        ))
      )
    }
  }


  const totalPages = Math.ceil(films.length / filmsPerPage);


  let items = [];
  for (let number = startPage; number < startPage + pagesToShow; number++) {
    if (number > totalPages) {
      break;
    }

    items.push(
      <Pagination.Item key={number} active={number === currentPage} onClick={() => setCurrentPage(number)}>
        {number}
      </Pagination.Item>,
    );
  }

  const nextPage = () => {
    if (startPage + pagesToShow < totalPages) {
      setStartPage(startPage + pagesToShow);
    }
  };

  const prevPage = () => {
    if (startPage !== 1) {
      setStartPage(startPage - pagesToShow);
    }
  };



  return (
    <>
      <div style={{ height: "100vh", overflowX: false }}>

        <div className='d-flex justify-content-center row mt-5'>
          <h1 className='text-center'>Consumo de base de datos CassandraVideo</h1>
        </div>

        <div className='row d-flex justify-content-center m-5'>
          <div className="col-12">
            <table className="table table-dark table-striped table-bordered">
              <thead className="thead-dark">
                <tr>
                  <th className="text-center" scope="col">Titulo</th>
                  <th className="text-center" scope="col">Descripcion</th>
                  <th className="text-center" scope="col">Idioma</th>
                  <th className="text-center" scope="col">Idioma Original</th>
                  <th className="text-center" scope="col">Duracion de Alquiler</th>
                  <th className="text-center" scope="col">Tarifa de Alquiler</th>
                  <th className="text-center" scope="col">Duracion</th>
                  <th className="text-center" scope="col">Costo de Reemplazo</th>
                  <th className="text-center" scope="col">Clasificacion</th>
                  <th className="text-center" scope="col">Caracteristicas Especiales</th>
                </tr>
              </thead>
              <tbody>
                {renderFilms(films)}
              </tbody>
            </table>
          </div>

          <div className='d-flex justify-content-center'>
            <div className="row">
              <div className="col">
                <Pagination>
                  <Pagination.Prev onClick={prevPage} />
                  {items}
                  <Pagination.Next onClick={nextPage} />
                </Pagination>
              </div>
              <div className="col">
                <button onClick={fetchFilms} className="btn btn-primary">
                  Refrescar datos
                </button>
              </div>
            </div>
          </div>


        </div>
      </div>
    </>
  )
}

export default App