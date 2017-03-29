//
//  Define.swift
//  ZHSQSwift
//
//  Created by 胡建岭 on 16/5/6.
//  Copyright © 2016年 胡建岭. All rights reserved.
//

import UIKit

enum ScrollType : NSInteger {
    
    case iphone4        = 0
    case iphone5s       = 1
    case iphone6        = 2
    case iphone6Plus    = 3
}






/** 颜色宏 */
extension UIColor{
    
    /** 导航栏颜色 */
    class func nacBarColor() ->UIColor{
        
        return UIColor.colorWithRGBString(76, g: 131, b: 225)
    }
    
    /**
     RBGA返回颜色
     
     - parameter r: reb
     - parameter g: green
     - parameter b: blue
     - parameter a: alpha
     
     - returns: color
     */
    public class func colorWithRGBAString (_ r: NSInteger,g : NSInteger, b :NSInteger, a : CGFloat) ->UIColor{
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }
    
    /**
     RBG返回颜色
     
     - parameter r: reb
     - parameter g: green
     - parameter b: blue
     
     - returns: color
     */
    class func colorWithRGBString(_ r : NSInteger,g : NSInteger, b :NSInteger) ->UIColor {
        
        return UIColor.colorWithRGBAString(r, g: g, b: b, a: 1)
    }
    
    /**
     16进制返回颜色
     
     - parameter hex: 16进制色值
     
     - returns: color
     */
    public class func colorWithHexString (_ hex : String) ->UIColor?{
        
        
        
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#"){
            
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString as NSString).length != 6{
            
            return nil
        }
        
        let rString = (cString as NSString).substring(to: 2)
        
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1)
        
    }
    
    /* 主题蓝色 */
    public class func kTitleBlue() ->UIColor{
        return UIColor(red: CGFloat(71) / 255.0, green: CGFloat(156) / 255.0, blue: CGFloat(242) / 255.0, alpha: 1)
    }
    
    /* 主题红色 */
    public class func kTitleRed() ->UIColor{
        return UIColor(red: CGFloat(246) / 255.0, green: CGFloat(102) / 255.0, blue: CGFloat(102) / 255.0, alpha: 1)
    }
    
    /* 提示橘黄 */
    public class func kOrange() ->UIColor{
        return UIColor(red: CGFloat(255) / 255.0, green: CGFloat(122) / 255.0, blue: CGFloat(34) / 255.0, alpha: 1)
    }
    
    /* 默认背景灰 eeeeee*/
    public class func keeeeee() ->UIColor{
        return UIColor(red: CGFloat(238) / 255.0, green: CGFloat(238) / 255.0, blue: CGFloat(238) / 255.0, alpha: 1)
        
    }
    
    /* 默认分割线 e5e5e5*/
    public class func ke5e5e5() ->UIColor{
        return UIColor(red: CGFloat(229) / 255.0, green: CGFloat(229) / 255.0, blue: CGFloat(229) / 255.0, alpha: 1)
    }
    
    /* 灰底分割线 dadbdf*/
    public class func kdadbdf() ->UIColor{
        return UIColor(red: CGFloat(218) / 255.0, green: CGFloat(219) / 255.0, blue: CGFloat(223) / 255.0, alpha: 1)
    }
    
    /* 一级标题 */
    public class func k333333() ->UIColor{
        return UIColor(red: CGFloat(51) / 255.0, green: CGFloat(51) / 255.0, blue: CGFloat(51) / 255.0, alpha: 1)
        
    }
    
    /* 二级标题 */
    public class func k999999() ->UIColor{
        return UIColor(red: CGFloat(153) / 255.0, green: CGFloat(153) / 255.0, blue: CGFloat(153) / 255.0, alpha: 1)
        
    }
}

extension UIFont{
    
    /** 返回标准字体的大小 */
    class func kFont(_ a : CGFloat) -> UIFont{
        
        return UIFont.systemFont(ofSize: a)
    }
}

extension String{
    
    /** 正则表达式 */
    fileprivate func regularExpression(_ pattern : String) -> Bool{
        
        let reg = try?  NSRegularExpression.init(pattern: pattern, options: NSRegularExpression.Options.dotMatchesLineSeparators)
        
        let match = reg?.matches(in: self, options: [], range: NSMakeRange(0, self.characters.count))
        
        if (match?.count)! > 0 {
            
            return true
        }else{
            
            return false
        }
    }
    
    /** 是否是手机号 */
    func isPhoneNumber() -> Bool{
        
        let pattern = "^((1[3,5,8][0-9])|(14[5,7])|(17[0,6,7,8]))[0-9]{8}$"
        
//        let pattern = "^0?(13[0-9]|15[012356789]|17[0-9]|18[0123456789]|14[57])[0-9]{8}$"
        
        //        let pattern = "^1[0-9]{10}$"
        
        return self.regularExpression(pattern)
    }
    
    
    /** 是否是身份证 */
    func isCarNum() -> Bool {
        
        let pattern = "^([0-9]{14}|[0-9]{17})[0-9|x]$"
        
        return self.regularExpression(pattern)
    }
    
