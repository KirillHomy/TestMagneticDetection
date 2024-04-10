//
//  SpeedometerView.swift
//  TestMagneticDetection
//
//  Created by Kirill Khomicevich on 09.04.2024.
//

import Foundation
import UIKit
import SnapKit

class SpeedometerView: UIView {

    // MARK: - Private property
    private let triangleLayer = CAShapeLayer()
    private var rotation: CGFloat =  3 * CGFloat.pi / 2.03
    private var totalAngle: CGFloat = .pi
    private var outerCenterDiscColor = UIColor.white
    private var outerCenterDiscWidth: CGFloat = 32

    // MARK: - Interface property
    var value: Int = 0 {
        didSet {
            let needlePosition = CGFloat(value) / 100

            let startAngle: CGFloat = 0
            let endAngle = totalAngle

            let needleRotation = startAngle + (endAngle - startAngle) * needlePosition
            
            animateRotation(needleRotation: needleRotation)
        }
    }

    // MARK: - Draw
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        drawWhitheRing()
        drawCenterDisc()
        drawInnerRing()
        drawArrow()
        drawOuterRing()
        drawTriangles()
    }
}

// MARK: - Private methods
private extension SpeedometerView {
    
    func drawArrow() {
        // 1
        let arrowWidth: CGFloat = 7.0
        let arrowHeight: CGFloat = bounds.width / 6.0
        // 2
        let frame = CGRect(x: bounds.midX,
                           y: bounds.midY,
                           width: 0,
                           height: 0)
        
        triangleLayer.frame = frame
        
        // 3
        let needlePath = UIBezierPath()
        needlePath.move(to: CGPoint(x: arrowWidth / 2, y: 0))
        needlePath.addLine(to: CGPoint(x: arrowWidth / 2, y: -arrowHeight))
        needlePath.addLine(to: CGPoint(x: -arrowWidth / 2, y: 0))
        
        needlePath.close()
        let rotationAngle = rotation
        
        needlePath.apply(CGAffineTransform(rotationAngle: rotationAngle))

        // 4
        triangleLayer.path = needlePath.cgPath
        
        // 5
        triangleLayer.fillColor = UIColor.white.cgColor
        triangleLayer.strokeColor = UIColor.white.cgColor
        // 6
        layer.addSublayer(triangleLayer)
        
        // 7 П
        triangleLayer.transform = CATransform3DMakeRotation(0, 0, 0, 1)
    }

    func animateRotation(needleRotation: CGFloat) {
        guard let presentationLayer = triangleLayer.presentation(), let currentRotation = presentationLayer.value(forKeyPath: "transform.rotation.z") as? CGFloat else {
            return
        }

        let spinAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        spinAnimation.fromValue = currentRotation
        spinAnimation.toValue = needleRotation
        spinAnimation.duration = 0.5 // Продолжительность анимации
        spinAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

        CATransaction.begin()
        triangleLayer.transform = CATransform3DMakeRotation(needleRotation, 0, 0, 1)
        triangleLayer.add(spinAnimation, forKey: "rotationAnimation")
        CATransaction.commit()
    }

    func drawCenterDisc() {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }

        ctx.saveGState()
        ctx.translateBy(x: bounds.midX, y: bounds.midY)

        let outerCenterRect = CGRect(x: -outerCenterDiscWidth / 2,
                                     y: -outerCenterDiscWidth / 2,
                                     width: outerCenterDiscWidth,
                                     height: outerCenterDiscWidth)
        outerCenterDiscColor.set()
        ctx.fillEllipse(in: outerCenterRect)

