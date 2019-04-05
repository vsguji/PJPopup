// KLCPopup.h
//
// Created by Jeff Mascia
// Copyright (c) 2013-2014 Kullect Inc. (http://kullect.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


// KLCPopupShowType: Controls how the popup will be presented.

import Foundation
import UIKit

// MARK:- PJPopupShowType:控制弹出框的显示方式。
enum PJPopupShowType{
    case PJPopupShowTypeNode
    case PJPopupShowTypeFadeIn
    case PJPopupShowTypeGrowIn
    case PJPopupShowTypeShrinkIn
    case PJPopupShowTypeSlideInFromTop
    case PJPopupShowTypeSlideInFromBottom
    case PJPopupShowTypeSlideInFromLeft
    case PJPopupShowTypeSlideInFromRight
    case PJPopupShowTypeBoundIn
    case PJPopupShowTypeBounceInFromTop
    case PJPopupShowTypeBounceInFromBottom
    case PJPopupShowTypeBounceInFromLeft
    case PJPopupShowTypeBounceInFromRight
}

// MARK:-  PJPopupDismissTye:控制如何取消弹出框。
enum PJPopupDismissTye {
    case PJPopupDismissTyeNode
    case PJPopupDismissTyeFadeOut
    case PJPopupDismissTyeGrowOut
    case PJPopupDismissTyeShrinkOut
    case PJPopupDismissTyeSlideOutToTop
    case PJPopupDismissTyeSlideOutToBottom
    case PJPopupDismissTyeSlideOutToLeft
    case PJPopupDismissTyeSlideOutToRight
    case PJPopupDismissTyeBoundOut
    case PJPopupDismissTyeBounceOutToTop
    case PJPopupDismissTyeBounceOutToBottom
    case PJPopupDismissTyeBounceOutToLeft
    case PJPopupDismissTyeBounceOutToRight
}


// MARK:- KLCPopupHorizontalLayout:控制弹出窗口水平放置的位置。
enum PJPopupHorizontalLayout {
    case PJPopupHorizontalLayoutCustom
    case PJPopupHorizontalLayoutLeft
    case PJPopupHorizontalLayoutLeftOfCenter
    case PJPopupHorizontalLayoutCenter
    case PJPopupHorizontalLayoutRightCenter
    case PJPopupHorizontalLayoutRight
}

// MARK:- KLCPopupVerticalLayout:控制弹出框垂直放置的位置。
enum PJPopupVerticalLayout {
    case PJPopupVerticalLayoutCustom
    case PJPopupVerticalLayoutTop
    case PJPopupVerticalLayoutAboveCenter
    case PJPopupVerticalLayoutCenter
    case PJPopupVerticalLayoutBelowCenter
    case PJPopupVerticalLayoutBottom
}


// MARK:-
enum PJPopupMaskType {
    case PJPopupMaskTypeNone // 允许与底层视图交互。
    case PJPopupMaskTypeClear // 不允许与底层视图交互。
    case PJPopupMaskTypeDimmed // 不允许与底层视图、模糊背景进行交互。
}

struct PJPopupLayout {
    var horizontal:PJPopupHorizontalLayout = .PJPopupHorizontalLayoutCustom
    var vertical:PJPopupVerticalLayout = .PJPopupVerticalLayoutCustom
    
    init(horizontal:PJPopupHorizontalLayout,vertical:PJPopupVerticalLayout) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
    
    init() {
        
    }
//   override init() {
//        super.init()
//    }
    
//    required init(coder aDecoder: NSCoder) {
//        super.init()
//        horizontal = aDecoder.decodeObject(forKey: "horizontal") as! PJPopupHorizontalLayout
//        vertical = aDecoder.decodeObject(forKey: "vertical") as! PJPopupVerticalLayout
//    }
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(horizontal, forKey: "horizontal")
//        aCoder.encode(vertical,forKey: "vertical")
//    }
}

typealias  PopupLayout = PJPopupLayout


struct PJPopupLayoutMake {
    
    static let PJPopupLayoutCenter = PJPopupLayout(horizontal: PJPopupHorizontalLayout.PJPopupHorizontalLayoutCenter, vertical: PJPopupVerticalLayout.PJPopupVerticalLayoutCenter)
    
    static func PJPopupLayoutMake(_ horizontal:PJPopupHorizontalLayout,_ vertical:PJPopupVerticalLayout) -> PJPopupLayout {
        var  layout = PJPopupLayout()
        layout.horizontal =  horizontal
        layout.vertical  = vertical
        return layout
    }
}

let kAnimationOptionCurveIOS7 = 7 << 16

typealias didFinishShowingCompletion=()->Void
typealias willStartDismissingCompletion=()->Void
typealias didFinishDismissingCompletion=()->Void

class PJPopup:UIView {
    
    //这是您想要在弹出窗口中显示的视图。
    // -必须在willstartshow之前或中提供contentView。
    // -必须在willstartshow之前或中设置所需的contentView大小。
    var contentView:UIView?
    
