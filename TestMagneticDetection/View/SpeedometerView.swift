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

    var rotation: CGFloat = .pi
    var totalAngle: CGFloat = 2 * .pi

    var value: Int = 0 {
        didSet {
            // figure out where the needle is, between 0 and 1
            let needlePosition = CGFloat(value) / 100

            // create a lerp from the start angle (rotation) through to the end angle (rotation + totalAngle)
            let lerpFrom = rotation
            let lerpTo = rotation + totalAngle

            // lerp from the start to the end position, based on the needle's position
            let needleRotation = lerpFrom + (lerpTo - lerpFrom) * needlePosition
            needle.transform = CGAffineTransform(rotationAngle: deg2rad(needleRotation))
        }
    }

    func deg2rad(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }

    var outerCenterDiscColor = UIColor.white
    var outerCenterDiscWidth: CGFloat = 32

    var needleColor = UIColor(white: 0.7, alpha: 1)
    var needleWidth: CGFloat = 4
    let needle = NeedleView()

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        drawWhitheRing()
        drawCenterDisc()
        drawInnerRing()
        drawArrow()
        drawOuterRing()
        drawTriangles()
    }

    func drawArrow() {
        // Определяем точки для стрелки
        let arrowWidth: CGFloat = 7.0
        let arrowHeight: CGFloat = bounds.width / 6.0

        // Создаем контекст рисования
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        // Сохраняем состояние контекста
        ctx.saveGState()
        
        // Перемещаем начало координат в центр прямоугольника
        ctx.translateBy(x: bounds.midX, y: bounds.midY)
        
        // Определяем путь для стрелки
        let arrowPath = UIBezierPath()
        arrowPath.move(to: CGPoint(x: arrowWidth / 2, y: 0))
        arrowPath.addLine(to: CGPoint(x: arrowWidth / 2, y: -arrowHeight))
        arrowPath.addLine(to: CGPoint(x: -arrowWidth / 2, y: 0))
        arrowPath.close()
        
        // Заливаем стрелку цветом
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.addPath(arrowPath.cgPath)
        ctx.fillPath()
        
        // Восстанавливаем состояние контекста
        ctx.restoreGState()
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
                                           radius: radius - 4.0, // Отступ для внутреннего кольца
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

        let triangleHeight: CGFloat = -24.0 // Отрицательная высота треугольника для приближения к центру
        let triangleBase: CGFloat = 6.0 // Длина основания треугольника
        let triangleColor = UIColor.white.cgColor
        
        // Угол между метками
        let angleStep = CGFloat.pi / 12.0 // Например, для 12 меток
        
        // Получаем текущий контекст
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        // Сохраняем состояние контекста
        ctx.saveGState()
        
        // Устанавливаем параметры рисования
        ctx.setFillColor(triangleColor)
        
        // Отрисовываем треугольники
        let triangleAngle = asin(triangleBase / (2 * radius)) // Угол между наконечником треугольника и осью x
        
        for i in 0..<13 {
            let angle = CGFloat(i) * angleStep
            let startX = center.x + (radius - triangleHeight) * cos(angle - triangleAngle) // Поворачиваем на угол triangleAngle
            let startY = center.y - (radius - triangleHeight) * sin(angle - triangleAngle) // Поворачиваем на угол triangleAngle
            let topX = center.x + radius * cos(angle)
            let topY = center.y - radius * sin(angle)
            let endX = center.x + (radius - triangleHeight) * cos(angle + triangleAngle) // Поворачиваем на угол triangleAngle
            let endY = center.y - (radius - triangleHeight) * sin(angle + triangleAngle) // Поворачиваем на угол triangleAngle
            
            // Создаем путь для треугольника
            let path = UIBezierPath()
            path.move(to: CGPoint(x: startX, y: startY))
            path.addLine(to: CGPoint(x: topX, y: topY))
            path.addLine(to: CGPoint(x: endX, y: endY))
            path.close()
            
            // Заливаем треугольник цветом
            ctx.addPath(path.cgPath)
            ctx.fillPath()
        }
        // Восстанавливаем состояние контекста
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

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}


class NeedleView: UIView {
    
    let needle = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupSubviews()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        setupSubviews()
    }
    
    private func setupSubviews() {
        addSubview(needle)

        drawArrow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Размещаем иглу (needle) поверх всех вью
        bringSubviewToFront(needle)
    }
    
    func drawArrow() {
        // Определяем точки для стрелки
        let arrowWidth: CGFloat = 7.0
        let arrowHeight: CGFloat = bounds.width / 6.0

        // Создаем контекст рисования
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        // Сохраняем состояние контекста
        ctx.saveGState()
        
        // Перемещаем начало координат в центр прямоугольника
        ctx.translateBy(x: bounds.midX, y: bounds.midY)
        
        // Определяем путь для стрелки
        let arrowPath = UIBezierPath()
        arrowPath.move(to: CGPoint(x: arrowWidth / 2, y: 0))
        arrowPath.addLine(to: CGPoint(x: arrowWidth / 2, y: -arrowHeight))
        arrowPath.addLine(to: CGPoint(x: -arrowWidth / 2, y: 0))
        arrowPath.close()
        
        // Заливаем стрелку цветом
        ctx.setFillColor(UIColor.red.cgColor)
        ctx.addPath(arrowPath.cgPath)
        ctx.fillPath()
        
        // Восстанавливаем состояние контекста
        ctx.restoreGState()
    }
}
