import UIKit

public class MoviesViewModel {
    
    var movies: [Movie] = []
    
    let moviesService: MoviesService
    
    public init(moviesService: MoviesService) {
        self.moviesService = moviesService
    }
    
    func fetchPopularMovies() async {
        do {
            let fetchedMovies = try await moviesService.fetchPopularMovies()
            
            DispatchQueue.main.async {
                self.movies = fetchedMovies
            }
        } catch {
            print("Error fetching movies: \(error)")
        }
    }
}