    // 显示contentView的动画转换。默认值=收缩
    var showType:PJPopupShowType = .PJPopupShowTypeShrinkIn
    
    // 动画转换，取消contentView。默认值=缩小
    var dismissType:PJPopupDismissTye = .PJPopupDismissTyeShrinkOut
    
    // 遮罩防止后台触摸传递到底层视图。默认=变暗。
    var maskType:PJPopupMaskType = .PJPopupMaskTypeDimmed
    
    // 覆盖背景蒙版的alpha值。默认= 0.5
    var dimmedMaskAlpha:CGFloat = 0.5
    
    // 如果是，那么当背景被触摸时，弹出框将被取消。默认= YES。
    var shouldDismissOnBackgroundTouch:Bool = true
    
    // 如果是，那么当内容视图被触摸时，弹出框将被取消。默认= NO。
    var shouldDismissOnContentTouch:Bool = false
    
    // 块在显示动画完成后被调用。确保使用弱引用在块内弹出，以避免保留循环。
    var didFinishShowingCompletion:didFinishShowingCompletion?
    
    // 块在动画开始时被调用。确保使用弱引用在块内弹出，以避免保留循环。
    var willStartDismissingCompletion:willStartDismissingCompletion?
    
    // 块在解散动画完成后被调用。确保使用弱引用在块内弹出，以避免保留循环
    var didFinishDismissingCompletion:didFinishDismissingCompletion?
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        isUserInteractionEnabled = true
        backgroundColor = UIColor.clear
        alpha = 0.0
        autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
        autoresizesSubviews = true
        
        shouldDismissOnBackgroundTouch = true
        shouldDismissOnContentTouch = false
        
        showType = .PJPopupShowTypeShrinkIn
        dismissType = .PJPopupDismissTyeShrinkOut
        maskType = .PJPopupMaskTypeDimmed
        dimmedMaskAlpha = 0.5
        
        isBeingShown = false
        isShowing = false
        isBeingDismissed = false
        
        backgroundView = UIView()
        backgroundView?.backgroundColor = UIColor.clear
        backgroundView?.isUserInteractionEnabled = false
        backgroundView?.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
        backgroundView?.frame = self.bounds
        
        
        containerView = UIView()
        containerView?.autoresizesSubviews = false
        containerView?.isUserInteractionEnabled = true
        containerView?.backgroundColor = UIColor.clear
        
