//
//  ZYGiftPackage.swift
//  ZYPageView
//
//  Created by 王志盼 on 31/05/2017.
//  Copyright © 2017 王志盼. All rights reserved.
//

import UIKit

class ZYGiftPackage: ZYBaseEntity {

    var t : Int = 0
    var title : String = ""
    var list : [ZYGiftEntity] = [ZYGiftEntity]()
    
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "list" {
            
            if let listArray = value as? [[String : Any]] {
                for listDict in listArray {
                    list.append(ZYGiftEntity(dict: listDict))
                }
            }
            
        }
        else {
            super.setValue(value, forUndefinedKey: key)
        }
    }
}
