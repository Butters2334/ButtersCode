//
//  Draw.swift
//  DrawDemo
//
//  Created by ac on 2022/6/21.
//

import UIKit

@IBDesignable
class Draw:UIView{
    private var _pointCount = 0
    @IBInspectable var drawWidth :CGFloat = 0.0
    @IBInspectable var drawHeight:CGFloat = 0.0
    @IBInspectable var pointCount:Int {
        set{
            _pointCount = newValue
            drawPolygon()
        }
        get{
            return _pointCount
        }
    }
    func drawPolygon() {
//        self.layoutIfNeeded()
        for layer in layer.sublayers ?? []{
            layer.removeFromSuperlayer()
        }
        self.backgroundColor = UIColor.clear
        let circlePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: drawWidth, height: drawHeight))
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.white.cgColor
        circleLayer.lineWidth = 1.0
        self.layer.addSublayer(circleLayer)

        if pointCount < 3 {
            return
        }

        let circleRadius = CGFloat(drawWidth/2)
        let path = UIBezierPath()
        let circleCenter = CGPoint(x:drawWidth/2,y:drawHeight/2);
        path.move(to:circleCenter)
        for index in 0...pointCount{
            let angle = Double(360.0/Float(pointCount) * Float(index))
            let sinus = CGFloat(sin(angle * Double.pi / 180))
            let a = sinus * circleRadius
            let cosinus = CGFloat(cos(angle * Double.pi / 180))
            let b = cosinus * circleRadius
            path.addLine(to: CGPoint(x:circleCenter.x+a,y:circleCenter.y+b))
        }
        path.close()
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = randomColor().cgColor
        shapeLayer.lineWidth = 0
        self.layer.addSublayer(shapeLayer)
    }
}
