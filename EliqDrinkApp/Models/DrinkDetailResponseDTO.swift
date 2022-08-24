//
//  DrinkDetailResponseDTO.swift
//  EliqDrinkApp
//
//  Created by Amila Prasad on 2022-08-23.
//

import Foundation

struct DrinkDetailResponseDTO: Decodable {
    let drinks: [DrinkDetailsModel]
}
