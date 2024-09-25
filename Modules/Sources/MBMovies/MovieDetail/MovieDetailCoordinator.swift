import UIKit
import Swinject
import MBCore

public protocol MovieDetailCoordinator: Coordinator {
    func presentMovieDetail()
}

public final class MovieDetailCoordinatorLive: MovieDetailCoordinator {
    private let navigationController: UINavigationController
    private let container: Container
    private let movie: Movie
    
    public init(
        navigationController: UINavigationController,
        container: Container,
        movie: Movie
    ) {
        self.navigationController = navigationController
        self.container = container
        self.movie = movie
    }
    
    public func start() {
        let viewModel = MovieDetailViewModel(
            movie: movie,
            coordinator: self,
            container: container
        )
        let controller = MovieDetailViewController()
        controller.viewModel = viewModel
        navigationController.pushViewController(controller, animated: true)
    }
    
    public func presentMovieDetail() {
        let coordinator = MovieDetailCoordinatorLive(
            navigationController: navigationController,
            container: container,
            movie: movie
        )
        coordinator.start()
    }
}
