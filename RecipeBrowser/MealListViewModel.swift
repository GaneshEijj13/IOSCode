import Foundation

@MainActor
class MealListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    
    func fetchMeals() async {
        do {
            let meals = try await NetworkManager.shared.fetchMeals(category: "Dessert")
            self.meals = meals.filter { !$0.strMeal.isEmpty }
        } catch {
            print("Error fetching meals: \(error)")
        }
    }
}
