//
//  GetDrinksResponseDTO.swift
//  EliqDrinkApp
//
//  Created by Amila Prasad on 2022-08-23.
//

import Foundation

struct GetDrinksResponseDTO: Decodable {
    let drinks: [ListItemModel]
}
