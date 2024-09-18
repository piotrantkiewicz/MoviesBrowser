import Foundation

public struct MovieDTO: Codable {
    public let id: Int
    public let title: String
    public let posterPath: String?
    public let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
    
    public init(
        id: Int,
        title: String,
        posterPath: String?,
        releaseDate: String
    ) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.releaseDate = releaseDate
    }
    
    public func toDomain() -> MovieDTO {
        return MovieDTO(
            id: id,
            title: title,
            posterPath: posterPath,
            releaseDate: releaseDate
        )
    }
}
