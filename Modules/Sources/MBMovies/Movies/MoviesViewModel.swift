import UIKit

public class MoviesViewModel {
    
    private var moviesSource: [Movie] = []
    var movies: [String: [Movie]] = [:]
    var sectionTitles: [String] = []
    
    let moviesService: MoviesService
    
    public init(moviesService: MoviesService) {
        self.moviesService = moviesService
    }
    
    func fetchPopularMovies() async throws {
        moviesSource = try await moviesService.fetchPopularMovies()
        updateMovies(with: moviesSource)
    }
    
    func search(with query: String) {
        guard !query.isEmpty else {
            updateMovies(with: moviesSource)
            return
        }

        let searchResults = moviesSource.filter {
            $0.title.lowercased().contains(query.lowercased())
        }
        
        didCompleteSearch(with: searchResults)
    }
    
    private func didCompleteSearch(with results: [Movie]) {
        self.movies = [
            MoviesStrings.moviesSection.rawValue: results
        ]
        
        sectionTitles = self.movies.keys.sorted()
    }
    
    private func updateMovies(with movies: [Movie]) {
        self.movies = Dictionary(grouping: movies, by: { $0.title.first.map { String($0) } ?? "A" })
        sectionTitles = self.movies.keys.sorted()
    }
}
