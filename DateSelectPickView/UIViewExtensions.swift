//
//  UIViewExtensions.swift
//  EZSwiftExtensions
//
//  Created by Goktug Yilmaz on 15/07/15.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit

// MARK: Custom UIView Initilizers
extension UIView {
    /// EZSwiftExtensions
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
    }

    /// EZSwiftExtensions, puts padding around the view
    public convenience init(superView: UIView, padding: CGFloat) {
        self.init(frame: CGRect(x: superView.tt_x + padding, y: superView.tt_y + padding, width: superView.tt_width - padding*2, height: superView.tt_height - padding*2))
    }

    /// EZSwiftExtensions - Copies size of superview
    public convenience init(superView: UIView) {
        self.init(frame: CGRect(origin: CGPoint.zero, size: superView.tt_size))
    }
}

// MARK: Frame Extensions
extension UIView {

    /// 添加多个view
    public func tt_addSubviews(_ views: [UIView]) {
        views.forEach { [weak self] eachView in
            self?.addSubview(eachView)
        }
    }

    /// 将view适配到最大的子view
    public func tt_resizeToFitSubviews() {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in self.subviews {
            let aView = someView
            let newWidth = aView.tt_x + aView.tt_width
            let newHeight = aView.tt_y + aView.tt_height
            width = max(width, newWidth)
            height = max(height, newHeight)
        }
        frame = CGRect(x: tt_x, y: tt_y, width: width, height: height)
    }

//    /// EZSwiftExtensions, resizes this view so it fits the largest subview
//    public func resizeToFitSubviews(_ tagsToIgnore: [Int]) {
//        var width: CGFloat = 0
//        var height: CGFloat = 0
//        for someView in self.subviews {
//            let aView = someView
//            if !tagsToIgnore.contains(someView.tag) {
//                let newWidth = aView.x + aView.w
//                let newHeight = aView.y + aView.h
//                width = max(width, newWidth)
//                height = max(height, newHeight)
//            }
//        }
//        frame = CGRect(x: x, y: y, width: width, height: height)
//    }

//    /// EZSwiftExtensions
//    public func resizeToFitWidth() {
//        let currentHeight = self.h
//        self.sizeToFit()
//        self.h = currentHeight
//    }
//
//    /// EZSwiftExtensions
//    public func resizeToFitHeight() {
//        let currentWidth = self.w
//        self.sizeToFit()
//        self.w = currentWidth
//    }

    /// x坐标
    public var tt_x: CGFloat {
        get {
            return self.frame.origin.x
        } set(value) {
            self.frame = CGRect(x: value, y: self.tt_y, width: self.tt_width, height: self.tt_height)
        }
    }

    /// y坐标
    public var tt_y: CGFloat {
        get {
            return self.frame.origin.y
        } set(value) {
            self.frame = CGRect(x: self.tt_x, y: value, width: self.tt_width, height: self.tt_height)
        }
    }

    /// 宽度
    public var tt_width: CGFloat {
        get {
            return self.frame.size.width
        } set(value) {
            self.frame = CGRect(x: self.tt_x, y: self.tt_y, width: value, height: self.tt_height)
        }
    }

    /// 高度
    public var tt_height: CGFloat {
        get {
            return self.frame.size.height
        } set(value) {
            self.frame = CGRect(x: self.tt_x, y: self.tt_y, width: self.tt_width, height: value)
        }
    }

    /// 左边缘点到superView左边距大小
    public var tt_left: CGFloat {
        get {
            return self.tt_x
        } set(value) {
            self.tt_x = value
        }
    }

    /// 右边缘点到superView左边距大小
    public var tt_right: CGFloat {
        get {
            return self.tt_x + self.tt_width
        } set(value) {
            self.tt_x = value - self.tt_width
        }
    }

    /// 上边缘点到superView上边距大小
    public var tt_top: CGFloat {
        get {
            return self.tt_y
        } set(value) {
            self.tt_y = value
        }
    }

    /// 下边缘点到superView上边距大小
    public var tt_bottom: CGFloat {
        get {
            return self.tt_y + self.tt_height
        } set(value) {
            self.tt_y = value - self.tt_height
        }
    }

    
    public var tt_origin: CGPoint {
        get {
            return self.frame.origin
        } set(value) {
            self.frame = CGRect(origin: value, size: self.frame.size)
        }
    }

    /// view中心点x
    public var tt_centerX: CGFloat {
        get {
            return self.center.x
        } set(value) {
            self.center.x = value
        }
    }

    /// view中心点y
    public var tt_centerY: CGFloat {
        get {
            return self.center.y
        } set(value) {
            self.center.y = value
        }
    }

