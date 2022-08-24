//
//  DrinksViewModel.swift
//  EliqDrinkApp
//
//  Created by Amila Prasad on 2022-08-21.
//

import Foundation

final class DrinksViewModel {
    
    private let url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic"
    
    // Show this alert on view when changed
    @Published var alertMessage: String?
    
    // drinks list
    @Published var drinks: [ListItemModel] = []
    
    // loader
    @Published var isLoading: Bool?
    
    // Get drinks from URL
    func getDrinks() {
        self.isLoading = true
        HttpRequestHandler.shared.request(endPoint: url, onSuccess: { data in
            self.isLoading = false
            do{
                let responseObject = try JSONDecoder().decode(GetDrinksResponseDTO.self, from: data!)
                self.drinks = responseObject.drinks
            }catch(let ex){
                print("JSON ERROR : \(ex)")
            }
        }, onFailure: { error in
            self.isLoading = false
            self.alertMessage = "ERROR :  \(error)"
        })
    }
}
