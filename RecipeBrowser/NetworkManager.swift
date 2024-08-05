import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://themealdb.com/api/json/v1/1/"
    
    private init() {}
    
    func fetchMeals(category: String) async throws -> [Meal] {
        let urlString = "\(baseURL)filter.php?c=\(category)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
        return mealResponse.meals.sorted { $0.strMeal < $1.strMeal }
    }
    
    
    func fetchMealDetail(id: String) async throws -> MealDetail {
        let urlString = "\(baseURL)lookup.php?i=\(id)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let mealDetailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
        
        guard let mealDetail = mealDetailResponse.meals.first else {
            throw URLError(.cannotParseResponse)
        }
        
        return mealDetail
    }
    
}