    /** 转接电话是否合法 */
    func isChangePhone() -> Bool {
        
        let pattern = "(^0[0-9]{9,11}$)|(^((1[3,5,8][0-9])|(14[5,7])|(17[0,6,7,8]))[0-9]{8}$)"
        
        return self.regularExpression(pattern)
    }
    /**是否是数字 */
    func isNumber() -> Bool{
        let str = "[0-9]"
        return self.regularExpression(str)
    }
    /**是否是大写字母 */
    func isBigChar() -> Bool{
        let str = "[A-Z]"
        return self.regularExpression(str as String)
    }
    /**是否是表情符号 */
    func isFace() ->Bool{
        let str = "[\\ud83c\\udc00-\\ud83c\\udfff]|[\\ud83d\\udc00-\\ud83d\\udfff]|[\\u2600-\\u27ff]"
//        let str = "[\\u0000-\\uFFFF]"
        return self.regularExpression(str as String)
    }//10123 10126 10130
    var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case
            0x00A0...0x00AF,
            0x2030...0x204F,
            0x2120...0x213F,
            0x2190...0x21AF,
            0x2310...0x278A,
            0x2793...0x329F,
            0x1F000...0x1F9CF:
                return true
            default:
                continue
            }
        }
        return false
    }

    /**isChina */
    func isChinese() ->Bool{
        let str = "[\\u4e00-\\u9fa5]"
        return self.regularExpression(str as String)
    }
}

extension NSString{
    /** 计算字符串所占尺寸 */
    func returnStringSize(_ maxSize : CGSize, font : UIFont) -> CGSize{
        
        return self.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil).size
    }
    
}

extension String{
    
    func returnStringSize(_ maxSize : CGSize, font : UIFont) -> CGSize{
        
        return self.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil).size
    }
    
    
}
extension String{
    /**  */
    /// 时间戳转时间
    ///
    /// - Parameter formatter: 时间格式
    func timeStampToString(formatter : String)->String {
        
        let string = NSString(string: self)
        
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = formatter
        
        let date = NSDate(timeIntervalSince1970: timeSta)
        
        return dfmatter.string(from: date as Date)
    }
    
    
}
extension Date{
    
    /**
     date 转字符串
     
     - parameter date:      date
     - parameter formatter: 格式
     
     - returns: <#return value description#>
     */
    func stringFromDate(_ formatter : String) -> String{
        
        let dateMatter : DateFormatter = DateFormatter.init()
        dateMatter.dateFormat = formatter
        
        return dateMatter.string(from: self as Date)
    }
}

extension UIImage{
    
    func hanldImg() -> UIImage{
        
        
        return self.stretchableImage(withLeftCapWidth: Int(self.size.width) / 2, topCapHeight: Int(self.size.height) / 2)
    }
}
 
extension UIView{
    public class func creatLineView(frame : CGRect) ->UIView{
        let line : UIView = UIView.init(frame: frame)
        line.backgroundColor = UIColor.colorWithHexString("e5e5e5")
        return line
    }
}

extension UILabel{
    
    /// 创建一个基本label
    /// - color: 字体颜色
    /// - font: 字体大小
    public class func creatBaseLabel(textColor : UIColor?,font : CGFloat?) ->UILabel{
        let id = UILabel.init()
        if font != nil {
            id.font = UIFont.systemFont(ofSize: font!)
        }
        if textColor != nil {
            id.textColor = textColor
        }
        
        return id
    }
    //动态添加高
    func getLabHeigh(width : CGFloat) -> CGFloat {
        let label = self
        let statusLabelText : String = label.text!
        
        let size = CGSize.init(width: width, height: CGFloat(MAXFLOAT))
        
        let dic = NSDictionary(object: label.font, forKey: NSFontAttributeName as NSCopying)
        
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context:nil).size
        
        return strSize.height
        
    }
}
extension UIButton{
    /**
     只有文字的按钮
     
     - parameter sel:       响应时间的方法
     - parameter target:    响应时间的目标
     - parameter text:      文字
     - parameter font:      文字字体
     - parameter textColor: 文字颜色
     */
    public class func creatBaseButton( text : NSString?,font : UIFont?,textColor : UIColor?,imageStr : String?) -> UIButton{
        
        let but : UIButton = UIButton.init()
        
        if text != nil {
            but.setTitle(text! as String, for: UIControlState.normal)
        }
        
        if textColor != nil {
            but.setTitleColor(textColor, for: UIControlState.normal)
        }
        if font != nil {
            but.titleLabel?.font = font
        }
        if imageStr != nil {
            but.setBackgroundImage(UIImage.init(named: imageStr!), for: UIControlState.normal)
        }
        return but
    }
}

/** 获取视频数据 */
public let KGetVideoDataNotification : String = "getVideoData"

public let KCallDoorNotification : String = "callDoor"

/** 通话链接已经断开 */
public let KCallDisconnectNotifacation : String = "CallDisconnect"
