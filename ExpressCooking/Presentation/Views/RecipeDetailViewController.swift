import UIKit

class RecipeDetailViewController: UIViewController {
    
    var recipe: Recipe?
    
    private let mainStackView = UIStackView()
    private let imageStackView = UIStackView()
    private let textView = UITextView()
    private let recipeImage = UIImageView()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = recipe?.name
        view.backgroundColor = .systemBackground
        configureMainStackView()
        configureImageStackView()
        configureRecipeImage()
        configureTableView()
    }
    
    //     Configure MainStackView
    
    private func configureMainStackView() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(imageStackView)
        mainStackView.addArrangedSubview(tableView)
        //        mainStackView.addArrangedSubview(textView)
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.backgroundColor = .clear
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 24),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor)
        ])
    }
    
    //    Configure ImageStackView
    
    private func configureImageStackView() {
        imageStackView.addArrangedSubview(recipeImage)
        imageStackView.backgroundColor = .clear
        imageStackView.layer.cornerRadius = 20
        imageStackView.layer.masksToBounds = true
        imageStackView.layer.borderWidth = 1.5
        imageStackView.layer.borderColor = UIColor.systemGray6.cgColor
        imageStackView.heightAnchor.constraint(equalToConstant: 280).isActive = true
    }
    
    //     Configure RecipeImage
    
    private func configureRecipeImage() {
        guard let stringImage = recipe?.image else { return }
        recipeImage.loadFrom(URLAdress: stringImage,
                             completion: { })
    }
    
    //     Configure TableView
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self,
                                      forCellReuseIdentifier: "Cell")
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// UITableViewDataSource

extension RecipeDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipe = recipe else { return 0 }
        //        return recipe.ingredients.count
        switch section {
            case 0:
                return recipe.ingredients.count
            case 1:
                return recipe.instructions.count
            default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                                  for: indexPath)
        
        switch indexPath.section {
            case 0:
                cell.textLabel?.text = recipe?.ingredients[indexPath.row]
            case 1:
                cell.textLabel?.text = recipe?.instructions[indexPath.row]
            default:
                return UITableViewCell()
        }
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0:
                return "Ingredients"
            case 1:
                return "Instructions"
            default:
                return nil
        }
    }
}

// UITableViewDelegate

extension RecipeDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath,
                                         animated: true)
    }
}
