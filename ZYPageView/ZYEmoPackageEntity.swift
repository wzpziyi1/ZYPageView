//
//  ZYEmoPackageEntity.swift
//  ZYPageView
//
//  Created by 王志盼 on 27/05/2017.
//  Copyright © 2017 王志盼. All rights reserved.
//

import UIKit

class ZYEmoPackageEntity {
    lazy var emoticons : [ZYEmotionEntity] = [ZYEmotionEntity]()
    
    init(plistName : String) {
        guard let path = Bundle.main.path(forResource: plistName, ofType: nil) else {
            return
        }
        
        guard let emotionArray = NSArray(contentsOfFile: path) as? [String] else {
            return
        }
        
        for str in emotionArray {
            emoticons.append(ZYEmotionEntity(emoticonName: str))
        }
    }
}
