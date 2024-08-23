struct Recipe: Decodable {
    let id: Int
    let name: String
    let ingredients: [String]
    let instructions: [String]
    let cookTimeMinutes: Int
    let difficulty: String
    let cuisine: String
    let image: String
}

struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}
