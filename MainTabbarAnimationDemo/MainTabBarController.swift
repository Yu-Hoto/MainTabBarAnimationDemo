//
//  MainTabBarController.swift
//  MainTabBarAnimationDemo
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.delegate = self
        view.backgroundColor = UIColor.systemBackground
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard
            let viewControllers = tabBarController.viewControllers,
            let fromIndex = viewControllers.firstIndex(of: fromVC),
            let toIndex = viewControllers.firstIndex(of: toVC)
        else { return nil }
        
        let scrollRight = toIndex > fromIndex
        
        return TabBarAnimatedTransitioning(scrollRight)
    }
}

final class TabBarAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    let scrollRight: Bool
    
    init(_ scrollRight: Bool) {
        self.scrollRight = scrollRight
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from),
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        else { return }
        
        transitionContext.containerView.addSubview(toView)
        
        let screenWidth = UIScreen.main.bounds.size.width / 4
        let offset = (scrollRight ? screenWidth : -screenWidth)
        toView.alpha = 0
        toView.center.x += offset
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseInOut], animations: {
            
            fromView.alpha = 0
            fromView.center.x = fromView.center.x - offset
            toView.alpha = 1
            toView.center.x = toView.center.x - offset
        }, completion: {
            transitionContext.completeTransition($0)
        })
    }
}
