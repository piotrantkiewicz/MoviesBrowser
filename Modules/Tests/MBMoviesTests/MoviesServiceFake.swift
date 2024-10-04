import UIKit
import MBMovies

public final class MoviesServiceFake: MoviesService {
    public func searchMovies(query: String) async throws -> [Movie] {
        [
            Movie(id: 519182, title: "Despicable Me 4", posterPath: "/gUREuXCnJLVHsvKXDH9fgIcfM6e.jpg", releaseDate: "2024-01-01"),
        ]
    }
    
    public func fetchMovieDetails(id: Int) async throws -> MovieDetail {
        MovieDetail(id: 519182, title: "Despicable Me 4", overview: "Gru and Lucy and their girls—Margo, Edith and Agnes—welcome a new member to the Gru family, Gru Jr., who is intent on tormenting his dad. Gru also faces a new nemesis in Maxime Le Mal and his femme fatale girlfriend Valentina, forcing the family to go on the run.", posterPath: "/wWba3TaojhK7NdycRhoQpsG0FaH.jpg", releaseDate: "2024-01-01", voteAverage: 5)
    }
    
    public init() {}
    
    public func fetchPopularMovies() async throws -> [Movie]  {
        [
            Movie(id: 123456, title: "Afraid", posterPath: "/gUREuXCnJLVHsvKXDH9fgIcfM6e.jpg", releaseDate: "2024-01-01"),
            Movie(id: 223456, title: "A Quiet Place: Day One", posterPath: "/gUREuXCnJLVHsvKXDH9fgIcfM6e.jpg", releaseDate: "2024-01-02"),
            Movie(id: 1023456, title: "A Nightmare", posterPath: "/gUREuXCnJLVHsvKXDH9fgIcfM6e.jpg", releaseDate: "2024-01-03"),
            Movie(id: 1223456, title: "A journey thorugh space", posterPath: "/gUREuXCnJLVHsvKXDH9fgIcfM6e.jpg", releaseDate: "2024-01-04"),
            Movie(id: 523456, title: "Borderlands", posterPath: "/gUREuXCnJLVHsvKXDH9fgIcfM6e.jpg", releaseDate: "2024-01-05"),
            Movie(id: 123456, title: "Despicable Me 4", posterPath: "/gUREuXCnJLVHsvKXDH9fgIcfM6e.jpg", releaseDate: "2024-01-06"),
        ]
    }
}
