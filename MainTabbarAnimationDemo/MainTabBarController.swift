//
//  MainTabBarController.swift
//  MainTabBarAnimationDemo
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.delegate = self
    }
    
    func animateToTab(_ toIndex: Int) {
        
        guard let tabViewControllers = self.viewControllers,
            let toView = tabViewControllers[toIndex].view,
            let selectedViewController = selectedViewController,
            let fromView = selectedViewController.view,
            let fromIndex = tabViewControllers.firstIndex(of: selectedViewController),
            toIndex != fromIndex
        else { return }
        
        guard let superview = fromView.superview else { return }
        superview.addSubview(toView)
        
        let screenWidth = UIScreen.main.bounds.size.width
        let scrollRight = toIndex > fromIndex
        let offset = (scrollRight ? screenWidth : -screenWidth)
        
        view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseOut, .allowAnimatedContent], animations: {
            
            fromView.center = CGPoint(x: fromView.center.x - offset, y: fromView.center.y)
            toView.center   = CGPoint(x: toView.center.x - offset, y: toView.center.y)
        }, completion: { finished in
            
            fromView.removeFromSuperview()
            self.selectedIndex = toIndex
            self.view.isUserInteractionEnabled = true
        })
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let tabViewControllers = tabBarController.viewControllers!
        guard let toIndex = tabViewControllers.firstIndex(of: viewController) else {
            return false
        }
        
        animateToTab(toIndex)
        
        return true
    }
}
