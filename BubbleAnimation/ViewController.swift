//
//  ViewController.swift
//  BubbleAnimation
//
//  Created by Dave Vo on 4/4/17.
//  Copyright © 2017 DaveVo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {

    @IBOutlet weak var bubble1: UIImageView!
    @IBOutlet weak var bubble2: UIImageView!
    @IBOutlet weak var bubble3: UIImageView!
    
    var animator: UIDynamicAnimator!
    var collisionBehavior: UICollisionBehavior!
    
    var bubble1Center: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.onTapBubble(_:)))
        tapGesture.numberOfTapsRequired = 1
        
        bubble1.addGestureRecognizer(tapGesture)
        
        bubble1Center = bubble1.center
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        animator = UIDynamicAnimator.init(referenceView: self.view)
        
        // make it really heavy so other won't be able to push it
        let centerBubbleProperties = UIDynamicItemBehavior(items: [self.bubble1])
        centerBubbleProperties.allowsRotation = false
        centerBubbleProperties.density = 10000
        centerBubbleProperties.resistance = 10000
        animator.addBehavior(centerBubbleProperties)

        collisionBehavior = UICollisionBehavior.init(items: [self.bubble1, self.bubble2, self.bubble3])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionDelegate = self
        animator.addBehavior(collisionBehavior)
    }
    
    func onTapBubble(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.view)
        print("tap tap at location ", location)
        
        let newBubble = UIImageView(image: UIImage(named: "Bubble"))
//        newBubble.frame = CGRect(x: bubble1.center.x,
//                                 y: bubble1.center.y + bubble1.frame.height/2 + 50,
//                                 width: 10,
//                                 height: 10)
        
        newBubble.frame = CGRect(x: bubble1.frame.origin.x,
                                 y: bubble1.center.y + bubble1.frame.height/2,
                                 width: 80,
                                 height: 80)
        view.addSubview(newBubble)
        
        self.collisionBehavior.addItem(newBubble)
        
        let snapBehavior = UISnapBehavior(item: newBubble,
                                          snapTo: CGPoint(x: bubble1.center.x, y: bubble1.center.y + 100))
        animator.addBehavior(snapBehavior)

        // this doesn't work, can't animate the size/transform while item under Dynamic
//        UIView.animate(withDuration: 1, animations: {
//            
////            let transform = newBubble.transform
////            newBubble.transform = transform.scaledBy(x: 8, y: 8)
//            
//            newBubble.frame.size = CGSize(width: 80, height: 80)
//            
//        }) { (_) in

//            self.collisionBehavior.addItem(newBubble)
//            print(newBubble.frame)
//        }
        
        
    }


}

