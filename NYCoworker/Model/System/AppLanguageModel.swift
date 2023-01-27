//
//  AppLanguageModel.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/26/23.
//

import SwiftUI

struct AppLanguageModel: Identifiable {
    var id: Int
    let language: String
    let flag: Image
}

let appLanguages = [
    AppLanguageModel(id: 0, language: "English", flag: Image("English")),
    AppLanguageModel(id: 1, language: "Русский", flag: Image("Russian"))
]
