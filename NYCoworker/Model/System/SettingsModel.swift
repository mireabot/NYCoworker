//
//  SettingsModel.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/31/23.
//

import SwiftUI

struct SettingsModel: Identifiable {
    var id: Int
    let title: String
    let icon: Image
}

let settigsData = [
    SettingsModel(id: 0, title: "Manage account", icon: Resources.Images.Settings.manageAccount),
    SettingsModel(id: 1, title: "Help & Support", icon: Resources.Images.Settings.help),
    SettingsModel(id: 2, title: "Manage notifications", icon: Resources.Images.Settings.manageNotifications),
    SettingsModel(id: 3, title: "Change language", icon: Resources.Images.Settings.changeLanguage),
]
