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
        fromView.superview?.backgroundColor = UIColor.white
        
        guard let superview = fromView.superview else { return }
        superview.addSubview(toView)
        
        let screenWidth = UIScreen.main.bounds.size.width / 4
        let scrollRight = toIndex > fromIndex
        let offset = (scrollRight ? screenWidth : -screenWidth)
        toView.alpha = 0
        
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseOut, .allowAnimatedContent], animations: {
            
            fromView.alpha = 0
            fromView.center.x = fromView.center.x - offset
        }, completion: { _ in
            
            toView.center.x = toView.center.x + offset
            UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseIn, .allowAnimatedContent], animations: {
                
                toView.alpha = 1
                toView.center.x = toView.center.x - offset
            }, completion: { _ in
                
                fromView.removeFromSuperview()
                self.selectedIndex = toIndex
            })
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
