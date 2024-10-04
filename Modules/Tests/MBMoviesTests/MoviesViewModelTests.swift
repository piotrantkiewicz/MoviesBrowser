import XCTest
import Swinject

@testable import MBMovies

class MoviesCoordinatorMock: MoviesCoordinator {
    func showMovieDetail(for movie: Movie) {}
    
    func start() {}
}

class MoviesViewModelTests: XCTestCase {
    
    private var viewModel: MoviesViewModel!
    private var container: Container!
    private var coordinator: MoviesCoordinatorMock!
    
    override func setUp() {
        super.setUp()
        container = Container()
        container.register(MoviesService.self) { _ in
            MoviesServiceFake()
        }
        coordinator = MoviesCoordinatorMock()
        viewModel = MoviesViewModel(
            container: container,
            coordinator: coordinator
        )
    }
    
    func test_whenSearch_thenShouldFilterResults() async throws {
        //given
        let query = "bor"
        try await viewModel.fetchPopularMovies()
        //when
        viewModel.search(with: query)
        //then
        XCTAssertEqual(viewModel.movies.keys.count, 1)
        XCTAssertEqual(viewModel.movies[MoviesStrings.moviesSection.rawValue]!.count, 1)
        XCTAssertEqual(viewModel.movies[MoviesStrings.moviesSection.rawValue]!.map { $0.title }, [
            "Borderlands"
        ])
    }
    
    func test_whenSearchAndCancel_thenShouldShowAllContacts() async throws {
        //given
        try await viewModel.fetchPopularMovies()
        //when
        viewModel.search(with: "")
        //then
        XCTAssertEqual(viewModel.movies["A"]!.count, 4)
        XCTAssertEqual(viewModel.moviesSource.count, 6)
    }
}
