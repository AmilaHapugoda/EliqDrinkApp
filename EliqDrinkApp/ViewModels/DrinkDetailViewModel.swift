//
//  DrinkDetailViewModel.swift
//  EliqDrinkApp
//
//  Created by Amila Prasad on 2022-08-23.
//

import Foundation

final class DrinkDetailViewModel: ObservableObject {
    
    private let url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i="
    
    // Drink Detail
    @Published var details: DrinkDetailsModel?
    
    // loader
    @Published var isLoading: Bool = false
    
    // Ingredients
    @Published var ingredients: String?
    
    // Available Languages
    @Published var langArr: [LanguageModel] = []
    
    // Get drink details from URL
    func getDrinkDetails(id : String){

        let requestURL = url + id
        self.isLoading = true
        
        HttpRequestHandler.shared.request(endPoint: requestURL, onSuccess: { data in
            do{
                let responseObject = try JSONDecoder().decode(DrinkDetailResponseDTO.self, from: data!)
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.details = responseObject.drinks[0]
                    self.setIngredients()
                    self.setAvailableLanguages()
                }
            }catch(let ex){
                DispatchQueue.main.async {
                    self.isLoading = false
                    print("JSON ERROR : \(ex)")
                }
            }
        }, onFailure: { error in
            DispatchQueue.main.async {
                self.isLoading = false
                print("ERROR :  \(error)")
            }
        })
    }
    
    // Get ingredients from the object and concatinate them to single string
    
    func setIngredients() {
        var ingredientsArr : [String] = []
        
        if let ingredient  = self.details?.strIngredient1{
            ingredientsArr.append(ingredient)
        }
        if let ingredient  = self.details?.strIngredient2{
            ingredientsArr.append(ingredient)
        }
        if let ingredient  = self.details?.strIngredient3{
            ingredientsArr.append(ingredient)
        }
        if let ingredient  = self.details?.strIngredient4{
            ingredientsArr.append(ingredient)
        }
        if let ingredient  = self.details?.strIngredient5{
            ingredientsArr.append(ingredient)
        }
        if let ingredient  = self.details?.strIngredient6{
            ingredientsArr.append(ingredient)
        }
        if let ingredient  = self.details?.strIngredient7{
            ingredientsArr.append(ingredient)
        }
        if let ingredient  = self.details?.strIngredient8{
            ingredientsArr.append(ingredient)
        }
        if let ingredient  = self.details?.strIngredient9{
            ingredientsArr.append(ingredient)
        }
        if let ingredient  = self.details?.strIngredient10{
            ingredientsArr.append(ingredient)
        }
        if let ingredient  = self.details?.strIngredient11{
            ingredientsArr.append(ingredient)
        }
        if let ingredient  = self.details?.strIngredient12{
            ingredientsArr.append(ingredient)
        }
        if let ingredient  = self.details?.strIngredient13{
            ingredientsArr.append(ingredient)
        }
        if let ingredient  = self.details?.strIngredient14{
            ingredientsArr.append(ingredient)
        }
        if let ingredient  = self.details?.strIngredient15{
            ingredientsArr.append(ingredient)
        }
        
        self.ingredients = ingredientsArr.joined(separator: ", ")

    }
    
    // Create an array with available languages in detailed object
    
    func setAvailableLanguages() {
        if let en  = self.details?.strInstructions{
            self.langArr.append(LanguageModel(lang: "EN", name: "English", description: en))
        }
        if let es  = self.details?.strInstructionsES{
            self.langArr.append(LanguageModel(lang: "ES", name: "Spanish", description: es))
        }
        if let de  = self.details?.strInstructionsDE{
            self.langArr.append(LanguageModel(lang: "DE", name: "German", description: de))
        }
        if let fr  = self.details?.strInstructionsFR{
            self.langArr.append(LanguageModel(lang: "FR", name: "French", description: fr))
        }
        if let it  = self.details?.strInstructionsIT{
            self.langArr.append(LanguageModel(lang: "IT", name: "Italian", description: it))
        }
    }
    
    // Filter your instructions on language
    
    func getInstructinsByLanguage(lang: String) -> String {
        let filtered = langArr.filter{ $0.id.contains(lang) }
        if(filtered.count > 0){
            return filtered[0].description
        }else{
            return ""
        }
    }
}
