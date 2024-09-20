//import Foundation
//
//protocol MoviesService {
//    func fetchPopularMovies() async throws -> [MovieDTO]
//    func searchMovies(query: String) async throws -> [MovieDTO]
//}
//
//class MoviesServiceLive: MoviesService {
//    
//    private let accessToken: String
//    private let networkService: NetworkService
//
//    init(
//        accessToken: String,
//        networkService: NetworkService
//    ) {
//        self.accessToken = accessToken
//        self.networkService = networkService
//    }
//    
//    func fetchPopularMovies() async throws -> [MovieDTO] {
//        let moviesResponse: MoviesResponseDTO = try await networkService.fetch(path: "/movie/popular")
//        
//        return moviesResponse.results.map {
//            $0.toDomain()
//        }
//    }
//    
//    func searchMovies(query: String) async throws -> [MovieDTO] {
//        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//        
//        let queryItem = URLQueryItem(name: "query", value: encodedQuery)
//        
//        let moviesResponse: MoviesResponseDTO = try await networkService.fetch(path: "/search/movie", queryItems: [queryItem])
//        
//        return moviesResponse.results
//    }
//    
//    func fetchMovieDetails(id: Int) async throws -> MovieDetail {
//        try await networkService.fetch(path: "/movie/\(id)")
//    }
//}
