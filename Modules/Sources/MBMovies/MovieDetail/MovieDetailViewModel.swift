import UIKit
import Swinject

public class MovieDetailViewModel {
    
    let movie: Movie
    var movieDetail: MovieDetail?
    
    private let coordinator: MovieDetailCoordinator
    private let container: Container
    private var repository: MoviesService {
        container.resolve(MoviesService.self)!
    }
    
    public init(
        movie: Movie,
        coordinator: MovieDetailCoordinator,
        container: Container
    ) {
        self.movie = movie
        self.coordinator = coordinator
        self.container = container
    }
    
    func fetchMovieDetail() async throws {
        movieDetail = try await repository.fetchMovieDetails(id: movie.id)
    }
}
