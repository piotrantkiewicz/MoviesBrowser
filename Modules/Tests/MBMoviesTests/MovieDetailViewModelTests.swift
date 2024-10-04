import XCTest
import Swinject

@testable import MBMovies

class MovieDetailCoordinatorMock: MovieDetailCoordinator {
    func presentMovieDetail() {}
    
    func start() {}
}

class MovieDetailViewModelTests: XCTestCase {
    
    private var viewModel: MovieDetailViewModel!
    private var movie: Movie = Movie(
        id: 519182,
        title: "Despicable Me 4",
        posterPath: "/gUREuXCnJLVHsvKXDH9fgIcfM6e.jpg",
        releaseDate: "2024-01-01"
    )
    private var container: Container!
    private var coordinator: MovieDetailCoordinatorMock!
    
    override func setUp() {
        super.setUp()
        container = Container()
        container.register(MoviesService.self) { _ in
            MoviesServiceFake()
        }
        coordinator = MovieDetailCoordinatorMock()
        viewModel = MovieDetailViewModel(
            movie: movie,
            coordinator: coordinator,
            container: container
        )
    }
    
    func test_whenFetchMovieDetailSucceeds_thenShouldPresentMovieDetail() async throws {
        //when
        try await viewModel.fetchMovieDetail()
        //then
        XCTAssertEqual(viewModel.movieDetail?.id, 519182)
        XCTAssertEqual(viewModel.movieDetail?.title, "Despicable Me 4")
        XCTAssertEqual(viewModel.movieDetail?.overview, "Gru and Lucy and their girls—Margo, Edith and Agnes—welcome a new member to the Gru family, Gru Jr., who is intent on tormenting his dad. Gru also faces a new nemesis in Maxime Le Mal and his femme fatale girlfriend Valentina, forcing the family to go on the run.")
        XCTAssertEqual(viewModel.movieDetail?.posterPath, "/wWba3TaojhK7NdycRhoQpsG0FaH.jpg")
        XCTAssertEqual(viewModel.movieDetail?.releaseDate, "2024-01-01")
        XCTAssertEqual(viewModel.movieDetail?.voteAverage, 5)
    }
}
