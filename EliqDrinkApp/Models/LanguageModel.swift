//
//  LanguageModel.swift
//  EliqDrinkApp
//
//  Created by Amila Prasad on 2022-08-23.
//

import Foundation

struct LanguageModel: Identifiable, Hashable {
    let id : String
    let name : String
    let description : String
    
    init(lang: String, name: String, description: String) {
        self.id = lang
        self.name = name
        self.description = description
    }
}
