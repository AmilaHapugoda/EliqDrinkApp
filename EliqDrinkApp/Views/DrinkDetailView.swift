//
//  DrinkDetailView.swift
//  EliqDrinkApp
//
//  Created by Amila Prasad on 2022-08-23.
//

import SwiftUI

// Observer to get selecte drink from UIkit
class SelectedDrink: ObservableObject {
    @Published var drinkId: String = ""
    
    init(id: String) {
        self.drinkId = id
    }
}

struct DrinkDetailView: View {
    
    @ObservedObject var selectedDrink: SelectedDrink
    @ObservedObject var viewModel = DrinkDetailViewModel()
    
    // Sefault language
    @State private var selection = "EN"
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                AsyncImage(
                    url: URL(string: viewModel.details?.strDrinkThumb ?? "")) { image in
                        image
                            .resizable()
                            .frame(maxHeight: 220)
                    } placeholder: {
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                VStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 22)
                    Divider()
                    Text(viewModel.ingredients ?? "")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 24)
                    
                    HStack {
                        Text("Instructions")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Picker("Select a paint color", selection: $selection) {
                            ForEach(viewModel.langArr, id: \.id) {
                                Text($0.name)
                            }
                        }
                        .pickerStyle(.menu)
                        
                    }
                    Divider()
                    Text(viewModel.getInstructinsByLanguage(lang: selection))
                        .font(.subheadline)
                    Spacer()
                }
            }
            
            if (viewModel.isLoading){
                ProgressView()
                    .progressViewStyle(.automatic)
                    .scaleEffect(2)
            }
        }
        .padding()
        .onAppear {
            viewModel.getDrinkDetails(id: selectedDrink.drinkId)
        }
        .navigationTitle(viewModel.details?.strDrink ?? "")
    }
}

struct DrinkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDetailView(selectedDrink: SelectedDrink(id: "15346"))
    }
}
