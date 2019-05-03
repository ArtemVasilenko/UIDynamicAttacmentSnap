//
//  ViewController.swift
//  UIDynamicAttacmentSnap
//
//  Created by Артем on 5/3/19.
//  Copyright © 2019 Артем. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    private var squareView = UIView()
    private var sqareViewAnchor = UIView()
    private var anchorView = UIView()
    private var animator: UIDynamicAnimator?
    private var attachmentBehavior: UIAttachmentBehavior?
    private var panorama: UIGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func createSquareSmallView() {
        squareView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        squareView.backgroundColor = .green
        squareView.center = self.view.center
        sqareViewAnchor.frame = CGRect(x: 60, y: 0, width: 20, height: 20)
        sqareViewAnchor.backgroundColor = .brown
        squareView.addSubview(sqareViewAnchor)
        self.view.addSubview(squareView)
    }
    
    private func createAnchorView() {
        anchorView.frame = CGRect(x: 120, y: 120, width: 20, height: 20)
        anchorView.backgroundColor = .red
        self.view.addSubview(anchorView)
    }
    
    private func createGestureRecognizer() {
        panorama = UIPanGestureRecognizer(target: self, action: #selector(handledPan(param:)))
        self.view.addGestureRecognizer(panorama!)
    }
    
    @objc func handledPan(param: UIGestureRecognizer) {
        let tapPoint = param.location(in: self.view)
        print(tapPoint)
        attachmentBehavior?.anchorPoint = tapPoint //поведению передаём точку где будем тягать
        anchorView.center = tapPoint
        
    }
    
    private func createAnimationAndBehavior() {
        animator = UIDynamicAnimator(referenceView: self.view)
        let collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        attachmentBehavior = UIAttachmentBehavior(item: squareView, attachedToAnchor: anchorView.center)
        animator?.addBehavior(collision)
        animator?.addBehavior(attachmentBehavior)
        
    }
}

