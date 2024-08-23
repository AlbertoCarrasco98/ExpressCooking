import UIKit

class RecipeListViewController: UIViewController, RecipeAPIServiceDelegate {
    func showRecipesList(list: [Recipe]) {
        recipesList = list
        reloadTableView()
    }
    
    //    Properties
    
    private let mainStackView = UIStackView()
    private let tableView = UITableView()
    
    private let apiService = APIService()
    private var recipesList: [Recipe] = []
    
    //    SetupUI
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print(recipesList)
    }
    
    private func setupUI() {
        title = "Recipes"
        configureMainStackView()
        configureTableView()
        apiService.delegate = self
        apiService.getRecipes()
    }
    
    //     Configure mainStackView
    
    private func configureMainStackView() {
        view.addSubview(mainStackView)
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fillEqually
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor)
        ])
    }
    
    
    //     Configure tableView
    
    private func configureTableView() {
        mainStackView.addArrangedSubview(tableView)
        tableView.register(CustomRecipeListCell.self,
                           forCellReuseIdentifier: "CustomCell")
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// UITableViewDataSource

extension RecipeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell",
                                                       for: indexPath) as? CustomRecipeListCell else {
            return UITableViewCell()
        }
        
        let recipe = recipesList[indexPath.row]
        cell.configureCell(with: recipe)
        return cell
    }
}

// UITableViewDelegate

extension RecipeListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeDetailVC = RecipeDetailViewController()
        recipeDetailVC.recipe = recipesList[indexPath.row]
        self.navigationController?.pushViewController(recipeDetailVC,
                                                      animated: true)
        tableView.deselectRow(at: indexPath,
                              animated: true)
    }
}
