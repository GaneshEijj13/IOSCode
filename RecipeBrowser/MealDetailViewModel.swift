import Foundation

@MainActor
class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    
    func fetchMealDetail(id: String) async {
        do {
            let mealDetail = try await NetworkManager.shared.fetchMealDetail(id: id)
            self.mealDetail = mealDetail
        } catch {
            print("Error fetching meal detail: \(error)")
        }
    }
}

