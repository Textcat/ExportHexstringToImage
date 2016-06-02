//
//  ExportHexstringToImage.swift
//  RenderTextOnImage
//
//  Created by 刘业臻 on 16/6/2.
//  Copyright © 2016年 luiyezheng. All rights reserved.
//

import Foundation
import UIKit

func getImageWithColor(size: CGSize, colors: [String], textFont: UIFont, textColor: UIColor) -> UIImage {
    //Set some variables
    let perWidth = size.width
    let perHeight = size.height / 5.0
    let textFontAttributes = [
        NSFontAttributeName: textFont,
        NSForegroundColorAttributeName: textColor
    ]
    
    //Fill colors
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    for index in 0...4 {
        let rect = CGRectMake(0, CGFloat(index) * perHeight, size.width, perHeight)
        UIColor(hexString: colors[index]).setFill()
        UIRectFill(rect)
    }
    var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
    
    //Render Text on Image
    var initialY = perHeight / 2.0
    for index2 in 1...5 {
        let attrText = NSAttributedString(string: colors[index2 - 1], attributes: textFontAttributes)
        let textRect = attrText.boundingRectWithSize(CGSizeMake(perWidth, perHeight), options: [.UsesFontLeading, .UsesLineFragmentOrigin], context: nil)
        let textWidth = textRect.size.width
        let textHeight = textRect.size.height
        let position = CGPoint(x: (size.width / 2) - (textWidth / 2), y: initialY - textHeight / 2)
        
        image = textToImage(colors[index2 - 1], inImage: image, atPoint: position, textColor: textColor, textFont: textFont)
        
        initialY += perHeight
    }
    UIGraphicsEndImageContext()
    
    return image
}


func textToImage(drawText: NSString, inImage: UIImage, atPoint:CGPoint, textColor: UIColor, textFont: UIFont)->UIImage{
    
    //Setup the image context using the passed image.
    let scale = UIScreen.mainScreen().scale
    UIGraphicsBeginImageContextWithOptions(inImage.size, false, scale)
    
    //Setups up the font attributes that will be later used to dictate how the text should be drawn
    let textFontAttributes = [
        NSFontAttributeName: textFont,
        NSForegroundColorAttributeName: textColor,
        ]
    
    //Put the image into a rectangle as large as the original image.
    inImage.drawInRect(CGRectMake(0, 0, inImage.size.width, inImage.size.height))
    
    // Creating a point within the space that is as bit as the image.
    let rect: CGRect = CGRectMake(atPoint.x, atPoint.y, inImage.size.width, inImage.size.height)
    
    //Now Draw the text into an image.
    drawText.drawInRect(rect, withAttributes: textFontAttributes)
    
    // Create a new image out of the images we have created
    let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
    
    // End the context now that we have the image we need
    UIGraphicsEndImageContext()
    
    //And pass it back up to the caller.
    return newImage
    
}

extension UIColor {
    convenience init(hexString:String) {
        let hexString:NSString = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let scanner            = NSScanner(string: hexString as String)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
}