        addSubview(backgroundView!)
        addSubview(containerView!)
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didChangeStatusBarOrientation(_:)),
                                               name: UIApplication.didChangeStatusBarOrientationNotification, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        NotificationCenter.default.removeObserver(self)
    }

    struct PJPopupManager {
         static let _sharePopup = PJPopup()
    }
    
    // 只读属性
    fileprivate(set) var backgroundView:UIView?
    fileprivate(set) var containerView:UIView?
    fileprivate(set) var isBeingShown:Bool?
    fileprivate(set) var isShowing:Bool?
    fileprivate(set) var isBeingDismissed:Bool?
    
    // MARK:- UIView
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if hitView == self {
            if shouldDismissOnBackgroundTouch {
                self.dismiss(animated: true)
            }
            
            if maskType == .PJPopupMaskTypeNone {
                return nil
            }
            else {
                return hitView
            }
            
        }
        else {
            if hitView?.isDescendant(of: containerView!) == true {
                if shouldDismissOnContentTouch {
                    self.dismiss(animated: true)
                }
            }
            return hitView
        }
    }
    
    // MAKR: - 消失
    func dismiss(animated:Bool){
        if isShowing == true && isBeingDismissed == false {
            isBeingShown = false
            isShowing = false
            isBeingDismissed = true
            
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(dismissFunc), object: nil)
            
             self.willStartDismissing()
            
            if self.willStartDismissingCompletion != nil {
                self.willStartDismissingCompletion!()
            }
        
            DispatchQueue.main.async(execute: DispatchWorkItem.init(block: {
                // 如果需要动画背景
                let backgroundAnimationBlock:(()->Void) = {
                    self.backgroundView?.alpha = 0.0
                }
                if animated && (self.showType != .PJPopupShowTypeNode) {
                    UIView.animate(withDuration: 0.15,
                                   delay: 0,
                                   options: UIView.AnimationOptions(rawValue: UInt(UIView.AnimationCurve.linear.rawValue)),
                                   animations: backgroundAnimationBlock,
                                   completion: nil)
                }
                else {
                    backgroundAnimationBlock()
                }
                
                // 设置完成块
                let completionBlock:((Bool)->Void) = { finished in
                    self.removeFromSuperview()
                    self.isBeingShown = false
                    self.isShowing = false
                    self.isBeingDismissed = false
                    self.didFinishDismissing()
                    if  self.didFinishShowingCompletion != nil {
                        self.didFinishShowingCompletion!()
                    }
                }
                let bounce1Duration:TimeInterval = 0.13
                let bounce2Duration:TimeInterval = bounce1Duration * 2.0
                // 如果需要动画内容
                if animated {
                    switch (self.dismissType){
                    case .PJPopupDismissTyeFadeOut:
                        UIView.animate(withDuration:0.15,
                                       delay: 0,
                                       options: UIView.AnimationOptions.init(rawValue: UInt(UIView.AnimationCurve.linear.rawValue)),
                                       animations: {
                                        self.containerView!.alpha = 0.0
                        }, completion: completionBlock)
                        break
                    case .PJPopupDismissTyeGrowOut:
                        UIView.animate(withDuration:0.15,
                                       delay: 0,
                                       options: UIView.AnimationOptions.init(rawValue: UInt(kAnimationOptionCurveIOS7)),
                                       animations: {
                                        self.containerView!.alpha = 0.0
                        }, completion: completionBlock)
                        break
                    case .PJPopupDismissTyeShrinkOut:
                        UIView.animate(withDuration:0.15,
                                       delay: 0,
                                       options: UIView.AnimationOptions.init(rawValue: UInt(kAnimationOptionCurveIOS7)),
                                       animations: {
                                        self.containerView!.alpha = 0.0
                                        self.containerView!.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                        }, completion: completionBlock)
                        break
                    case .PJPopupDismissTyeSlideOutToTop:
                        UIView.animate(withDuration:0.30,
                                       delay: 0,
                                       options: UIView.AnimationOptions.init(rawValue: UInt(kAnimationOptionCurveIOS7)),
                                       animations: {
                                        var  finalFrame:CGRect = self.containerView!.frame
                                        finalFrame.origin.y -= finalFrame.height
                                        self.containerView!.frame = finalFrame
                        }, completion: completionBlock)
                        break
                    case .PJPopupDismissTyeSlideOutToBottom:
                        UIView.animate(withDuration:0.30,
                                       delay: 0,
                                       options: UIView.AnimationOptions.init(rawValue: UInt(kAnimationOptionCurveIOS7)),
                                       animations: {
                                        var finalFrame: CGRect = self.containerView!.frame
                                        finalFrame.origin.y = self.bounds.height
                                        self.containerView!.frame = finalFrame
                        }, completion: completionBlock)
                        break
                    case .PJPopupDismissTyeSlideOutToLeft:
                        UIView.animate(withDuration:0.30,
                                       delay: 0,
                                       options: UIView.AnimationOptions.init(rawValue: UInt(kAnimationOptionCurveIOS7)),
                                       animations: {
                                        var finalFrame: CGRect = self.containerView!.frame
                                        finalFrame.origin.x = -finalFrame.width
                                        self.containerView!.frame = finalFrame
                        }, completion: completionBlock)
                        break
                    case .PJPopupDismissTyeSlideOutToRight:
                        UIView.animate(withDuration:0.30,
                                       delay: 0,
                                       options: UIView.AnimationOptions.init(rawValue: UInt(kAnimationOptionCurveIOS7)),
                                       animations: {
                                        var finalFrame: CGRect = self.containerView!.frame
                                        finalFrame.origin.x = self.bounds.width
                                        self.containerView!.frame = finalFrame

                        }, completion: completionBlock)
                        break
                    case .PJPopupDismissTyeBoundOut:
                        UIView.animate(withDuration:bounce1Duration,
                                       delay: 0,
                                       options: UIView.AnimationOptions.init(rawValue: UInt(UIView.AnimationCurve.easeOut.rawValue)),
                                       animations: {
                                       self.containerView!.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                        }, completion:{ finished in
                            UIView.animate(withDuration: bounce2Duration, delay: 0, options: .curveEaseIn, animations: {
                                self.containerView!.alpha = 0.0
                                self.containerView!.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                            }, completion: completionBlock)
                        })
                        break
                    case .PJPopupDismissTyeBounceOutToTop:
                        UIView.animate(withDuration:bounce1Duration,
                                       delay: 0,
                                       options: UIView.AnimationOptions.init(rawValue: UInt(UIView.AnimationCurve.easeOut.rawValue)),
                                       animations: {
                                        var finalFrame: CGRect = self.containerView!.frame
                                        finalFrame.origin.y += 40.0
                                        self.containerView!.frame = finalFrame
                        }, completion:{ finished in
                            UIView.animate(withDuration: bounce2Duration, delay: 0, options: .curveEaseIn, animations: {
                                var finalFrame: CGRect = self.containerView!.frame
                                finalFrame.origin.y = -finalFrame.height
                                self.containerView!.frame = finalFrame
                            }, completion: completionBlock)
                        })
                        break
                    case .PJPopupDismissTyeBounceOutToBottom:
                        UIView.animate(withDuration:bounce1Duration,
                                       delay: 0,
                                       options: UIView.AnimationOptions.init(rawValue: UInt(UIView.AnimationCurve.easeOut.rawValue)),
                                       animations: {
                                        var finalFrame: CGRect = self.containerView!.frame
                                        finalFrame.origin.y -= 40.0
                                        self.containerView!.frame = finalFrame
                        }, completion:{ finished in
                            UIView.animate(withDuration: bounce2Duration, delay: 0, options: .curveEaseIn, animations: {
                                var finalFrame: CGRect = self.containerView!.frame
                                finalFrame.origin.y = self.bounds.height
                                self.containerView!.frame = finalFrame
                            }, completion: completionBlock)
                        })
                        break
                    case .PJPopupDismissTyeBounceOutToLeft:
                        UIView.animate(withDuration:bounce1Duration,
                                       delay: 0,
                                       options: UIView.AnimationOptions.init(rawValue: UInt(UIView.AnimationCurve.easeOut.rawValue)),
                                       animations: {
                                        var finalFrame: CGRect = self.containerView!.frame
                                        finalFrame.origin.x += 40.0
                                        self.containerView!.frame = finalFrame
                        }, completion: { finished in
                            UIView.animate(withDuration: bounce2Duration, delay: 0, options: .curveEaseIn, animations: {
                                var finalFrame: CGRect = self.containerView!.frame
                                finalFrame.origin.x = -finalFrame.width
                                self.containerView!.frame = finalFrame
                            }, completion: completionBlock)
                        })
                        break
                    case .PJPopupDismissTyeBounceOutToRight:
                        UIView.animate(withDuration:bounce1Duration,
                                       delay: 0,
                                       options: UIView.AnimationOptions.init(rawValue: UInt(UIView.AnimationCurve.easeOut.rawValue)),
                                       animations: {
                                        var finalFrame: CGRect = self.containerView!.frame
                                        finalFrame.origin.x -= 40.0
                                        self.containerView!.frame = finalFrame
                        }, completion: { finished in
                            UIView.animate(withDuration: bounce2Duration, delay: 0, options: .curveEaseIn, animations: {
                                var finalFrame: CGRect = self.containerView!.frame
                                finalFrame.origin.x = self.bounds.width
                                self.containerView!.frame = finalFrame
                            }, completion: completionBlock)
                        })
                        break
                    default:
                         self.containerView!.alpha = 0.0;
                          completionBlock(true);
                          break;
                    }
                 }
                else {
                       self.containerView!.alpha = 0.0;
                        completionBlock(true);
                 }
              })
           )
        }
    }
    
    // MARK:- 展示
    
    private func showWithParameters(parameters:Dictionary<String,Any>){
        if isBeingShown == false && isShowing == false && isBeingDismissed == false {
            isBeingShown = true
            isShowing = false
            isBeingDismissed = false
            
            self.willStartShowing()
            
            DispatchQueue.main.async {
                if self.superview == nil {
                    let  frontToBackWindows: NSEnumerator = (UIApplication.shared.windows as NSArray).reverseObjectEnumerator()
                    for (_,item) in frontToBackWindows.enumerated() {
                        let window = item as! UIWindow
                        if (window.windowLevel == .normal){
                            window.addSubview(self)
                            break
                        }
                    }
                }
                
                self.updateForInterfaceOrientation()
                
                self.isHidden = false
                self.alpha = 1.0
                
                self.backgroundView?.alpha = 0.0
                
                if (self.maskType == .PJPopupMaskTypeDimmed) {
                    self.backgroundView?.backgroundColor = UIColor(displayP3Red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: self.dimmedMaskAlpha)
                }
                else {
                    self.backgroundView?.backgroundColor = UIColor.clear
                }
                
                let backgroundAnimationBlock:()->Void = {
                    self.backgroundView?.alpha = 1.0
                }
                
                if self.showType != .PJPopupShowTypeNode {
                    UIView.animate(withDuration: 0.15,
                                   delay: 0,
                                   options: UIView.AnimationOptions(rawValue: UInt(UIView.AnimationCurve.linear.rawValue)),
                                   animations: backgroundAnimationBlock, completion: nil)
                }
                else {
                    backgroundAnimationBlock()
                }
                
                var  duration:TimeInterval = 0.0
                let durationNumber:NSNumber? = parameters["duration"] as? NSNumber
                if durationNumber != nil {
                    duration = (durationNumber?.doubleValue)!
                }
                else {
                    duration = 0.0
                }
                
                let comletionBlock:(Bool)->Void = { finished in
                    self.isBeingShown = false
                    self.isShowing = true
                    self.isBeingDismissed = false
                    
                    self.didFinishShowing()
                    
                    if self.didFinishShowingCompletion != nil {
                        self.didFinishShowingCompletion!()
                    }
                    
                    if duration > 0.0 {
                        self.perform(#selector(self.dismissFunc), with: nil, afterDelay: duration)
                    }
                }
                
                if self.contentView?.superview != self.containerView {
                    self.containerView?.addSubview(self.contentView!)
                }
                
                self.contentView?.layoutIfNeeded()
                
                var  containerFrame = self.containerView!.frame
                containerFrame.size = self.contentView!.frame.size
                self.containerView!.frame = containerFrame
                
                var  contentViewFrame = self.contentView!.frame
                contentViewFrame.origin = CGPoint.zero
                self.contentView?.frame = contentViewFrame
                
                let contentView = self.contentView
                
                let  views = ["contentView":contentView]
                self.containerView?.removeConstraints((self.containerView?.constraints)!)
                self.containerView?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView]|", options: [], metrics: nil, views: views as [String : Any]))
                self.containerView?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentView]|", options: [], metrics: nil, views: views as [String : Any]))
                
                var  finalContrainerFrame = containerFrame
                var  containerAutoresizingMask:UIView.AutoresizingMask = []
                let  centerValue = parameters["center"] as? NSValue
                if centerValue != nil {
                    let centerInView = centerValue!.cgPointValue
                    var centerInSelf:CGPoint!
                    let fromView = parameters["view"] as? UIView
                    if fromView != nil {
                        centerInSelf = self.convert(centerInView, from: fromView)
                    }
                    else {
                        centerInSelf = centerInView
                    }
                    
                    finalContrainerFrame.origin.x = (centerInSelf.x - (finalContrainerFrame.width / 2.0))
                    finalContrainerFrame.origin.y = (centerInSelf.y - (finalContrainerFrame.height / 2.0))
                    containerAutoresizingMask = [.flexibleLeftMargin,.flexibleRightMargin,.flexibleTopMargin,.flexibleBottomMargin]
                }
                else {
                    let layoutValue = parameters["layout"] as? NSValue
                    var layoutPopup:PJPopupLayout!
                    if layoutValue != nil {
                       layoutPopup = layoutValue!.PJPopupLayoutValue()
                    }
                    else {
                        layoutPopup = PJPopupLayoutMake.PJPopupLayoutCenter
                    }
                    
                    switch (layoutPopup.horizontal) {
                    case .PJPopupHorizontalLayoutCustom:
                        break
                    case .PJPopupHorizontalLayoutLeft:
                         finalContrainerFrame.origin.x = 0.0
                         containerAutoresizingMask = UIView.AutoresizingMask(rawValue: containerAutoresizingMask.rawValue | UIView.AutoresizingMask.flexibleRightMargin.rawValue)
                        break
                    case .PJPopupHorizontalLayoutLeftOfCenter:
                        finalContrainerFrame.origin.x = CGFloat(floorf(Float((self.bounds.width / 3.0) - (containerFrame.width / 2.0))))
                        containerAutoresizingMask = UIView.AutoresizingMask(rawValue: containerAutoresizingMask.rawValue | UIView.AutoresizingMask.flexibleLeftMargin.rawValue | UIView.AutoresizingMask.flexibleRightMargin.rawValue)
                        break
                    case .PJPopupHorizontalLayoutCenter:
                        finalContrainerFrame.origin.x = CGFloat(floorf(Float(self.bounds.width - containerFrame.width)) / 2.0)
                        containerAutoresizingMask = UIView.AutoresizingMask(rawValue: containerAutoresizingMask.rawValue | UIView.AutoresizingMask.flexibleLeftMargin.rawValue | UIView.AutoresizingMask.flexibleRightMargin.rawValue)
                        break
                    case .PJPopupHorizontalLayoutRightCenter:
                        finalContrainerFrame.origin.x = CGFloat(floorf(Float(self.bounds.width * 2.0 / 3.0 - containerFrame.width / 2.0)))
                         containerAutoresizingMask = UIView.AutoresizingMask(rawValue: containerAutoresizingMask.rawValue | UIView.AutoresizingMask.flexibleLeftMargin.rawValue | UIView.AutoresizingMask.flexibleRightMargin.rawValue)
                        break
                    case .PJPopupHorizontalLayoutRight:
                         finalContrainerFrame.origin.x = self.bounds.width - containerFrame.width
                         containerAutoresizingMask = UIView.AutoresizingMask(rawValue: containerAutoresizingMask.rawValue | UIView.AutoresizingMask.flexibleLeftMargin.rawValue)
                        break
                    }
                    
                    switch (layoutPopup.vertical){
                    case .PJPopupVerticalLayoutCustom:
                        break
                    case .PJPopupVerticalLayoutTop:
                        finalContrainerFrame.origin.y = 0
                         containerAutoresizingMask = UIView.AutoresizingMask(rawValue: containerAutoresizingMask.rawValue | UIView.AutoresizingMask.flexibleBottomMargin.rawValue)
                        break
                    case .PJPopupVerticalLayoutAboveCenter:
                        finalContrainerFrame.origin.x = CGFloat(floorf(Float(self.bounds.height / 3.0 - containerFrame.height / 2.0 )))
                        containerAutoresizingMask = UIView.AutoresizingMask(rawValue: containerAutoresizingMask.rawValue | UIView.AutoresizingMask.flexibleTopMargin.rawValue | UIView.AutoresizingMask.flexibleBottomMargin.rawValue)
                        break
                    case .PJPopupVerticalLayoutCenter:
                         finalContrainerFrame.origin.y = CGFloat(floorf(Float(self.bounds.height - containerFrame.height)) / 2.0)
                        containerAutoresizingMask = UIView.AutoresizingMask(rawValue: containerAutoresizingMask.rawValue | UIView.AutoresizingMask.flexibleTopMargin.rawValue | UIView.AutoresizingMask.flexibleBottomMargin.rawValue)
                        break
                    case .PJPopupVerticalLayoutBelowCenter:
                        finalContrainerFrame.origin.y = CGFloat(floorf(Float(self.bounds.height * 2.0 / 3.0 - containerFrame.height / 2.0)))
                         containerAutoresizingMask = UIView.AutoresizingMask(rawValue: containerAutoresizingMask.rawValue | UIView.AutoresizingMask.flexibleTopMargin.rawValue | UIView.AutoresizingMask.flexibleBottomMargin.rawValue)
                        break
                    case .PJPopupVerticalLayoutBottom:
                         finalContrainerFrame.origin.y = CGFloat(floorf(Float(self.bounds.height - containerFrame.height)))
                          containerAutoresizingMask = UIView.AutoresizingMask(rawValue: containerAutoresizingMask.rawValue | UIView.AutoresizingMask.flexibleTopMargin.rawValue)
                        break
                    }
                }
                self.contentView?.autoresizingMask = containerAutoresizingMask
                
                switch (self.showType){
                case .PJPopupShowTypeFadeIn:
                      self.containerView?.alpha = 0.0
                      self.containerView?.transform = CGAffineTransform.identity
                      let startFrame = finalContrainerFrame
                      self.containerView!.frame  = startFrame
                      UIView.animate(withDuration: 0.15,
                                     delay: 0,
                                     options: UIView.AnimationOptions(rawValue: UInt(UIView.AnimationCurve.linear.rawValue)),
                                     animations: {
                                        self.containerView?.alpha = 1.0
                      },
                                     completion: comletionBlock)
                     
                     
                    break
                case .PJPopupShowTypeGrowIn:
                    self.containerView?.alpha = 0.0
                    // set frame before transform here...
                    let  startFrame: CGRect = finalContrainerFrame
                    self.containerView?.frame = startFrame
                    self.containerView?.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
                    
                    UIView.animate(withDuration: 0.15,
                                   delay: 0,
                                   options:UIView.AnimationOptions(rawValue: UInt(kAnimationOptionCurveIOS7)) ,
                                   animations: {
                        
                                    self.containerView?.alpha = 1.0
                                    self.containerView?.transform = CGAffineTransform.identity
                                    self.containerView?.frame = finalContrainerFrame
                                    
                    }, completion: comletionBlock)
                    
                    break
                case .PJPopupShowTypeShrinkIn:
                    self.containerView?.alpha = 0.0
                    // set frame before transform here...
                    let  startFrame: CGRect = finalContrainerFrame
                    self.containerView?.frame = startFrame
                    self.containerView?.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
                    
                    UIView.animate(withDuration: 0.15,
                                   delay: 0,
                                   options:UIView.AnimationOptions(rawValue: UInt(kAnimationOptionCurveIOS7)) ,
                                   animations: {
                                    
                                    self.containerView?.alpha = 1.0
                                    self.containerView?.transform = CGAffineTransform.identity
                                    self.containerView?.frame = finalContrainerFrame
                                    
                    }, completion: comletionBlock)
                    break
                case .PJPopupShowTypeSlideInFromTop:
                    self.containerView?.alpha = 1.0
                    // set frame before transform here...
                    var   startFrame: CGRect = finalContrainerFrame
                     startFrame.origin.y -= finalContrainerFrame.height
                    self.containerView?.frame = startFrame
                    self.containerView?.transform = CGAffineTransform.identity
                    UIView.animate(withDuration: 0.30,
                                   delay: 0,
                                   options:UIView.AnimationOptions(rawValue: UInt(kAnimationOptionCurveIOS7)) ,
                                   animations: {
                                    self.containerView?.frame = finalContrainerFrame
                                    
                    }, completion: comletionBlock)
                    break
                case .PJPopupShowTypeSlideInFromBottom:
                    self.containerView?.alpha = 1.0
                    self.containerView?.transform = CGAffineTransform.identity
                    // set frame before transform here...
                    var   startFrame: CGRect = finalContrainerFrame
                    startFrame.origin.y = self.bounds.height
                    self.containerView?.frame = startFrame
                   
                    UIView.animate(withDuration: 0.30,
                                   delay: 0,
                                   options:UIView.AnimationOptions(rawValue: UInt(kAnimationOptionCurveIOS7)) ,
                                   animations: {
                                    self.containerView?.frame = finalContrainerFrame
                                    
                    }, completion: comletionBlock)
                    break
                case .PJPopupShowTypeSlideInFromLeft:
                    self.containerView?.alpha = 1.0
                    self.containerView?.transform = CGAffineTransform.identity
                    // set frame before transform here...
                    var   startFrame: CGRect = finalContrainerFrame
                    startFrame.origin.x -= finalContrainerFrame.width
                    self.containerView?.frame = startFrame
                   
                    UIView.animate(withDuration: 0.30,
                                   delay: 0,
                                   options:UIView.AnimationOptions(rawValue: UInt(kAnimationOptionCurveIOS7)) ,
                                   animations: {
                                    self.containerView?.frame = finalContrainerFrame
                                    
                    }, completion: comletionBlock)
                    break
                case .PJPopupShowTypeSlideInFromRight:
                    self.containerView?.alpha = 1.0
                    self.containerView?.transform = CGAffineTransform.identity
                    // set frame before transform here...
                    var   startFrame: CGRect = finalContrainerFrame
                    startFrame.origin.x = self.bounds.width
                    self.containerView?.frame = startFrame
                    
                    UIView.animate(withDuration: 0.30,
                                   delay: 0,
                                   options:UIView.AnimationOptions(rawValue: UInt(kAnimationOptionCurveIOS7)) ,
                                   animations: {
                                    self.containerView?.frame = finalContrainerFrame
                                    
                    }, completion: comletionBlock)
                    break
                case .PJPopupShowTypeBoundIn:
                    self.containerView?.alpha = 1.0
                    // set frame before transform here...
                    let startFrame: CGRect = finalContrainerFrame
                    self.containerView?.frame = startFrame
                    self.containerView?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    
                    UIView.animate(withDuration: 0.6,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.8,
                                   initialSpringVelocity: 15.0,
                                   options: [],
                                   animations: {
                                    self.containerView?.alpha = 1.0
                                    self.containerView?.transform = CGAffineTransform.identity
                    },
                                   completion: comletionBlock)
                    break
                case .PJPopupShowTypeBounceInFromTop:
                    self.containerView?.alpha = 1.0
                     self.containerView?.transform = CGAffineTransform.identity
                    // set frame before transform here...
                    var   startFrame: CGRect = finalContrainerFrame
                    startFrame.origin.y -= finalContrainerFrame.height
                    self.containerView?.frame = startFrame
                    
                    UIView.animate(withDuration: 0.6,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.8,
                                   initialSpringVelocity: 10.0,
                                   options: [],
                                   animations: {
                                     self.containerView?.frame = finalContrainerFrame
                    },
                                   completion: comletionBlock)
                    break
                case .PJPopupShowTypeBounceInFromBottom:
                    self.containerView?.alpha = 1.0
                    self.containerView?.transform = CGAffineTransform.identity
                    // set frame before transform here...
                    var  startFrame: CGRect = finalContrainerFrame
                     startFrame.origin.y = self.bounds.height
                    self.containerView?.frame = startFrame
                    
                    UIView.animate(withDuration: 0.6,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.8,
                                   initialSpringVelocity: 10.0,
                                   options: [],
                                   animations: {
                                     self.containerView?.frame = finalContrainerFrame
                    },
                                   completion: comletionBlock)
                    break
                case .PJPopupShowTypeBounceInFromLeft:
                    self.containerView?.alpha = 1.0
                    self.containerView?.transform = CGAffineTransform.identity
                    // set frame before transform here...
                    var   startFrame: CGRect = finalContrainerFrame
                    startFrame.origin.x -= finalContrainerFrame.width
                    self.containerView?.frame = startFrame
                    
                    UIView.animate(withDuration: 0.6,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.8,
                                   initialSpringVelocity: 10.0,
                                   options: [],
                                   animations: {
                                    self.containerView?.frame = finalContrainerFrame
                    },
                                   completion: comletionBlock)
                    break
                case .PJPopupShowTypeBounceInFromRight:
                    self.containerView?.alpha = 1.0
                    self.containerView?.transform = CGAffineTransform.identity
                    // set frame before transform here...
                    var   startFrame: CGRect = finalContrainerFrame
                    startFrame.origin.x = self.bounds.width
                    self.containerView?.frame = startFrame
                    
                    UIView.animate(withDuration: 0.6,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.8,
                                   initialSpringVelocity: 10.0,
                                   options: [],
                                   animations: {
                                    self.containerView?.frame = finalContrainerFrame
                    },
                                   completion: comletionBlock)
                    break
                default:
                     self.containerView?.alpha = 1.0
                     self.containerView?.transform = CGAffineTransform.identity
                     self.containerView?.frame = finalContrainerFrame
                    break
                }
            }
        }
    }
}