        ctx.restoreGState()
    }

    func drawWhitheRing() {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let circleFrame = UIScreen.main.bounds.width - 20 * 2
        let radius = circleFrame / 2

        let outerCirclePath = UIBezierPath(arcCenter: center,
                                           radius: radius - 4.0,
                                           startAngle: .pi,
                                           endAngle: .pi * 2,
                                           clockwise: true)

        let whiteCircleLayer = CAShapeLayer()
        whiteCircleLayer.path = outerCirclePath.cgPath
        whiteCircleLayer.lineCap = .round
        whiteCircleLayer.lineWidth = 8.0
        whiteCircleLayer.strokeColor = UIColor(hex: "E2DBFF").cgColor
        whiteCircleLayer.fillColor = UIColor.clear.cgColor

        layer.addSublayer(whiteCircleLayer)
    }

    func drawTriangles() {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let circleFrame = UIScreen.main.bounds.width - 20 * 2
        let radius = circleFrame / 2.0 - 24.0

        let triangleHeight: CGFloat = -24.0
        let triangleBase: CGFloat = 6.0
        let triangleColor = UIColor.white.cgColor
        
        let angleStep = CGFloat.pi / 12.0
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        ctx.saveGState()
        
        ctx.setFillColor(triangleColor)
        
        let triangleAngle = asin(triangleBase / (2 * radius))
        
        for i in 0..<13 {
            let angle = CGFloat(i) * angleStep
            let startX = center.x + (radius - triangleHeight) * cos(angle - triangleAngle)
            let startY = center.y - (radius - triangleHeight) * sin(angle - triangleAngle)
            let topX = center.x + radius * cos(angle)
            let topY = center.y - radius * sin(angle)
            let endX = center.x + (radius - triangleHeight) * cos(angle + triangleAngle)
            let endY = center.y - (radius - triangleHeight) * sin(angle + triangleAngle)
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: startX, y: startY))
            path.addLine(to: CGPoint(x: topX, y: topY))
            path.addLine(to: CGPoint(x: endX, y: endY))
            path.close()
            
            ctx.addPath(path.cgPath)
            ctx.fillPath()
        }
        ctx.restoreGState()
    }

    func drawOuterRing() {
        let circleFrame = UIScreen.main.bounds.width - 35 * 2
        let radius = circleFrame / 2
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let startAngle = CGFloat.pi
        let endAngle = 2 * CGFloat.pi

        let outerCirclePath = UIBezierPath(arcCenter: center,
                                           radius: radius,
                                           startAngle: startAngle,
                                           endAngle: endAngle,
                                           clockwise: true)

        let outerGradientLayer = CAGradientLayer()
        outerGradientLayer.frame = bounds
        outerGradientLayer.colors = [UIColor(hex: "070616").withAlphaComponent(0.7).cgColor,
                                     UIColor(hex: "21B400").withAlphaComponent(0.7).cgColor,
                                     UIColor(hex: "E9DF00").withAlphaComponent(0.7).cgColor,
                                     UIColor(hex: "070616").withAlphaComponent(0.7).cgColor,
                                     UIColor(hex: "FF0000").withAlphaComponent(0.7).cgColor]
        outerGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        outerGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        let outerMaskLayer = CAShapeLayer()
        outerMaskLayer.path = outerCirclePath.cgPath
        outerMaskLayer.lineWidth = 15.0
        outerMaskLayer.strokeEnd = 1.0
        outerMaskLayer.fillColor = UIColor.clear.cgColor
        outerMaskLayer.strokeColor = UIColor.black.cgColor
        outerMaskLayer.lineCap = .butt

        outerGradientLayer.mask = outerMaskLayer

        outerMaskLayer.strokeEnd = 1.0

        layer.addSublayer(outerGradientLayer)
    }

    func drawInnerRing() {
        let circleFrame = UIScreen.main.bounds.width - 35 * 2
        let radius = circleFrame / 6.0
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let startAngle = CGFloat.pi
        let endAngle = 2 * CGFloat.pi

        let innerCirclePath = UIBezierPath(arcCenter: center,
                                           radius: radius,
                                           startAngle: startAngle,
                                           endAngle: endAngle,
                                           clockwise: true)

        let innerGradientLayer = CAGradientLayer()
        innerGradientLayer.frame = bounds
        innerGradientLayer.colors = [
            UIColor(hex: "070616").cgColor,
            UIColor(hex: "6952CA").cgColor,
            UIColor(hex: "070616").cgColor]
        innerGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        innerGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        let innerMaskLayer = CAShapeLayer()
        innerMaskLayer.path = innerCirclePath.cgPath
        innerMaskLayer.lineWidth = 9.0
        innerMaskLayer.strokeEnd = 1.0
        innerMaskLayer.fillColor = UIColor.clear.cgColor
        innerMaskLayer.strokeColor = UIColor.black.cgColor
        innerMaskLayer.lineCap = .square

        innerGradientLayer.mask = innerMaskLayer

        layer.addSublayer(innerGradientLayer)
    }
}
