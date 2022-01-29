/*
Created by Vinay Devdikar on 22/01/22.
 
Abstract:
Custom cell for List Item
*/

import UIKit

class ListItemTableViewCell: UITableViewCell {
    private var itemView: ItemView!
    private var bottomConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if itemView != nil {
            itemView.updateStyling(isSelected: selected)
        }
    }
    
    func update(viewModel: ViewModel, isLastCell: Bool = false) {
        if itemView == nil {
            itemView = ItemView(viewModel: viewModel)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            let bottomConstant = isLastCell ? Theme.dimension.baseUnit * 2.0 : 0
            contentView.addSubview(itemView)
            bottomConstraint = itemView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                                constant: bottomConstant)
            NSLayoutConstraint.activate([
                itemView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                              constant: Theme.dimension.padding),
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                  constant: Theme.dimension.padding),
                bottomConstraint,
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                   constant: -Theme.dimension.padding),
            ])
        }else {
            itemView.viewModel = viewModel
            bottomConstraint.constant = isLastCell ? -Theme.dimension.baseUnit * 2.0 : 0.0
        }
       
        backgroundColor = .clear
    }
    
    
    func updateImage(with updatedImage: UIImage) {
        if itemView != nil {
            itemView.updateImage(with: updatedImage)
        }
    }
}

class ItemView: UIView {
    private lazy var contentStackView: UIStackView = {
        let contentStackView = UIStackView()
        contentStackView.axis = .vertical
        contentStackView.alignment = .fill
        contentStackView.distribution = .fill
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        return contentStackView
    }()
    
    private lazy var labelStackView: UIStackView = {
        let contentStackView = UIStackView()
        contentStackView.axis = .vertical
        contentStackView.alignment = .fill
        contentStackView.distribution = .fill
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        return contentStackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isAccessibilityElement = false
        imageView.clipsToBounds = false
        return imageView
    }()
    
    private lazy var headlinelbl: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var messagelbl: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var prelbl: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var viewModel: ViewModel {
        didSet {
            applyViewModel()
        }
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViews()
        applyViewModel()
        updateStyling()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateStyling(isSelected: Bool) {
        if isSelected {
            layer.borderWidth = 1.5
            layer.borderColor = Theme.colors.borderColor.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 0)
            layer.shadowOpacity = 0
        }else {
            layer.borderWidth = 0.0
            layer.borderColor = UIColor.clear.cgColor
            layer.masksToBounds = false
            layer.shadowOffset = CGSize(width: 0,
                                              height: 5)
            layer.shadowRadius = 2.0
            layer.shadowOpacity = 0.3
            layer.shadowColor = UIColor.gray.cgColor
        }
    }
    
    func updateImage(with updatedImage: UIImage) {
        imageView.image = updatedImage
    }
    
    
    private func applyViewModel() {
        headlinelbl.text = viewModel.title
        messagelbl.text = viewModel.message
        prelbl.text = "\(viewModel.prepTime) Min"
    }
    
   
    private func updateStyling() {
        headlinelbl.textColor = Theme.colors.textColor
        messagelbl.textColor =  Theme.colors.textColor
        prelbl.textColor = Theme.colors.textColor
        backgroundColor = .white
        
        contentStackView.setCustomSpacing(Theme.dimension.baseUnit, after: imageView)
        labelStackView.setCustomSpacing(Theme.dimension.baseUnit, after: headlinelbl)
        labelStackView.setCustomSpacing(Theme.dimension.baseUnit * 2.0, after: messagelbl)
        
        headlinelbl.font = UIFont.preferredFont(forTextStyle: .headline)
        messagelbl.font = UIFont.preferredFont(forTextStyle: .body)
        prelbl.font = UIFont.boldSystemFont(ofSize: 15.0)
        
        layer.cornerRadius = Theme.dimension.baseUnit * 2.0
        //updateViewShadow()
       
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Theme.dimension.cornerRadius
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

extension ItemView {
    
    private func setupViews() {
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(imageView)
        contentStackView.addArrangedSubview(labelStackView)
        labelStackView.addArrangedSubview(headlinelbl)
        labelStackView.addArrangedSubview(messagelbl)
        labelStackView.addArrangedSubview(prelbl)
        
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -Theme.dimension.baseUnit * 2.0),
            imageView.heightAnchor.constraint(equalToConstant: 200.0)
        ])
        
        labelStackView.layoutMargins = UIEdgeInsets(top: 0,
                                                    left: Theme.dimension.baseUnit * 2.0,
                                                    bottom: 0,
                                                    right: Theme.dimension.baseUnit * 2.0)
        labelStackView.isLayoutMarginsRelativeArrangement = true
    }
    
}


struct ViewModel {
    let title: String
    let message: String
    let image: UIImage
    let prepTime: Int
    
    init(title: String, message: String, image: UIImage, prepTime: Int) {
        self.title = title
        self.message = message
        self.image = image
        self.prepTime = prepTime
    }
}
