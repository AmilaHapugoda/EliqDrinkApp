//
//  DrinkDetailsModel.swift
//  EliqDrinkApp
//
//  Created by Amila Prasad on 2022-08-23.
//

import Foundation

struct DrinkDetailsModel: Decodable {
    let idDrink: String
    let strDrink: String?
    let strDrinkThumb: String?
    let strCategory: String?
    let strAlcoholic: String?
    let strGlass: String?
    
    //Instructions
    let strInstructions: String?
    let strInstructionsES: String?
    let strInstructionsDE: String?
    let strInstructionsFR: String?
    let strInstructionsIT: String?
    
    //Ingrediens
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
}