extension PJPopup {
    
    static func popupWithContentView(_ contentView:UIView)->PJPopup {
        let popup = PJPopupManager._sharePopup
        popup.contentView = contentView
        return popup
    }
    
    static func popupWithContentView(_ contentView:UIView,
                                     _ showType:PJPopupShowType,
                                     _ dismissType:PJPopupDismissTye,
                                     _ maskType:PJPopupMaskType,
                                     _ shouldDismissOnBackgroundTouch:Bool,
                                     _ shouldDismissOnContentTouch:Bool)->PJPopup {
        
        let popup = self.init()
        popup.contentView = contentView
        popup.showType = showType
        popup.dismissType = dismissType
        popup.maskType = maskType
        popup.shouldDismissOnBackgroundTouch = shouldDismissOnBackgroundTouch
        popup.shouldDismissOnContentTouch = shouldDismissOnContentTouch
        return popup
    }
    

    static func dismissAllPopups(){
        let windows = UIApplication.shared.windows
        for window in windows {
            window.forEachPopupDoBlock { (popup) in
                popup.dismiss(animated: false)
            }
        }
    }
    
    
   open func willStartShowing(){
        
    }
    
   open func didFinishShowing(){
        
    }
    
   open func willStartDismissing(){
        
    }
    
   open func didFinishDismissing(){
        
    }
    
    
    // MARK:- public
    