    /// view大小
    public var tt_size: CGSize {
        get {
            return self.frame.size
        } set(value) {
            self.frame = CGRect(origin: self.frame.origin, size: value)
        }
    }

    /// 向左移动
    public func tt_leftOffset(_ offset: CGFloat) -> CGFloat {
        return self.tt_left - offset
    }

    /// 向右移动
    public func tt_rightOffset(_ offset: CGFloat) -> CGFloat {
        return self.tt_right + offset
    }

    /// 向上移动
    public func tt_topOffset(_ offset: CGFloat) -> CGFloat {
        return self.tt_top - offset
    }

    /// 向下移动
    public func tt_bottomOffset(_ offset: CGFloat) -> CGFloat {
        return self.tt_bottom + offset
    }

//    /// EZSwiftExtensions
//    public func alignRight(_ offset: CGFloat) -> CGFloat {
//        return self.w - offset
//    }

//    /// EZSwiftExtensions
//    public func reorderSubViews(_ reorder: Bool = false, tagsToIgnore: [Int] = []) -> CGFloat {
//        var currentHeight: CGFloat = 0
//        for someView in subviews {
//            if !tagsToIgnore.contains(someView.tag) && !(someView ).isHidden {
//                if reorder {
//                    let aView = someView
//                    aView.frame = CGRect(x: aView.frame.origin.x, y: currentHeight, width: aView.frame.width, height: aView.frame.height)
//                }
//                currentHeight += someView.frame.height
//            }
//        }
//        return currentHeight
//    }

    // 移除子view
    public func tt_removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }

    /// 横向居中
    public func tt_centerXInSuperView() {
        guard let parentView = superview else {
            assertionFailure("EZSwiftExtensions Error: The view \(self) doesn't have a superview")
            return
        }

        self.tt_x = parentView.tt_width/2 - self.tt_width/2
    }

    ///纵向居中
    public func tt_centerYInSuperView() {
        guard let parentView = superview else {
            assertionFailure("EZSwiftExtensions Error: The view \(self) doesn't have a superview")
            return
        }

        self.tt_y = parentView.tt_height/2 - self.tt_height/2
    }

    /// 整体居中
    public func tt_centerInSuperView() {
        self.tt_centerXInSuperView()
        self.tt_centerYInSuperView()
    }
}

// MARK: Transform Extensions
extension UIView {
    /// x轴移动
    public func tt_setRotationX(_ x: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, x.tt_degreesToRadians(), 1.0, 0.0, 0.0)
        self.layer.transform = transform
    }

    /// y轴移动
    public func tt_setRotationY(_ y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, y.tt_degreesToRadians(), 0.0, 1.0, 0.0)
        self.layer.transform = transform
    }

    /// z轴移动
    public func tt_setRotationZ(_ z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, z.tt_degreesToRadians(), 0.0, 0.0, 1.0)
        self.layer.transform = transform
    }

    /// 自定义移动
    public func tt_setRotation(x: CGFloat, y: CGFloat, z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, x.tt_degreesToRadians(), 1.0, 0.0, 0.0)
        transform = CATransform3DRotate(transform, y.tt_degreesToRadians(), 0.0, 1.0, 0.0)
        transform = CATransform3DRotate(transform, z.tt_degreesToRadians(), 0.0, 0.0, 1.0)
        self.layer.transform = transform
    }

    ///
    public func tt_setScale(x: CGFloat, y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DScale(transform, x, y, 1)
        self.layer.transform = transform
    }
}

// MARK: Layer Extensions
extension UIView {
    /// 圆角设置
    public func tt_setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    /// 添加阴影
    public func tt_addShadow(offset: CGSize, radius: CGFloat, color: UIColor, opacity: Float, cornerRadius: CGFloat? = nil) {
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        if let r = cornerRadius {
            self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
        }
    }

    /// 添加边框
    public func tt_addBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
    }

    /// EZSwiftExtensions
    public func tt_addBorderTop(size: CGFloat, color: UIColor) {
        tt_addBorderUtility(x: 0, y: 0, width: frame.width, height: size, color: color)
    }

    /// EZSwiftExtensions
    public func tt_addBorderTopWithPadding(size: CGFloat, color: UIColor, padding: CGFloat) {
        tt_addBorderUtility(x: padding, y: 0, width: frame.width - padding*2, height: size, color: color)
    }

    /// EZSwiftExtensions
    public func tt_addBorderBottom(size: CGFloat, color: UIColor) {
        tt_addBorderUtility(x: 0, y: frame.height - size, width: frame.width, height: size, color: color)
    }

    /// EZSwiftExtensions
    public func tt_addBorderLeft(size: CGFloat, color: UIColor) {
        tt_addBorderUtility(x: 0, y: 0, width: size, height: frame.height, color: color)
    }

    /// EZSwiftExtensions
    public func tt_addBorderRight(size: CGFloat, color: UIColor) {
        tt_addBorderUtility(x: frame.width - size, y: 0, width: size, height: frame.height, color: color)
    }

    /// 自定义覆盖
    fileprivate func tt_addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
    /// 在view上添加圆形
    public func tt_drawCircle(fillColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.tt_width, height: self.tt_width), cornerRadius: self.tt_width/2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        self.layer.addSublayer(shapeLayer)
    }
    //TODO: add this to readme
    /// EZSwiftExtensions
    public func tt_drawStroke(width: CGFloat, color: UIColor) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.tt_width, height: self.tt_width), cornerRadius: self.tt_width/2)
        let shapeLayer = CAShapeLayer ()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        self.layer.addSublayer(shapeLayer)
    }
}

