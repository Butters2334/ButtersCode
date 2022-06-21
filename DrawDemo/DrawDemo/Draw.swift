//
//  Draw.swift
//  DrawDemo
//
//  Created by ac on 2022/6/21.
//

import UIKit

class Draw:UIView{
    private var _pointCount = 0
    var pointCount:Int {
        set{
            _pointCount = newValue
            drawPolygon(pointCount: _pointCount)
        }
        get{
            return _pointCount
        }
    }
    func drawPolygon(pointCount : Int) {
        self.layoutIfNeeded()
        //design the path
        let path = UIBezierPath(rect: self.bounds)
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        path.move(to: CGPoint(x:width,y:0))
        path.addLine(to: end)
        
        //design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = randomColor().cgColor
        shapeLayer.lineWidth = 1.0
        
        self.layer.addSublayer(shapeLayer)
    }
}
