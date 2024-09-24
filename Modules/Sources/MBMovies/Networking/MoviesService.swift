import Foundation

public protocol MoviesService {
    func fetchPopularMovies() async throws -> [Movie]
    func searchMovies(query: String) async throws -> [Movie]
    func fetchMovieDetails(id: Int) async throws -> MovieDetail
}

public class MoviesServiceLive: MoviesService {
    
    private let accessToken: String
    private let networkService: NetworkService

    public init(
        accessToken: String,
        networkService: NetworkService
    ) {
        self.accessToken = accessToken
        self.networkService = networkService
    }
    
    public func fetchPopularMovies() async throws -> [Movie] {
        let moviesResponse: MoviesResponse = try await networkService.fetch(path: "/movie/popular")
        
        return moviesResponse.results.map {
            $0.toDomain()
        }
    }
    
    public func searchMovies(query: String) async throws -> [Movie] {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let queryItem = URLQueryItem(name: "query", value: encodedQuery)
        
        let moviesResponse: MoviesResponse = try await networkService.fetch(path: "/search/movie", queryItems: [queryItem])
        
        return moviesResponse.results.map {
            $0.toDomain()
        }
    }
    
    public func fetchMovieDetails(id: Int) async throws -> MovieDetail {
        try await networkService.fetch(path: "/movie/\(id)")
    }
}
