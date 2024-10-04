import UIKit
import SnapKit
import DesignSystem

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
            movieImageView.sd_setImage(with: imageURL)
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
        view.backgroundColor = .background
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        
        contentView.addSubview(view)
        
        self.containerView = view
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.left.equalTo(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(145)
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
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupImageView() {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(105)
            make.width.equalTo(70)
        }
        
        self.movieImageView = imageView
    }
    
    private func setupLabels() {
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 2
        
        let movieNameLbl = setupMovieNameLbl()
        movieNameLbl.font = .title
        movieNameLbl.numberOfLines = 0
        labelsStackView.addArrangedSubview(movieNameLbl)
        self.movieNameLbl = movieNameLbl
        
        let releaseDateLbl = setupReleaseDateLbl()
        releaseDateLbl.font = .subtitle
        releaseDateLbl.textColor = .textGray
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
