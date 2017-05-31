//
//  ZYGiftViewCell.swift
//  ZYPageView
//
//  Created by 王志盼 on 31/05/2017.
//  Copyright © 2017 王志盼. All rights reserved.
//

import UIKit

class ZYGiftViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var giftEntity : ZYGiftEntity? {
        didSet {
            iconImageView.setImage(giftEntity?.img2, "room_btn_gift")
            subjectLabel.text = giftEntity?.subject
            priceLabel.text = "\(giftEntity?.coin ?? 0)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let selectedView = UIView()
        selectedView.layer.cornerRadius = 5
        selectedView.layer.masksToBounds = true
        selectedView.layer.borderWidth = 1
        selectedView.layer.borderColor = UIColor.orange.cgColor
        selectedView.backgroundColor = UIColor.black
        
        selectedBackgroundView = selectedView
    }

}
