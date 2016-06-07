//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Christopher Chan on 6/3/16.
//  Copyright © 2016 Christopher Chan. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    var messageViewOriginalCenter: CGPoint!
    var laterViewOriginalCenter: CGPoint!
    var archiveViewOriginalCenter: CGPoint!
    var messageViewRight: CGPoint!
    var messageViewLeft: CGPoint!
    var laterViewRight: CGPoint!
    var archiveViewLeft: CGPoint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedView: UIImageView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var laterView: UIImageView!
    @IBOutlet weak var archiveView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var listFullView: UIImageView!
    @IBOutlet weak var schedulerFullView: UIImageView!
    
    
    @IBAction func onTapGestureScheduler(sender: UITapGestureRecognizer) {
        schedulerFullView.alpha = 0.0
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.messageView.center = self.messageViewRight
            self.laterView.center = self.laterViewRight
        })
    }

    @IBAction func onTapGesture(sender: UITapGestureRecognizer) {
        listFullView.alpha = 0.0
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.messageView.center = self.messageViewRight
            self.laterView.center = self.laterViewRight
        })
    }
    
    @IBAction func onPanGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        print("translation \(translation)")
        
        if sender.state == UIGestureRecognizerState.Began {
            print("Gesture began")
            //Gesture beginning
            
            messageViewOriginalCenter = messageView.center
            laterViewOriginalCenter = laterView.center
            archiveViewOriginalCenter = archiveView.center
            listView.alpha = 0.0
            archiveView.alpha = 0.0
        } else if sender.state == UIGestureRecognizerState.Changed {
            //Gesture Changing
            print("Gesture is changing")
            messageView.center = CGPoint(x: messageViewOriginalCenter.x + translation.x, y: messageViewOriginalCenter.y)
            
            if messageView.center.x < 100 && messageView.center.x > 40 {
                backView.backgroundColor = UIColor.yellowColor()
                listView.alpha = 0.0
                laterView.alpha = 1.0
                laterView.center = CGPoint(x: messageView.center.x + 200 , y: messageViewOriginalCenter.y)
            } else if messageView.center.x < 40 {
                backView.backgroundColor = UIColor.brownColor()
                laterView.alpha = 0.0
                listView.alpha = 1.0
                listView.center = CGPoint(x: messageView.center.x + 200 , y: messageViewOriginalCenter.y)
            } else if messageView.center.x > 220 && messageView.center.x < 280 {
                backView.backgroundColor = UIColor.greenColor()
                archiveView.alpha = 1.0
                archiveView.center = CGPoint(x: messageView.center.x - 200 , y: messageViewOriginalCenter.y)
            } else if messageView.center.x > 280 {
                backView.backgroundColor = UIColor.redColor()
                archiveView.alpha = 1.0
                archiveView.center = CGPoint(x: messageView.center.x - 200 , y: messageViewOriginalCenter.y)
            } else {
                backView.backgroundColor = UIColor.grayColor()
                archiveView.alpha = 0.5
                laterView.alpha = 0.5
            }
        } else if sender.state == UIGestureRecognizerState.Ended {
            //Gesture Ending
            print("Gesture ended")
            
            if velocity.x < 0 && messageView.center.x < 40 {
                UIView.animateWithDuration(0.3) {
                    self.listFullView.alpha = 1.0
                }
            } else if velocity.x < 0 && messageView.center.x < 100 && messageView.center.x > 40 {
                    UIView.animateWithDuration(0.3) {
                        self.schedulerFullView.alpha = 1.0
                    }
            } else if velocity.x > 0 && messageView.center.x > 220 {
                UIView.animateWithDuration(0.3) {
                    self.feedView.center.y -= 86
                }
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.center = self.messageViewLeft
                    self.archiveView.center = self.archiveViewLeft
                })
            }
            
            else {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageView.center = self.messageViewRight
                    self.laterView.center = self.laterViewRight
                    self.messageView.center = self.messageViewLeft
                    self.archiveView.center = self.archiveViewLeft
                })
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = feedView.image!.size
        scrollView.delegate = self
        
        messageViewRight = messageView.center
        messageViewLeft = messageView.center
        archiveViewLeft = archiveView.center
        laterViewRight = laterView.center
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // This method is called as the user scrolls
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView,
        willDecelerate decelerate: Bool) {
            // This method is called right as the user lifts their finger
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // This method is called when the scrollview finally stops scrolling.
    }
}
