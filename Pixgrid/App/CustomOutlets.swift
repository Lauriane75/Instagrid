//
//  CustomOutlets.swift
//  PixGrid
//
//  Created by Lau on 26/02/2021.
//  Copyright © 2021 Lauriane Haydari. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {
    convenience init(title: String?, color: UIColor, textFont: UIFont) {
        self.init()
        text = title
        textColor = color
        font = textFont
        textAlignment = .center
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
