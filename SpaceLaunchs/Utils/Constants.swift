//
//  Constants.swift
//  SpaceLaunchs
//
//  Created by Issam Lanouari on 30/01/2021.
//

import Foundation
import UIKit

enum Localizable {
    enum LaunchsListViewController {
        static let title = "Lancements"
        static let noData = "Aucun lancement trouver, veuillez réessayer plus tard"
        static let apiError = "Une erreure est survenu, veuillez appuyer sur « refresh » pour réessayer"
    }
}

enum AppFont {
    static let largeTitle = UIFont.boldSystemFont(ofSize: 18)
    static let mediumTitle = UIFont.boldSystemFont(ofSize: 16)
    static let mediumText = UIFont.systemFont(ofSize: 16)
    static let smallText = UIFont.systemFont(ofSize: 14)
}

enum AppConstraint {
    static let imageRatio: CGFloat = 0.8
    static let smallPadding: CGFloat = 5
    static let mediumPadding: CGFloat = 10
    static let largePadding: CGFloat = 20
    static let estimatedRowHeight: CGFloat = 120.0
}
