//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Arief Ramadhan on 12/02/23.
//

import UIKit

class NewsTableViewCellViewModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String, subtitle: String, imageURL: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
}

class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        
        return label
    }()
    
    private let newsImageVIew: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemRed
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(newsImageVIew)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsTitleLabel.frame = CGRect(x: 5, y: 0, width: contentView.frame.size.width - 120, height: contentView.frame.size.height/2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: NewsTableViewCellViewModel){
        newsTitleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        //image
        if let data = viewModel.imageData {
            newsImageVIew.image = UIImage(data: data)
        }
        else {
            //fetch
        }
    }

}
