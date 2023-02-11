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
    SettingsModel(id: 0, title: Strings.Settings.manageAccount, icon: Resources.Images.Settings.manageAccount),
    SettingsModel(id: 1, title: Strings.Settings.helpSupport, icon: Resources.Images.Settings.help),
    SettingsModel(id: 2, title: Strings.Settings.manageNotifications, icon: Resources.Images.Settings.manageNotifications),
    SettingsModel(id: 3, title: Strings.Settings.language, icon: Resources.Images.Settings.changeLanguage),
]