private let UIViewAnimationDuration: TimeInterval = 1
private let UIViewAnimationSpringDamping: CGFloat = 0.5
private let UIViewAnimationSpringVelocity: CGFloat = 0.5

// MARK: Animation Extensions
extension UIView {
    /// EZSwiftExtensions
    public func tt_spring(animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        tt_spring(duration: UIViewAnimationDuration, animations: animations, completion: completion)
    }

    /// EZSwiftExtensions
    public func tt_spring(duration: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: UIViewAnimationDuration,
            delay: 0,
            usingSpringWithDamping: UIViewAnimationSpringDamping,
            initialSpringVelocity: UIViewAnimationSpringVelocity,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: animations,
            completion: completion
        )
    }

    /// EZSwiftExtensions
    public func tt_animate(duration: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: animations, completion: completion)
    }

    /// EZSwiftExtensions
    public func tt_animate(animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        tt_animate(duration: UIViewAnimationDuration, animations: animations, completion: completion)
    }

    /// EZSwiftExtensions
    public func tt_pop() {
        tt_setScale(x: 1.1, y: 1.1)
        tt_spring(duration: 0.2, animations: { [unowned self] () -> Void in
            self.tt_setScale(x: 1, y: 1)
            })
    }

    /// EZSwiftExtensions
    public func tt_popBig() {
        tt_setScale(x: 1.25, y: 1.25)
        tt_spring(duration: 0.2, animations: { [unowned self] () -> Void in
            self.tt_setScale(x: 1, y: 1)
            })
    }

    //EZSE: Reverse pop, good for button animations
    public func tt_reversePop() {
        tt_setScale(x: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.05, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: { [weak self] Void in
            self?.tt_setScale(x: 1, y: 1)
        }) { (bool) in }
    }
}

// MARK: Render Extensions
extension UIView {
    /// 转换为图片
    public func tt_toImage () -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

// MARK: Gesture Extensions
extension UIView {
    /// http://stackoverflow.com/questions/4660371/how-to-add-a-touch-event-to-a-uiview/32182866#32182866
    /// 添加点击手势
    public func tt_addTapGesture(tapNumber: Int = 1, target: AnyObject, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }

    /// EZSwiftExtensions - Make sure you use  "[weak self] (gesture) in" if you are using the keyword self inside the closure or there might be a memory leak
    public func tt_addTapGesture(tapNumber: Int = 1, action: ((UITapGestureRecognizer) -> Void)?) {
        let tap = BlockTap(tapCount: tapNumber, fingerCount: 1, action: action)
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }

    /// EZSwiftExtensions
    public func tt_addSwipeGesture(direction: UISwipeGestureRecognizerDirection, numberOfTouches: Int = 1, target: AnyObject, action: Selector) {
        let swipe = UISwipeGestureRecognizer(target: target, action: action)
        swipe.direction = direction

        #if os(iOS)

        swipe.numberOfTouchesRequired = numberOfTouches

        #endif

        addGestureRecognizer(swipe)
        isUserInteractionEnabled = true
    }

    /// EZSwiftExtensions - Make sure you use  "[weak self] (gesture) in" if you are using the keyword self inside the closure or there might be a memory leak
    public func tt_addSwipeGesture(direction: UISwipeGestureRecognizerDirection, numberOfTouches: Int = 1, action: ((UISwipeGestureRecognizer) -> Void)?) {
        let swipe = BlockSwipe(direction: direction, fingerCount: numberOfTouches, action: action)
        addGestureRecognizer(swipe)
        isUserInteractionEnabled = true
    }

    /// EZSwiftExtensions
    public func tt_addPanGesture(target: AnyObject, action: Selector) {
        let pan = UIPanGestureRecognizer(target: target, action: action)
        addGestureRecognizer(pan)
        isUserInteractionEnabled = true
    }

