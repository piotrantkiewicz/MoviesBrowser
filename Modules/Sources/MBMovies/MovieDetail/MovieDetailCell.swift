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
        
        contentView.addSubview(view)
        
        self.containerView = view
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
        imageView.image = UIImage(resource: .movie)
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        stackView.addArrangedSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(300)
            make.width.equalTo(150)
        }
        
        self.movieImageView = imageView
    }
    
    private func setupLabels() {
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 2
        labelsStackView.alignment = .center
        
        
        let movieNameLbl = setupMovieNameLbl()
        labelsStackView.addArrangedSubview(movieNameLbl)
        self.movieNameLbl = movieNameLbl
        
        let releaseDateLbl = setupReleaseDateLbl()
        labelsStackView.addArrangedSubview(releaseDateLbl)
        self.releaseDateLbl = releaseDateLbl
        
        let voteAverageLbl = setupVoteAverage()
        labelsStackView.addArrangedSubview(voteAverageLbl)
        self.voteAverageLbl = voteAverageLbl
        
        let movieOverviewLbl = setupMovieOverview()
        labelsStackView.addArrangedSubview(movieOverviewLbl)
        self.movieOverviewLbl = movieOverviewLbl
        
        self.stackView.addArrangedSubview(labelsStackView)
    }
    
    private func setupMovieNameLbl() -> UILabel {
        let movieNameLbl = UILabel()
        movieNameLbl.text = "Deadpool & Wolverine"
        return movieNameLbl
    }
    
    private func setupReleaseDateLbl() -> UILabel {
        let releaseDateLbl = UILabel()
        releaseDateLbl.text = "2024-07-24"
        return releaseDateLbl
    }
    
    private func setupVoteAverage() -> UILabel {
        let voteAverageLbl = UILabel()
        voteAverageLbl.text = "7.73"
        return voteAverageLbl
    }
    
    private func setupMovieOverview() -> UILabel {
        let movieOverviewLbl = UILabel()
        movieOverviewLbl.text = "A listless Wade Wilson toils away in civilian life with his days as the morally flexible mercenary, Deadpool, behind him. But when his homeworld faces an existential threat, Wade must reluctantly suit-up again with an even more reluctant Wolverine."
        return movieOverviewLbl
    }
}
