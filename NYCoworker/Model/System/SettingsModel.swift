//
//  SettingsModel.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/31/23.
//

import SwiftUI

struct SettingsModel: Hashable {
    var title: String
    var icon: Image
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(title)
    }
}

let settigsData = [
    SettingsModel(title: Strings.Settings.manageAccount, icon: Resources.Images.Settings.manageAccount),
    SettingsModel(title: Strings.Settings.helpSupport, icon: Resources.Images.Settings.help)
]
