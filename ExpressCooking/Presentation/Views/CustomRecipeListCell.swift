import UIKit

class CustomRecipeListCell: UITableViewCell {
    
    private let customView = CustomRecipeCellView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        customView.cancelImagenLoading()
    }
    
    private func setupView() {
        contentView.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            customView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: 12),
            contentView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: 8)
        ])        
    }
    
    func configureCell(with recipe: Recipe) {
        customView.setRecipeData(recipe: recipe)
    }
}
