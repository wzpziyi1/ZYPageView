//
//  ZYGiftEntity.swift
//  ZYPageView
//
//  Created by 王志盼 on 31/05/2017.
//  Copyright © 2017 王志盼. All rights reserved.
//

import UIKit

class ZYGiftEntity: ZYBaseEntity {
    
    var img2 : String = "" // 图片
    var coin : Int = 0 // 价格
    var subject : String = "" { // 标题
        didSet {
            if subject.contains("(有声)") {
                subject = subject.replacingOccurrences(of: "(有声)", with: "")
            }
        }
    }
}
