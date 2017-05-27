//
//  ZYEmotionCell.swift
//  ZYPageView
//
//  Created by 王志盼 on 27/05/2017.
//  Copyright © 2017 王志盼. All rights reserved.
//

import UIKit

class ZYEmotionCell: UICollectionViewCell {

    
    @IBOutlet weak var picView: UIImageView!
    
    var emotionEntity: ZYEmotionEntity? {
        didSet {
//            print(emotionEntity!.emoticonName)
            picView.image = UIImage(named: emotionEntity!.emoticonName)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
