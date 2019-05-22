//
// Created by Will Wang on 2019-05-06.
// Copyright (c) 2019 Will Wang. All rights reserved.
//

import UIKit

//extension UILabel {
//    convenience init() {
//        self.init(frame: .zero)
//
//    }
//}

class AppsGroupCell: UICollectionViewCell {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "App section"
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .lightGray
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