    func show(){
        self.showWithLayout(PJPopupLayoutMake.PJPopupLayoutCenter)
    }
    
    func showWithLayout(_ layout:PJPopupLayout){
        self.showWithLayout(layout, duration: 0.0)
    }
    
    func showWithDuration(duration:TimeInterval){
        self.showWithLayout(PJPopupLayoutMake.PJPopupLayoutCenter, duration: duration)
    }
    
    func showWithLayout(_ layout:PJPopupLayout,duration:TimeInterval){
        let parameters:Dictionary = [
                                    "layout":NSValue.valueWithKLCPopupLayout(layout: layout),
                                    "duration":NSNumber(value: duration)
                                    ] as [String : Any]
        self.showWithParameters(parameters: parameters)
    }
    
    func showAtCenter(center:CGPoint,inView:UIView) {
        self.showAtCenter(center: center, inView: inView, withDuration: 0.0)
    }
    
    func showAtCenter(center:CGPoint,inView:UIView,withDuration:TimeInterval){
        let parameters = NSMutableDictionary()
        parameters.setValue(NSValue(cgPoint: center), forKey: "center")
        parameters.setValue(NSNumber(value: withDuration), forKey: "duration")
        parameters.setValue(inView, forKey: "view")
        self.showWithParameters(parameters: parameters as! Dictionary<String, Any>)
    }
    
    
    
