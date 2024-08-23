import Foundation

protocol RecipeAPIServiceDelegate: AnyObject {
    func showRecipesList(list: [Recipe])
}

class APIService {
    weak var delegate: RecipeAPIServiceDelegate?
    
    func getRecipes() {
        let urlString = "https://dummyjson.com/recipes"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    print("Error getting data from API:", error?.localizedDescription as Any)
                }
                if let secureData = data?.parseData(removeString: "null") {
                    if let recipesList = self.parseJSON(recipeData: secureData) {
                        print("Recipes list: ", recipesList)
                        DispatchQueue.main.async {
                            self.delegate?.showRecipesList(list: recipesList)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(recipeData: Data) -> [Recipe]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RecipeResponse.self,
                                                 from: recipeData)
            return decodedData.recipes
        } catch {
            print("Error decoding data: ", error.localizedDescription)
            return nil
        }
    }
}
