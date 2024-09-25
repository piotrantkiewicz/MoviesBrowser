import UIKit
import Swinject
import MBCore

public protocol MoviesCoordinator: Coordinator {
    func showMovieDetail(for movie: Movie)
}

public final class MoviesCoordinatorLive: MoviesCoordinator {
    
    private var navigationController: UINavigationController
    private let container: Container
    
    public var rootViewController: UIViewController!
    
    public init(
        navigationController: UINavigationController,
        container: Container
    ) {
        self.navigationController = navigationController
        self.container = container
    }
    
    public func start() {
        let viewModel = MoviesViewModel(
            container: container,
            coordinator: self
        )
        let controller = MoviesViewController()
        controller.viewModel = viewModel
        navigationController.setViewControllers([controller], animated: false)
        
        self.rootViewController = controller
    }
    
    public func showMovieDetail(for movie: Movie) {
        let coordinator = MovieDetailCoordinatorLive(
            navigationController: navigationController,
            container: container,
            movie: movie
        )
        coordinator.start()
    }
}
