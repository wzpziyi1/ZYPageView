//
//  ZYBaseEntity.swift
//  LiveDemo
//
//  Created by 王志盼 on 2017/4/26.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit

class ZYBaseEntity: NSObject {

    override init() {
        
    }
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("\(self) 中含有未定义的key，属性名为：\(key)")
    }
}
