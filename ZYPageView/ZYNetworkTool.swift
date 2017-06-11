//
//  ZYNetworkTool.swift
//  LiveDemo
//
//  Created by 王志盼 on 2017/4/20.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit
import Alamofire

enum ZYNetworkType: Int{
    case get
    case post
}

class ZYNetworkTool: NSObject {
    
    class func requestData(_ type: ZYNetworkType, urlStr: String, params: [String: Any]? = nil, completedCallback: @escaping (_ result: Any) -> ()) {
        
        let method = (type == ZYNetworkType.get) ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(urlStr, method: method, parameters: params).responseJSON { (response) in
            
            guard let result = response.result.value else{
                print(response.result.error!)
                return
            }
            completedCallback(result)
            
        }
        
    }
}
