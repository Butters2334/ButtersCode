//
//  Draw.swift
//  DrawDemo
//
//  Created by ac on 2022/6/21.
//

import UIKit

@IBDesignable
class Draw:UIView{
    @IBInspectable var drawWidth :CGFloat = 0.0
    @IBInspectable var drawHeight:CGFloat = 0.0
    private var _pointCount = 0
    @IBInspectable var pointCount:Int {
        set{
            _pointCount = newValue
//            drawPolygon()
        }
        get{
            return _pointCount
        }
    }

    var _layerFillColor:[CGColor] = []
    var layerFillColor:[CGColor]{
        set{
            _layerFillColor = newValue
        }
        get{
            for layer in layer.sublayers ?? []{
                if layer.isKind(of: CAShapeLayer.self){
                    _layerFillColor.append((layer as! CAShapeLayer).fillColor ?? UIColor.red.cgColor)
                }
            }
            return _layerFillColor
        }
    }
    func drawPolygon() {
        for layer in layer.sublayers ?? []{
            layer.removeFromSuperlayer()
        }
        self.backgroundColor = UIColor.clear
        let circlePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: drawWidth, height: drawHeight))
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.red.cgColor
        circleLayer.lineWidth = 1.0
        self.layer.addSublayer(circleLayer)

        if pointCount < 3 {
            return
        }

        var circleRadius = CGFloat(drawWidth/2/2)
//        circleRadius = sqrt(circleRadius*circleRadius+circleRadius*circleRadius)
        
        let circleCenter = CGPoint(x:drawWidth/2,y:drawHeight/2);
        for index in 0...pointCount-1{
            let path = UIBezierPath()
            path.move(to:circleCenter)
            for i in 0...0{
                let angle = Double(360.0/Float(pointCount) * Float(index+i))
                let sinus = CGFloat(sin(angle * Double.pi / 180))
                let a = sinus * circleRadius
                let cosinus = CGFloat(cos(angle * Double.pi / 180))
                let b = cosinus * circleRadius
                path.addLine(to: CGPoint(x:circleCenter.x+a,y:circleCenter.y+b))
            }
            let angle = Double(360.0/Float(pointCount) * (Float(index)+0.5))
            let sinus = CGFloat(sin(angle * Double.pi / 180))
            let a = sinus * CGFloat(drawWidth/2)
            let cosinus = CGFloat(cos(angle * Double.pi / 180))
            let b = cosinus * CGFloat(drawWidth/2)
            path.addLine(to: CGPoint(x:circleCenter.x+a,y:circleCenter.y+b))
            for i in 1...1{
                let angle = Double(360.0/Float(pointCount) * Float(index+i))
                let sinus = CGFloat(sin(angle * Double.pi / 180))
                let a = sinus * circleRadius
                let cosinus = CGFloat(cos(angle * Double.pi / 180))
                let b = cosinus * circleRadius
                path.addLine(to: CGPoint(x:circleCenter.x+a,y:circleCenter.y+b))
            }
            path.addLine(to:circleCenter)
            path.close()
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.strokeColor = UIColor.red.cgColor
            shapeLayer.fillColor = _layerFillColor.count > index+1 ? _layerFillColor[index+1] : randomColor().cgColor
            shapeLayer.lineWidth = 0
            self.layer.addSublayer(shapeLayer)
        }
    }
}
