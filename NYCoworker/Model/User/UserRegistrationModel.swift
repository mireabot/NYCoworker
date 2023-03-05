//
//  UserRegistrationModel.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/28/23.
//

import SwiftUI

class UserRegistrationModel: ObservableObject {
    @Published var name = ""
    @Published var occupation = ""
    @Published var gender = ""
    @Published var accountType = ""
}
