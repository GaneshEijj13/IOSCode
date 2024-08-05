import Foundation

struct Meal: Identifiable, Codable {
    var id: String { idMeal }
    let idMeal: String
    let strMeal: String
    let strMealThumb: String?
}

struct MealResponse: Codable {
    let meals: [Meal]
}

struct MealDetail: Identifiable, Decodable {
    let id: String
    let name: String
    let instructions: String
    let thumbnailURL: String?
    var ingredients: [Ingredient]
    
    struct Ingredient: Identifiable {
        let id = UUID()
        let name: String
        let measure: String
    }

    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strInstructions, strMealThumb
    }
    
    enum IngredientKeys: String, CodingKey {
        case ingredient1 = "strIngredient1", ingredient2 = "strIngredient2", ingredient3 = "strIngredient3",
             ingredient4 = "strIngredient4", ingredient5 = "strIngredient5", ingredient6 = "strIngredient6",
             ingredient7 = "strIngredient7", ingredient8 = "strIngredient8", ingredient9 = "strIngredient9",
             ingredient10 = "strIngredient10", ingredient11 = "strIngredient11", ingredient12 = "strIngredient12",
             ingredient13 = "strIngredient13", ingredient14 = "strIngredient14", ingredient15 = "strIngredient15",
             ingredient16 = "strIngredient16", ingredient17 = "strIngredient17", ingredient18 = "strIngredient18",
             ingredient19 = "strIngredient19", ingredient20 = "strIngredient20"
    }
    
    enum MeasureKeys: String, CodingKey {
        case measure1 = "strMeasure1", measure2 = "strMeasure2", measure3 = "strMeasure3",
             measure4 = "strMeasure4", measure5 = "strMeasure5", measure6 = "strMeasure6",
             measure7 = "strMeasure7", measure8 = "strMeasure8", measure9 = "strMeasure9",
             measure10 = "strMeasure10", measure11 = "strMeasure11", measure12 = "strMeasure12",
             measure13 = "strMeasure13", measure14 = "strMeasure14", measure15 = "strMeasure15",
             measure16 = "strMeasure16", measure17 = "strMeasure17", measure18 = "strMeasure18",
             measure19 = "strMeasure19", measure20 = "strMeasure20"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .idMeal)
        name = try container.decode(String.self, forKey: .strMeal)
        instructions = try container.decode(String.self, forKey: .strInstructions)
        thumbnailURL = try container.decodeIfPresent(String.self, forKey: .strMealThumb)
        
        var ingredients: [Ingredient] = []
        
        let ingredientContainer = try decoder.container(keyedBy: IngredientKeys.self)
        let measureContainer = try decoder.container(keyedBy: MeasureKeys.self)
        
        for index in 1...20 {
            let ingredientKey = IngredientKeys(stringValue: "strIngredient\(index)")!
            let measureKey = MeasureKeys(stringValue: "strMeasure\(index)")!
            
            if let ingredientName = try ingredientContainer.decodeIfPresent(String.self, forKey: ingredientKey),
               let measure = try measureContainer.decodeIfPresent(String.self, forKey: measureKey),
               !ingredientName.isEmpty,
               !measure.isEmpty {
                let ingredient = Ingredient(name: ingredientName, measure: measure)
                ingredients.append(ingredient)
            }
        }
        
        self.ingredients = ingredients
    }
}

struct MealDetailResponse: Decodable {
    let meals: [MealDetail]
}
