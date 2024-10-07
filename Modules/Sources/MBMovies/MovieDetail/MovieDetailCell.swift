import UIKit
import SnapKit

class MovieDetailCell: UITableViewCell {
    
    private var containerView: UIView!
    private var stackView: UIStackView!
    private var movieImageView: UIImageView!
    private var movieNameLbl: UILabel!
    private var releaseDateLbl: UILabel!
    private var movieOverviewLbl: UILabel!
    private var voteAverageLbl: UILabel!
    
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
    
    func configure(with movieDetail: MovieDetail) {
        movieNameLbl.text = movieDetail.title
        releaseDateLbl.text = movieDetail.releaseDate
        movieOverviewLbl.text = movieDetail.overview
        voteAverageLbl.text = String(format: "%.2f", movieDetail.voteAverage) + ("/10")
        
        
        if let posterPath = movieDetail.posterPath {
            let imageURL = URL(string: "https://image.tmdb.org/t/p/original\(posterPath)")
            movieImageView.sd_setImage(with: imageURL)
        }
    }
}

extension MovieDetailCell {
 
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
            make.top.equalTo(5)
            make.bottom.equalToSuperview().offset(-20)
            make.left.equalTo(20)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    private func setupStackView() {
        stackView = UIStackView()
        stackView.axis = .vertical
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
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(300)
            make.width.equalTo(200)
        }
        
        self.movieImageView = imageView
    }
    
    private func setupLabels() {
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 2
        
        let voteStackView = UIStackView()
        voteStackView.axis = .horizontal
        voteStackView.alignment = .center
        voteStackView.spacing = 5
        
        let starIcon = UIImageView()
        starIcon.image = UIImage(systemName: "star.circle.fill")
        starIcon.tintColor = .systemYellow
        voteStackView.addArrangedSubview(starIcon)
        
        starIcon.snp.makeConstraints { make in
            make.width.height.equalTo(25)
            make.bottom.equalToSuperview().inset(5)
        }
        
        let voteAverageLbl = setupVoteAverage()
        voteStackView.addArrangedSubview(voteAverageLbl)
        self.voteAverageLbl = voteAverageLbl
        
        labelsStackView.addArrangedSubview(voteStackView)
        
        let movieNameLbl = setupMovieNameLbl()
        labelsStackView.addArrangedSubview(movieNameLbl)
        self.movieNameLbl = movieNameLbl
        
        let releaseDateLbl = setupReleaseDateLbl()
        labelsStackView.addArrangedSubview(releaseDateLbl)
        self.releaseDateLbl = releaseDateLbl
        
        let spacerView = UIView()
        spacerView.snp.makeConstraints { make in
            make.height.equalTo(10)
        }
        labelsStackView.addArrangedSubview(spacerView)
        
        let movieOverviewLbl = setupMovieOverview()
        labelsStackView.addArrangedSubview(movieOverviewLbl)
        self.movieOverviewLbl = movieOverviewLbl
        
        self.stackView.addArrangedSubview(labelsStackView)
    }
    
    private func setupMovieNameLbl() -> UILabel {
        let movieNameLbl = UILabel()
        movieNameLbl.font = .title2
        movieNameLbl.numberOfLines = 0
        return movieNameLbl
    }
    
    private func setupReleaseDateLbl() -> UILabel {
        let releaseDateLbl = UILabel()
        releaseDateLbl.font = .subtitle
        releaseDateLbl.textColor = .textGray
        return releaseDateLbl
    }
    
    private func setupVoteAverage() -> UILabel {
        let voteAverageLbl = UILabel()
        voteAverageLbl.font = .subtitle2
        return voteAverageLbl
    }
    
    private func setupMovieOverview() -> UILabel {
        let movieOverviewLbl = UILabel()
        movieOverviewLbl.font = .description
        movieOverviewLbl.numberOfLines = 0
        return movieOverviewLbl
    }
}
