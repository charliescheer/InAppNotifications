import UIKit

//IANotificationPresenter is the class that will be most frequently interacted with in SN.
//This class will contain a queue of notifications, present them on screen, and manage animations
//This class will also manage listening to keyboard changes and rotation changes, and manage pausing dismissal if user interacts with notification

class IANotificationPresenter {
    static let shared = IANotificationPresenter()
    
    var queue = IANQueue<IANotification>()
    var presenting = false
    
    private init() { }
    
    //Method will present a given notification on screen
    //If a notification is already present than the nofitication is queued to be run in turn
    public func presentNotification(_ notification: IANotification) {
        //Check if there are currently presenting notifications
        guard !presenting else {
            //If so, enqueu the notification and exit
            queue.enqueue(notification)
            return
        }
        
        //Set self to presenting
        presenting = true
        
        //Present a notification
        animateIn(notification) {
            //When presenting is finished fade out the presented notification
            self.animateFadeOut(notification)
        }
    }
}

extension IANotificationPresenter {
    //Animate a notification in
    public func animateIn(_ notification: IANotification, completion: @escaping () -> Void) {
        //Make notification window visisble
        notification.window.isHidden = false
        //Begin animation
        UIWindow.animate(withDuration: Times.fade) {
            var endFrame = notification.window.frame
            endFrame.origin.y -= 300

            notification.window.frame = endFrame
        } completion: { (_) in
            completion()
        }
        
    }
    
    public func animateFadeOut(_ notification: IANotification) {
        //Choose the correct delay time
        var delay: Double
        if notification.hasAction {
            delay = Times.waitLong
        } else {
            delay = Times.waitShort
        }
        
        //After waiting...
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            //Trigger notification to fade out
            UIWindow.animate(withDuration: Times.fade) {
                notification.window.alpha = 0
            } completion: { (_) in
                //When animation is complete set currently presenting to false
                self.presenting = false
                
                //If the queue is not empty, trigger presentNotifications again with the next in line
                if !self.queue.isEmpty  {
                    self.presentNotification(self.queue.dequeue()!)
                }
            }
        }

    }
}

private struct Times {
    static let waitShort = 1.5
    static let waitLong = 2.75
    static let fade = TimeInterval(0.5)
}

private struct Constants {
    static let windowFrame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 50)
}
