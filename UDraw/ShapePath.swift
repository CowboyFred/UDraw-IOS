//
//  ShapePath.swift
//  UDraw
//
//  Created by Peka on 4/3/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class ShapePath: UIBezierPath
{
    @objc func round(startPoint: CGPoint, endPoint: CGPoint) -> UIBezierPath
    {
        return UIBezierPath(ovalIn: CGRect(x: startPoint.x, y: startPoint.y, width:(endPoint.x - startPoint.x), height: (endPoint.y - startPoint.y)))
    }
    
    @objc func rect(startPoint: CGPoint, endPoint: CGPoint) -> UIBezierPath
    {
        return UIBezierPath(rect: CGRect(x: startPoint.x, y: startPoint.y, width: (endPoint.x - startPoint.x), height: (endPoint.y - startPoint.y)))
    }
    
    @objc func line(startPoint: CGPoint, endPoint: CGPoint) -> UIBezierPath
    {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
        linePath.addLine(to: CGPoint(x: endPoint.x, y:endPoint.y))
        return linePath
    }
    
    @objc func oct(startPoint: CGPoint, endPoint: CGPoint) -> UIBezierPath
    {
        return UIBezierPath(polygonIn: CGRect(x: startPoint.x, y: startPoint.y, width: (endPoint.x - startPoint.x), height: (endPoint.y - startPoint.y)), sides:8)
    }
    
    @objc func hex(startPoint: CGPoint, endPoint: CGPoint) -> UIBezierPath
    {
        return UIBezierPath(polygonIn: CGRect(x: startPoint.x, y: startPoint.y, width: (endPoint.x - startPoint.x), height: (endPoint.y - startPoint.y)), sides:6)
    }
    
    @objc func brush(startPoint: CGPoint, endPoint: CGPoint) -> UIBezierPath
    {
        let quadPath = UIBezierPath()
        quadPath.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
        quadPath.addQuadCurve(to: CGPoint(x: endPoint.x, y: endPoint.y), controlPoint: CGPoint(x: (endPoint.x
        + startPoint.x)/2, y: (endPoint.y + startPoint.y)/2))
        return quadPath
    }
    
}

//  Based on: https://github.com/ZevEisenberg/ZEPolygon God bless him!


extension UIBezierPath {
        @objc convenience init(polygonIn rect:CGRect, sides:Int) {
        self.init()
        
        let xR = rect.width/2
        let yR = rect.height/2
        let x0 = rect.midX
        let y0 = rect.midY
        
        self.move(to: CGPoint(x: xR + x0, y: y0 + 0))
        
        for i in 0..<sides {
            let theta = CGFloat(2*Double.pi)/CGFloat(sides) * CGFloat(i)
            let xCoordinate = x0 + xR * cos(theta)
            let yCoordinate = y0 + yR * sin(theta)
            self.addLine(to: CGPoint(x: xCoordinate, y: yCoordinate))
        }
        self.close()
    }
}
