import Foundation

public class TMDBNetworkConfig: NetworkConfig {
    public let baseUrl: URL = URL(string: "https://api.themoviedb.org/3")!
    public var headers: [String: String] {
        [
            "Authorization": "Bearer \(accessToken)",
            "accept": "application/json"
        ]
    }
    
    private let accessToken: String
    
    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}
