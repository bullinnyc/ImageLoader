//
//  MulticolorSpinnerView.swift
//  ImageLoader
//
//  Created by Dmitry Kononchuk on 27.02.2022.
//

import UIKit

class MulticolorSpinnerView: UIView {
    // MARK: - Public Properties
    let colors: [UIColor]
    let lineWidth: CGFloat
    
    var isAnimating: Bool = false {
        didSet {
            if isAnimating {
                setPath()
                animateStroke()
                animateRotation()
            } else {
                layer.removeAllAnimations()
                shapeLayer.removeFromSuperlayer()
            }
        }
    }
    
    // MARK: - Private Properties
    private lazy var shapeLayer: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.strokeColor = (colors.first ?? UIColor()).cgColor
        shape.lineWidth = lineWidth
        shape.fillColor = UIColor.clear.cgColor
        shape.lineCap = .round
        return shape
    }()
    
    // MARK: - Initializers
    init(colors: [UIColor], lineWidth: CGFloat) {
        self.colors = colors
        self.lineWidth = lineWidth
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setPath() {
        let path = UIBezierPath(
            ovalIn: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.width)
        )
        
        shapeLayer.path = path.cgPath
    }
    
    private func animateStroke() {
        let startAnimation = animateStroke(
            isStart: true,
            beginTime: 0.25,
            duration: 0.75
        )
        
        let endAnimation = animateStroke(duration: 0.75)
        let strokeAnimationGroup = animateStrokeGroup(start: startAnimation, end: endAnimation)
        let strokeColorAnimation = animateStrokeColor(
            colors: colors.map { $0.cgColor },
            duration: strokeAnimationGroup.duration * Double(colors.count)
        )
        
        shapeLayer.add(strokeAnimationGroup, forKey: nil)
        shapeLayer.add(strokeColorAnimation, forKey: nil)
        layer.addSublayer(shapeLayer)
    }
    
    private func animateRotation() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = 2 * Double.pi
        rotation.duration = 2
        rotation.repeatCount = .infinity
        layer.add(rotation, forKey: nil)
    }
    
    private func animateStroke(isStart: Bool = false, beginTime: Double = 0, fromValue: CGFloat = 0, toValue: CGFloat = 1, duration: Double) -> CABasicAnimation {
        let stroke = CABasicAnimation()
        stroke.keyPath = isStart ? "strokeStart" : "strokeEnd"
        stroke.beginTime = beginTime
        stroke.fromValue = fromValue
        stroke.toValue = toValue
        stroke.duration = duration
        stroke.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        return stroke
    }
    
    private func animateStrokeGroup(start: CABasicAnimation, end: CABasicAnimation) -> CAAnimationGroup {
        let strokeGroup = CAAnimationGroup()
        strokeGroup.duration = 1
        strokeGroup.repeatDuration = .infinity
        strokeGroup.animations = [start, end]
        return strokeGroup
    }
    
    private func animateStrokeColor(colors: [CGColor], duration: Double) -> CAKeyframeAnimation {
        let strokeColor = CAKeyframeAnimation()
        strokeColor.keyPath = "strokeColor"
        strokeColor.values = colors
        strokeColor.duration = duration
        strokeColor.repeatCount = .greatestFiniteMagnitude
        strokeColor.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        return strokeColor
    }
}
