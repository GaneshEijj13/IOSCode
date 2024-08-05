import SwiftUI

struct MealDetailView: View {
    let mealId: String
    @StateObject private var viewModel = MealDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let mealDetail = viewModel.mealDetail {
                    // Header Image
                    if let imageUrl = mealDetail.thumbnailURL, let url = URL(string: imageUrl) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 250)
                                .cornerRadius(15)
                                .clipped()
                                .overlay(
                                    Text(mealDetail.name)
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .shadow(radius: 10)
                                        .padding(),
                                    alignment: .bottomLeading
                                )
                        } placeholder: {
                            ProgressView()
                                .frame(height: 250)
                        }
                    }
                    
                    // Instructions Section
                    Section(header: Text("Instructions").font(.title2).fontWeight(.bold).padding(.bottom, 5)) {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(mealDetail.instructions.components(separatedBy: "\r\n").filter { !$0.isEmpty }, id: \.self) { step in
                                HStack(alignment: .top) {
                                    Text("•")
                                        .font(.headline)
                                    Text(step)
                                        .padding(.leading, 5)
                                }
                                .padding()
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(10)
                            }
                        }
                    }
                    
                    // Ingredients Section
                    Section(header: Text("Ingredients").font(.title2).fontWeight(.bold).padding(.bottom, 5)) {
                        ForEach(mealDetail.ingredients) { ingredient in
                            HStack {
                                Text(ingredient.name)
                                    .fontWeight(.semibold)
                                Spacer()
                                Text(ingredient.measure)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(10)
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .padding()
            .navigationTitle("Meal Details")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.fetchMealDetail(id: mealId)
            }
        }
    }
}
