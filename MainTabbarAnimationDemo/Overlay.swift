//
//  Overlay.swift
//  MainTabbarAnimationDemo
//

import UIKit

/**
 superview 全体を覆う FishIndicator の Overlay なビュー。
 
 ```
 let fishIndicatorOverlay = FishIndicatorOverlay()
 view.addSubview(fishIndicatorOverlay)
 fishIndicatorOverlay.removeFromSuperview()
 ```
 
 で動作する。
 */
@IBDesignable
class Overlay: UIView {
    fileprivate static let indicatorDuration = 1.0
    fileprivate static let indicatorWidth = 120
    fileprivate static let indicatorHeight = 30
    
    fileprivate var showingDuration = 0.2
    fileprivate var dismissDuration = 0.2
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Invalid usage")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
    }
    
    convenience init(frame: CGRect, showingDuration: Double = 0.2, dismissDuration: Double = 0.2) {
        self.init(frame: frame)
        self.showingDuration = showingDuration
        self.dismissDuration = dismissDuration
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard superview != nil else {
            return
        }
        alpha = 0
        UIView.animate(withDuration: showingDuration, animations: {
            self.alpha = 1
        })
    }
    
    override func removeFromSuperview() {
        UIView.animate(withDuration: dismissDuration, animations: {
            self.alpha = 0
        })
    }

}
