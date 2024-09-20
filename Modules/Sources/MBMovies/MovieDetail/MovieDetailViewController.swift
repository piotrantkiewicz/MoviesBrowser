import UIKit
import SDWebImage
import SnapKit
import MBCore

public class MovieDetailViewController: UIViewController {
    
    private weak var tableView: UITableView!
    
    public var viewModel: MovieDetailViewModel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(MovieDetailCell.self, forCellReuseIdentifier: MovieDetailCell.identifier)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Task {
            do {
                try await viewModel.fetchMovieDetail()
                Task { @MainActor in
                    tableView.reloadData()
                }
            } catch {
                print("Error fetching movie details: \(error)")
            }
        }
    }
}

extension MovieDetailViewController {
    
    private func setupUI() {
        view.backgroundColor = .white
        setupNavigationTitle()
        setupTableView()
    }
    
    private func setupNavigationTitle() {
        title = "Movie Detail"
        navigationController?.navigationBar.prefersLargeTitles = true
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

extension MovieDetailViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieDetail == nil ? 0 : 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailCell.identifier, for: indexPath) as? MovieDetailCell
        else {
            return UITableViewCell()
        }
        
        if let movieDetail = viewModel.movieDetail {
            cell.configure(with: movieDetail)
        }
        
        return cell
    }
}
