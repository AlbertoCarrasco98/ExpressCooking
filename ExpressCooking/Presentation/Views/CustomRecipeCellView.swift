import UIKit

class CustomRecipeCellView: UIView {

    private let mainStackView = UIStackView()
    private let imageStackView = UIStackView()
    private let recipeImage = UIImageView()
    private let detailStackView = UIStackView()
    private let titleLabel = UILabel()
    private let cookTimeLabel = UILabel()
    private let cuisineLabel = UILabel()
    private let difficultyLabel = UILabel()
    private let spacer = UIView()

    weak var delegate: CustomViewDelegate?
    var task: URLSessionDataTask?

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setRecipeData(recipe: Recipe) {
        titleLabel.text = recipe.name
        cookTimeLabel.text = "Cook time: \(String(recipe.cookTimeMinutes)) min"
        cuisineLabel.text = recipe.cuisine
        difficultyLabel.text = recipe.difficulty
        recipeImage.loadFrom(URLAdress: recipe.image) {
        }
    }

    private func loadImage(from url: String) {
        task?.cancel()
        recipeImage.loadFrom(URLAdress: url) {
        }
    }

    func cancelImagenLoading() {
        recipeImage.image = nil
        task?.cancel()
        task = nil
    }

    private func setupViews() {
        backgroundColor = .systemGray6
        heightAnchor.constraint(equalToConstant: 90).isActive = true
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        layer.cornerRadius = 30
        layer.borderWidth = 2
        layer.borderColor = CGColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
        configureMainStackView()
        configureImageStackView()
        configureRecipeImage()
        configureSpacer()
        configureDetailStackView()
        configureTitleLabel()
        configureCookTimeLabel()
        configureCuisineLabel()
        configureDifficultyLabel()
    }

    private func configureMainStackView() {
        self.addSubview(mainStackView)
        mainStackView.addArrangedSubview(imageStackView)
        mainStackView.addArrangedSubview(spacer)
        mainStackView.addArrangedSubview(detailStackView)
        fill(with: mainStackView)

        mainStackView.heightAnchor.constraint(equalToConstant: 70).isActive = true

        mainStackView.distribution = .fillProportionally
        mainStackView.axis = .horizontal
        mainStackView.layer.cornerRadius = 25
        mainStackView.layer.masksToBounds = true
    }

    private func configureImageStackView() {
        imageStackView.addArrangedSubview(recipeImage)
        imageStackView.distribution = .fillProportionally
        imageStackView.widthAnchor.constraint(equalToConstant: 90).isActive = true
    }

    private func configureRecipeImage() {
        recipeImage.layer.cornerRadius = 30
        recipeImage.layer.masksToBounds = true
    }

    private func configureDetailStackView() {
        detailStackView.addArrangedSubview(titleLabel)
        detailStackView.addArrangedSubview(cookTimeLabel)
        detailStackView.addArrangedSubview(cuisineLabel)
        detailStackView.addArrangedSubview(difficultyLabel)

        detailStackView.distribution = .fillProportionally
        detailStackView.axis = .vertical
    }

    private func configureTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .boldSystemFont(ofSize: 15)
        titleLabel.textAlignment = .left
    }

    private func configureCookTimeLabel() {
        cookTimeLabel.font = .systemFont(ofSize: 12)
        cookTimeLabel.textAlignment = .left
    }

    private func configureCuisineLabel() {
        cuisineLabel.font = .systemFont(ofSize: 12)
        cuisineLabel.textAlignment = .left
    }

    private func configureDifficultyLabel() {
        difficultyLabel.font = .systemFont(ofSize: 12)
        difficultyLabel.textAlignment = .left
    }

    private func configureSpacer() {
        spacer.widthAnchor.constraint(equalToConstant: 15).isActive = true
    }
}
