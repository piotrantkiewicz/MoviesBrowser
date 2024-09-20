import UIKit
import SnapKit

class MovieCell: UITableViewCell {
    
    private var containerView: UIView!
    private var stackView: UIStackView!
    private var movieImageView: UIImageView!
    private var movieNameLbl: UILabel!
    private var releaseDateLbl: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    private func commonInit() {
        selectionStyle = .none
        
        setupUI()
    }
    
    func configure(with movie: Movie) {
        movieNameLbl.text = movie.title
        releaseDateLbl.text = movie.releaseDate
        
        if let posterPath = movie.posterPath {
            let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            movieImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(resource: .movie))
        }
    }
}

extension MovieCell {
 
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        setupContainer()
        setupStackView()
        setupImageView()
        setupLabels()
    }
    
    private func setupContainer() {
        let view = UIView()
        
        contentView.addSubview(view)
        
        self.containerView = view
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    private func setupStackView() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        
        containerView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func setupImageView() {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .movie)
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        stackView.addArrangedSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(50)
        }
        
        self.movieImageView = imageView
    }
    
    private func setupLabels() {
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 2
        
        let movieNameLbl = setupMovieNameLbl()
        labelsStackView.addArrangedSubview(movieNameLbl)
        self.movieNameLbl = movieNameLbl
        
        let releaseDateLbl = setupReleaseDateLbl()
        labelsStackView.addArrangedSubview(releaseDateLbl)
        self.releaseDateLbl = releaseDateLbl
        
        self.stackView.addArrangedSubview(labelsStackView)
    }
    
    private func setupMovieNameLbl() -> UILabel {
        let movieNameLbl = UILabel()
        return movieNameLbl
    }
    
    private func setupReleaseDateLbl() -> UILabel {
        let releaseDateLbl = UILabel()
        return releaseDateLbl
    }
}
