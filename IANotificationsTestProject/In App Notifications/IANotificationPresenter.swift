import UIKit

class IANotificationPresenter {
    static let shared = IANotificationPresenter()
    var queue = IANQueue<IANotification>()
    var presenting = false
    
    
    private init() { }
    
    public func presentNotification(_ notification: IANotification) {
        guard !presenting else {
            queue.enqueue(notification)
            return
        }
        
        presenting = true
        animateIn(notification) {
            self.animateFadeOut(notification)
        }
    }
}

extension IANotificationPresenter {
    public func animateIn(_ notification: IANotification, completion: @escaping () -> Void) {
        notification.window.isHidden = false
        UIWindow.animate(withDuration: Times.fade) {
            var endFrame = notification.window.frame
            endFrame.origin.y -= 300

            notification.window.frame = endFrame
        } completion: { (_) in
            completion()
        }
        
    }
    
    public func animateFadeOut(_ notification: IANotification) {
        var delay: Double
        if notification.hasAction {
            delay = Times.waitLong
        } else {
            delay = Times.waitShort
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UIWindow.animate(withDuration: Times.fade) {
                notification.window.alpha = 0
            } completion: { (_) in
                self.presenting = false
                
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
