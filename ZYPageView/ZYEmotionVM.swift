//
//  ZYEmotionVM.swift
//  ZYPageView
//
//  Created by 王志盼 on 27/05/2017.
//  Copyright © 2017 王志盼. All rights reserved.
//

import UIKit

class ZYEmotionVM {
    static let sharedEmotionVM = ZYEmotionVM()
    lazy var packages : [ZYEmoPackageEntity] = [ZYEmoPackageEntity]()
    
    init() {
        packages.append(ZYEmoPackageEntity(plistName: "QHNormalEmotionSort.plist"))
        packages.append(ZYEmoPackageEntity(plistName: "QHSohuGifSort.plist"))
    }
}