   @objc fileprivate func didChangeStatusBarOrientation(_ notification:NSNotification){
        updateForInterfaceOrientation()
    }
    
    
    // MARKR:- NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(dismiss), object: nil) 报错,同名方法:
    //  func dismiss(animated:Bool){}
    
    @objc fileprivate func dismissFunc(){
        self.dismiss(animated: true)
    }
    
    private func updateForInterfaceOrientation (){
        if UIDevice.current.systemVersion.compare("8.0", options: .numeric, range: nil, locale: nil) == .orderedAscending {
            let orientation = UIApplication.shared.statusBarOrientation
            var angle:CGFloat!
            switch orientation {
            case .portraitUpsideDown:
                angle = .pi
                break
            case .landscapeLeft:
                angle =  (.pi / 2.0) * (-1)
                break
            case .landscapeRight:
                angle = .pi  / 2.0
                break
            default:
                angle = 0.0
                break
                
            }
            self.transform = CGAffineTransform(rotationAngle: angle)
            self.frame = self.window!.bounds
        }
    }
}




extension UIView {
    
    func forEachPopupDoBlock(block:@escaping(_ popup:PJPopup)->()){
        for subview  in self.subviews {
            if subview.isKind(of: PJPopup.self){
                block(subview as! PJPopup)
            }
            else {
                subview.forEachPopupDoBlock(block: block)
            }
        }
    }
    
    func dismissPresentingPopup(){
        var view:UIView? = self
        while (view != nil) {
            if view?.isKind(of: PJPopup.self) == true{
                (view as! PJPopup).dismiss(animated: true)
                break
            }
            view = view?.superview
        }
    }
}


extension NSValue {
    
    static func valueWithKLCPopupLayout( layout: PJPopupLayout) -> NSValue {
        let layoutObj = NSValue(nonretainedObject: layout)
        var layout = layout
        return NSValue(bytes:&layout, objCType: layoutObj.objCType)
    }
    
    func PJPopupLayoutValue()->PJPopupLayout {
        var layout = PJPopupLayout()
        getValue(&layout)
        return layout
    }
}
