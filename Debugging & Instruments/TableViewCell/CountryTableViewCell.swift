import UIKit

class CountryTableViewCell: UITableViewCell {
    // MARK: - Properties
    let countryFlagImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.contentMode = .scaleAspectFit
        //    imageView.layer.masksToBounds = true
        return image
    }()
    
    private let countryNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Title"
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
    }
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "CountryTableViewCell")
        
        backgroundColor = .white
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 20
        
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        contentView.addSubview(countryFlagImageView)
        contentView.addSubview(countryNameLabel)
        contentView.addSubview(chevronImageView)

        countryFlagImageView.translatesAutoresizingMaskIntoConstraints = false
        countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countryFlagImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            countryFlagImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            countryFlagImageView.heightAnchor.constraint(equalToConstant: 20),
            countryFlagImageView.widthAnchor.constraint(equalToConstant: 30),
            
            countryNameLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -10),
            countryNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper functions
    func configureCell(with countryName: String, imageUrl: String?) {
        countryNameLabel.text = countryName
        
        if let imageUrlString = imageUrl, let imageUrl = URL(string: imageUrlString) {
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.countryFlagImageView.image = UIImage(data: data)
                    }
                } else {
                    print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                }
            }.resume()
        } else {
            self.countryFlagImageView.image = UIImage(named: "placeholderImage")
        }
        
    }
    
}

#Preview {
    ViewController()
}
