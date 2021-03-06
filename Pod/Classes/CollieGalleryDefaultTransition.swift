//
//  CollieGalleryDefaultTransition.swift
//
//  Copyright (c) 2016 Guilherme Munhoz <g.araujo.munhoz@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

internal class CollieGalleryDefaultTransition: CollieGalleryTransitionProtocol {
    
    // MARK: - Private properties
    private let minorScale = CGAffineTransformMakeScale(0.1, 0.1)
    private let offStage: CGFloat = 100.0
    
    
    // MARK: - CollieGalleryTransitionProtocol
    internal func animatePresentationWithTransitionContext(transitionContext: UIViewControllerContextTransitioning, duration: NSTimeInterval) {
        let presentedController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! CollieGallery
        let presentedControllerView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let containerView = transitionContext.containerView()!
        
        presentedControllerView.alpha = 0.0
        
        presentedController.pagingScrollView.transform = self.minorScale
        presentedController.closeButton.center.x -= self.offStage
        presentedController.actionButton?.center.x += self.offStage
        presentedController.progressTrackView?.center.y += self.offStage
        presentedController.captionView.center.y += self.offStage
        
        
        containerView.addSubview(presentedControllerView)
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .AllowUserInteraction, animations: {
            
            presentedControllerView.alpha = 1.0
            presentedController.closeButton.center.x += self.offStage
            presentedController.actionButton?.center.x -= self.offStage
            presentedController.progressTrackView?.center.y -= self.offStage
            presentedController.captionView.center.y -= self.offStage
            presentedController.pagingScrollView.transform = CGAffineTransformIdentity
            
            }, completion: {(completed: Bool) -> Void in
                transitionContext.completeTransition(completed)
        })
    }
    
    internal func animateDismissalWithTransitionContext(transitionContext: UIViewControllerContextTransitioning, duration: NSTimeInterval) {
        let presentingController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! CollieGallery
        let presentingControllerView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let containerView = transitionContext.containerView()!
        
        containerView.addSubview(presentingControllerView)
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .AllowUserInteraction, animations: {
            
            presentingControllerView.alpha = 0.0
            presentingController.closeButton.center.x -= self.offStage
            presentingController.actionButton?.center.x += self.offStage
            presentingController.progressTrackView?.center.y += self.offStage
            presentingController.captionView.center.y += self.offStage
            presentingController.pagingScrollView.transform = self.minorScale
            
            }, completion: {(completed: Bool) -> Void in
                if(transitionContext.transitionWasCancelled()){
                    transitionContext.completeTransition(false)
                    
                }
                else {
                    transitionContext.completeTransition(true)
                    
                }
        })
    }
}
