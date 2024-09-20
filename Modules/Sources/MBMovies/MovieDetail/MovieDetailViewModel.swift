import UIKit

public class MovieDetailViewModel {
    
    let movie: Movie
    var movieDetail: MovieDetail?
    
    private let moviesService: MoviesService
    
    public init(
        movie: Movie,
        moviesService: MoviesService
    ) {
        self.movie = movie
        self.moviesService = moviesService
    }
    
    func fetchMovieDetail() async throws {
        movieDetail = try await moviesService.fetchMovieDetails(id: movie.id)
    }
}
