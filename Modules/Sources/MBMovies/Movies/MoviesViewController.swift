import UIKit
import SDWebImage
import SnapKit
import MBCore

enum MoviesStrings: String {
    case moviesSection = "Movies"
}

public class MoviesViewController: UIViewController {
    
    private lazy var searchController: UISearchController = {
        UISearchController(searchResultsController: nil)
    }()
    
    private weak var tableView: UITableView!
    
    public var viewModel: MoviesViewModel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMovies()
    }
    
    private func configureTableView() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
    }
    
    private func loadMovies() {
        Task {
            try await viewModel.fetchPopularMovies()
            Task { @MainActor in
                tableView.reloadData()
            }
        }
    }
}

extension MoviesViewController {
    
    private func setupUI() {
        view.backgroundColor = .white
        setupNavigationTitle()
        setupTableView()
        setupSearchController()
    }
    
    private func setupNavigationTitle() {
        title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .black
        
        navigationItem.searchController = searchController
    }
    
    private func setupTableView() {
        let tableView = UITableView()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.tableView = tableView
    }
}

extension MoviesViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        viewModel.search(with: searchText)
        tableView.reloadData()
    }
}

extension MoviesViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sectionTitles.count
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = viewModel.sectionTitles[section]
        return viewModel.movies[key]?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell
        else {
            return UITableViewCell()
        }
        
        let key = viewModel.sectionTitles[indexPath.section]
        let movie = viewModel.movies[key]![indexPath.row]
        
        cell.configure(with: movie)
        
        return cell
    }
}

extension MoviesViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = viewModel.sectionTitles[indexPath.section]
        let movie = viewModel.movies[key]![indexPath.row]
        
        presentMovieDetail(movie: movie)
    }
    
    private func presentMovieDetail(movie: Movie) {
        let controller = MovieDetailViewController()
        controller.viewModel = MovieDetailViewModel(movie: movie, moviesService: viewModel.moviesService)
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
}
