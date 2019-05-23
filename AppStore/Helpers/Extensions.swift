//
//  Extensions.swift
//  AppStore
//
//  Created by Will Wang on 5/21/19.
//  Copyright © 2019 Will Wang. All rights reserved.
//

import UIKit

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
    }
}

extension UIButton {
    convenience init(title: String, color: UIColor) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.backgroundColor = color
    }
}

extension UILabel {
    convenience init(text: String, font: UIFont) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
    }
}
