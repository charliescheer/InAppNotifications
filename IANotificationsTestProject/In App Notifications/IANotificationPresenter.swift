import UIKit

//IANotificationPresenter is the class that will be most frequently interacted with in SN.
//This class will contain a queue of notifications, present them on screen, and manage animations
//This class will also manage listening to keyboard changes and rotation changes, and manage pausing dismissal if user interacts with notification

class IANotificationPresenter {
    
    // MARK: Properties
    
    static let shared = IANotificationPresenter()
    
    var queue = IANQueue<IAController>()
    var window: UIWindow? = nil
    var state: State = .inactive
    
    private init() { }
    
    enum State: String {
        case inactive
        case preparing
        case presenting
        case dismissing
    }
    
    // MARK: Presenting Functions
    
    func present(notification: IAController) {
        // Should check to make sure the notification doesn't already exist in queue
        queue.enqueue(notification)
        prepareToPresent()
    }
    
    // MARK: State Management Functions
    
    private func prepareToPresent() {
        guard state == .inactive else {
            return
        }
        state = .preparing
        
        guard let notificationToPresent = queue.dequeue() else {
            state = .inactive
            return
        }
        
        //Needs to be untouchable
        window = UIWindow(frame: UIScreen.main.bounds)
        presentNotification(notificationToPresent)
    }
    
    private func presentNotification(_ notification: IAController) {
        state = .presenting
        
        window?.rootViewController = notification
        window?.isHidden = false
        
        notification.displayNotification(completion: { () in
            let delay = notification.hasAction ? Times.waitLong : Times.waitShort
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.dismissNotification(notification)
            }
        })
    }
    
    private func dismissNotification(_ notification: IAController) {
        state = .dismissing
        
        notification.dismissNotification {
            if self.queue.isEmpty {
                notification.dismiss(animated: false, completion: nil)
                self.window = nil
                self.state = .inactive
            } else {
                self.prepareToPresent()
            }
        }
    }
}

private struct Times {
    static let waitShort = 1.5
    static let waitLong = 2.75
}
