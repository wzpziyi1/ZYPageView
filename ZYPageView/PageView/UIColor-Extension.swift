//
//  UIColor-Extension.swift
//  LiveDemo
//
//  Created by 王志盼 on 2017/4/3.
//  Copyright © 2017年 王志盼. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    
    convenience init?(hex: String, alpha: CGFloat = 1) {
        guard hex.characters.count >= 6 else {
            return nil
        }
        
        var tmpHex = hex.lowercased()
        
        if tmpHex.hasPrefix("0x") || tmpHex.hasPrefix("##") {
            tmpHex = (tmpHex as NSString).substring(from: 2)
        }
        
        if tmpHex.hasPrefix("#") {
            tmpHex = (tmpHex as NSString).substring(from: 1)
        }
        
        let (r, g, b) = UIColor.fetchRGBValues(rgbStr: tmpHex)
        
        self.init(r: r, g: g, b: b, alpha: alpha)
    }
    
    fileprivate class func fetchRGBValues(rgbStr: String) -> (CGFloat, CGFloat, CGFloat) {
        let tmpStr = rgbStr as NSString
        let rStr = tmpStr.substring(with: NSMakeRange(0, 2))
        let gStr = tmpStr.substring(with: NSMakeRange(2, 2))
        let bStr = tmpStr.substring(with: NSMakeRange(4, 2))
        
        let calFunc = {(valueStr: String) -> CGFloat in
            var sum: UInt32 = 0
            var mult: UInt32 = 1
            
            let zeroValue: UInt32 = 48
            let nineValue: UInt32 = 57
            let aValue: UInt32 = 97
            let fValue: UInt32 = 102
            
            for ch in valueStr.unicodeScalars {
                
                if ch.value >= zeroValue && ch.value <= nineValue {
                    sum += (ch.value - zeroValue) * mult
                }
                
                if ch.value >= aValue && ch.value <= fValue {
                    sum += (ch.value - aValue) * mult
                }
                mult *= 16
            }
            
            return CGFloat(sum)
        }
        return (calFunc(rStr), calFunc(gStr), calFunc(bStr))
    }
    
    
    /// 随机颜色
    ///
    class func randomColor() -> UIColor {
        let r: CGFloat = CGFloat(arc4random_uniform(256))
        let g: CGFloat = CGFloat(arc4random_uniform(256))
        let b: CGFloat = CGFloat(arc4random_uniform(256))
        return UIColor(r: r, g: g, b: b)
    }
    
    class func getRGBDelta(_ firstColor : UIColor, _ seccondColor : UIColor) -> (CGFloat, CGFloat,  CGFloat) {
        let firstRGB = firstColor.getRGB()
        let secondRGB = seccondColor.getRGB()
        
        return (firstRGB.0 - secondRGB.0, firstRGB.1 - secondRGB.1, firstRGB.2 - secondRGB.2)
    }
    
    func getRGB() -> (CGFloat, CGFloat, CGFloat) {
        guard let cmps = cgColor.components else {
            fatalError("保证普通颜色是RGB方式传入")
        }
        
        return (cmps[0] * 255, cmps[1] * 255, cmps[2] * 255)
    }
    
}
