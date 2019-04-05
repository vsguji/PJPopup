//
//  ViewController.swift
//  Popup
//
//  Created by lipeng on 2019/4/3.
//  Copyright © 2019 lipeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        view.addSubview(defaultButton)
        view.addSubview(fadeButton)
        view.addSubview(growButton)
        view.addSubview(shrinkButton)

        view.addSubview(slideInFromTopButton)
        view.addSubview(slideInFromBottomButton)
        view.addSubview(slideInFromLeftButton)
        view.addSubview(slideInFromRightButton)

        view.addSubview(boundInButton)
        view.addSubview(boundInFromTopButton)
        view.addSubview(boundInFromBottomButton)
        view.addSubview(boundInFromLeftButton)
        view.addSubview(boundInFromRightButton)
        
        defaultButton.addTarget(self, action: #selector(self.showPopup(_:)), for: UIControl.Event.touchUpInside)
        fadeButton.addTarget(self, action: #selector(self.showPopup(_:)), for: UIControl.Event.touchUpInside)
        growButton.addTarget(self, action: #selector(self.showPopup(_:)), for: UIControl.Event.touchUpInside)
        shrinkButton.addTarget(self, action: #selector(self.showPopup(_:)), for: UIControl.Event.touchUpInside)
        
        slideInFromTopButton.addTarget(self, action: #selector(self.showPopup(_:)), for: UIControl.Event.touchUpInside)
        slideInFromBottomButton.addTarget(self, action: #selector(self.showPopup(_:)), for: UIControl.Event.touchUpInside)
        slideInFromLeftButton.addTarget(self, action: #selector(self.showPopup(_:)), for: UIControl.Event.touchUpInside)
        slideInFromRightButton.addTarget(self, action: #selector(self.showPopup(_:)), for: UIControl.Event.touchUpInside)
        
        boundInButton.addTarget(self, action: #selector(self.showPopup(_:)), for: UIControl.Event.touchUpInside)
        boundInFromTopButton.addTarget(self, action: #selector(self.showPopup(_:)), for: UIControl.Event.touchUpInside)
        boundInFromBottomButton.addTarget(self, action: #selector(self.showPopup(_:)), for: UIControl.Event.touchUpInside)
        boundInFromLeftButton.addTarget(self, action: #selector(self.showPopup(_:)), for: UIControl.Event.touchUpInside)
        boundInFromRightButton.addTarget(self, action: #selector(self.showPopup(_:)), for: UIControl.Event.touchUpInside)
    }

    private lazy var  contentDemoView:UIView = {
        let button:UIView = UIView(frame: CGRect(x: 0 , y: 0, width: 100, height: 100))
        button.backgroundColor = UIColor.red
        button.center = view.center
        return button
    }()
    
    private lazy var  defaultButton:UIButton = {
        let button:UIButton = UIButton(frame: CGRect(x: view.frame.width / 2 - 50, y: 80 + (40 + 10) * 1, width: 100, height: 40))
        button.backgroundColor = UIColor.gray
        button.setTitle("默认显示", for: UIControl.State.normal)
        return button
    }()
    
    // Fade
    private lazy var  fadeButton:UIButton = {
        let button:UIButton = UIButton(frame: CGRect(x: view.frame.width / 2 - 50, y: 80 + (40 + 10) * 2, width: 100, height: 40))
        button.backgroundColor = UIColor.gray
        button.setTitle("淡入", for: UIControl.State.normal)
        return button
    }()

    // Grow
    private lazy var  growButton:UIButton = {
        let button:UIButton = UIButton(frame: CGRect(x: view.frame.width / 2 - 50, y: 80 + (40 + 10) * 3, width: 100, height: 40))
        button.backgroundColor = UIColor.gray
        button.setTitle("渐变", for: UIControl.State.normal)
        return button
    }()

    // Shrink
    private lazy var  shrinkButton:UIButton = {
        let button:UIButton = UIButton(frame: CGRect(x: view.frame.width / 2 - 50, y: 80 + (40 + 10) * 4, width: 100, height: 40))
        button.backgroundColor = UIColor.gray
        button.setTitle("缩放", for: UIControl.State.normal)
        return button
    }()

    // SlideInFromTop
    private lazy var slideInFromTopButton:UIButton = {
        let button:UIButton = UIButton(frame: CGRect(x: view.frame.width / 2 - 100 - 5, y: 80 + (40 + 10) * 5, width: 100, height: 40))
        button.backgroundColor = UIColor.gray
        button.setTitle("顶部滑入", for: UIControl.State.normal)
        return button
    }()

    // SlideInFromBottom
    private lazy var slideInFromBottomButton:UIButton = {
        let button:UIButton = UIButton(frame: CGRect(x: view.frame.width / 2  + 5, y: 80 + (40 + 10) * 5, width: 100, height: 40))
        button.backgroundColor = UIColor.gray
        button.setTitle("底部滑入", for: UIControl.State.normal)
        return button
    }()

    // SlideInFromLeft
    private lazy var slideInFromLeftButton:UIButton = {
        let button:UIButton = UIButton(frame: CGRect(x: view.frame.width / 2 - 100 - 5, y: 80 + (40 + 10) * 6, width: 100, height: 40))
        button.backgroundColor = UIColor.gray
        button.setTitle("左侧滑入", for: UIControl.State.normal)
        return button
    }()

    // SlideInFromRight
    private lazy var slideInFromRightButton:UIButton = {
        let button:UIButton = UIButton(frame: CGRect(x: view.frame.width / 2  + 5, y: 80 + (40 + 10) * 6, width: 100, height: 40))
        button.backgroundColor = UIColor.gray
        button.setTitle("右侧滑入", for: UIControl.State.normal)
        return button
    }()

    // BoundIn
    private lazy var boundInButton:UIButton = {
        let button:UIButton = UIButton(frame: CGRect(x: view.frame.width / 2 - 50 , y: 80 + (40 + 10) * 7, width: 100, height: 40))
        button.backgroundColor = UIColor.gray
        button.setTitle("默认跳入", for: UIControl.State.normal)
        return button
    }()

    // BounceInFromTop
    private lazy var boundInFromTopButton:UIButton = {
        let button:UIButton = UIButton(frame: CGRect(x: view.frame.width / 2 - 100 - 5, y: 80 + (40 + 10) * 8, width: 100, height: 40))
        button.backgroundColor = UIColor.gray
        button.setTitle("顶部跳入", for: UIControl.State.normal)
        return button
    }()

    // BounceInFromBottom
    private lazy var boundInFromBottomButton:UIButton = {
        let button:UIButton = UIButton(frame: CGRect(x: view.frame.width / 2 + 5, y: 80 + (40 + 10) * 8, width: 100, height: 40))
        button.backgroundColor = UIColor.gray
        button.setTitle("底部跳入", for: UIControl.State.normal)
        return button
    }()

    // BounceInFromLeft
    private lazy var boundInFromLeftButton:UIButton = {
        let button:UIButton = UIButton(frame: CGRect(x: view.frame.width / 2 - 100 - 5, y: 80 + (40 + 10) * 9, width: 100, height: 40))
        button.backgroundColor = UIColor.gray
        button.setTitle("左侧跳入", for: UIControl.State.normal)
        return button
    }()

    // BounceInFromRight
    private lazy var boundInFromRightButton:UIButton = {
        let button:UIButton = UIButton(frame: CGRect(x: view.frame.width / 2 + 5, y: 80 + (40 + 10) * 9, width: 100, height: 40))
        button.backgroundColor = UIColor.gray
        button.setTitle("右侧跳入", for: UIControl.State.normal)
        return button
    }()
    
    
   @objc  func showPopup(_ sender:UIButton) {
    
        let popup =  PJPopup.popupWithContentView(contentDemoView)
    
            if sender == defaultButton {
               // popup.showType = .PJPopupShowTypeNode
            }
            else if sender == fadeButton {
                popup.showType = .PJPopupShowTypeFadeIn
            }
            else if sender == growButton {
                popup.showType = .PJPopupShowTypeGrowIn
            }
            else if sender == shrinkButton {
                popup.showType = .PJPopupShowTypeShrinkIn
            }
            else if sender == slideInFromTopButton {
                popup.showType = .PJPopupShowTypeSlideInFromTop
            }
            else if sender == slideInFromBottomButton {
                popup.showType = .PJPopupShowTypeSlideInFromBottom
            }
           else if sender == slideInFromLeftButton {
                 popup.showType = .PJPopupShowTypeSlideInFromLeft
            }
           else if sender == slideInFromRightButton {
                 popup.showType = .PJPopupShowTypeSlideInFromRight
            }
            else if sender == boundInButton {
                 popup.showType = .PJPopupShowTypeBoundIn
            }
            else if sender == boundInFromTopButton {
                 popup.showType = .PJPopupShowTypeBounceInFromTop
            }
            else if sender == boundInFromBottomButton {
                 popup.showType = .PJPopupShowTypeBounceInFromBottom
            }
            else if sender == boundInFromLeftButton {
                 popup.showType = .PJPopupShowTypeBounceInFromLeft
            }
            else if sender == boundInFromRightButton {
                 popup.showType = .PJPopupShowTypeBounceInFromRight
            }
            popup.show()
    }
    
}