    /// EZSwiftExtensions - Make sure you use  "[weak self] (gesture) in" if you are using the keyword self inside the closure or there might be a memory leak
    public func tt_addPanGesture(action: ((UIPanGestureRecognizer) -> Void)?) {
        let pan = BlockPan(action: action)
        addGestureRecognizer(pan)
        isUserInteractionEnabled = true
    }

    #if os(iOS)

    /// EZSwiftExtensions
    public func tt_addPinchGesture(target: AnyObject, action: Selector) {
        let pinch = UIPinchGestureRecognizer(target: target, action: action)
        addGestureRecognizer(pinch)
        isUserInteractionEnabled = true
    }

    #endif

    #if os(iOS)

    /// EZSwiftExtensions - Make sure you use  "[weak self] (gesture) in" if you are using the keyword self inside the closure or there might be a memory leak
    public func tt_addPinchGesture(action: ((UIPinchGestureRecognizer) -> Void)?) {
        let pinch = BlockPinch(action: action)
        addGestureRecognizer(pinch)
        isUserInteractionEnabled = true
    }

    #endif

    /// EZSwiftExtensions
    public func tt_addLongPressGesture(target: AnyObject, action: Selector) {
        let longPress = UILongPressGestureRecognizer(target: target, action: action)
        addGestureRecognizer(longPress)
        isUserInteractionEnabled = true
    }

    /// EZSwiftExtensions - Make sure you use  "[weak self] (gesture) in" if you are using the keyword self inside the closure or there might be a memory leak
    public func tt_addLongPressGesture(action: ((UILongPressGestureRecognizer) -> Void)?) {
        let longPress = BlockLongPress(action: action)
        addGestureRecognizer(longPress)
        isUserInteractionEnabled = true
    }
}

//TODO: add to readme
extension UIView {
    /// EZSwiftExtensions [UIRectCorner.TopLeft, UIRectCorner.TopRight]
    public func tt_roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    /// EZSwiftExtensions - Mask square/rectangle UIView with a circular/capsule cover, with a border of desired color and width around it
    public func tt_roundView(withBorderColor color: UIColor? = nil, withBorderWidth width: CGFloat? = nil) {
        self.tt_setCornerRadius(radius: min(self.frame.size.height, self.frame.size.width) / 2)
        self.layer.borderWidth = width ?? 0
        self.layer.borderColor = color?.cgColor ?? UIColor.clear.cgColor
    }
    
    /// EZSwiftExtensions - Remove all masking around UIView
    public func tt_nakedView() {
        self.layer.mask = nil
        self.layer.borderWidth = 0
    }
}

extension UIView {
    ///EZSE: Shakes the view for as many number of times as given in the argument.
    public func tt_shakeViewForTimes(_ times: Int) {
        let anim = CAKeyframeAnimation(keyPath: "transform")
        anim.values = [
            NSValue(caTransform3D: CATransform3DMakeTranslation(-5, 0, 0 )),
            NSValue(caTransform3D: CATransform3DMakeTranslation( 5, 0, 0 ))
        ]
        anim.autoreverses = true
        anim.repeatCount = Float(times)
        anim.duration = 7/100

        self.layer.add(anim, forKey: nil)
    }
}

extension UIView {
    ///EZSE: Loops until it finds the top root view. //TODO: Add to readme
    func tt_rootView() -> UIView {
        guard let parentView = superview else {
            return self
        }
        return parentView.tt_rootView()
    }
}

// MARK: Fade Extensions

private let UIViewDefaultFadeDuration: TimeInterval = 0.4

extension UIView {
    ///EZSE: Fade in with duration, delay and completion block.
    public func tt_fadeIn(_ duration: TimeInterval? = UIViewDefaultFadeDuration, delay: TimeInterval? = 0.0, completion: ((Bool) -> Void)? = nil) {
        tt_fadeTo(1.0, duration: duration, delay: delay, completion: completion)
    }

    /// EZSwiftExtensions
    public func tt_fadeOut(_ duration: TimeInterval? = UIViewDefaultFadeDuration, delay: TimeInterval? = 0.0, completion: ((Bool) -> Void)? = nil) {
        tt_fadeTo(0.0, duration: duration, delay: delay, completion: completion)
    }

    /// Fade to specific value	 with duration, delay and completion block.
    public func tt_fadeTo(_ value: CGFloat, duration: TimeInterval? = UIViewDefaultFadeDuration, delay: TimeInterval? = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration ?? UIViewDefaultFadeDuration, delay: delay ?? UIViewDefaultFadeDuration, options: .curveEaseInOut, animations: {
            self.alpha = value
        }, completion: completion)
    }
}

#endif
