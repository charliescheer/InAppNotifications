import UIKit

//IANotificationPresenter is the class that will be most frequently interacted with in SN.
//This class will contain a queue of notifications, present them on screen, and manage animations
//This class will also manage listening to keyboard changes and rotation changes, and manage pausing dismissal if user interacts with notification

class NoticePresenter {
    
    // MARK: Properties
    
    static let shared = NoticePresenter()
    
    var queue = NoticeQueue<NoticeViewController>()
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
    
    func present(notice: NoticeViewController) {
        // Should check to make sure the notification doesn't already exist in queue
        queue.enqueue(notice)
        prepareToPresent()
    }
    
    // MARK: State Management Functions
    
    private func prepareToPresent() {
        guard state == .inactive else {
            return
        }
        state = .preparing
        
        guard let noticeToPresent = queue.dequeue() else {
            state = .inactive
            return
        }
        
        //Needs to be untouchable
        window = UIWindow(frame: UIScreen.main.bounds)
        presentNotification(noticeToPresent)
    }
    
    private func presentNotification(_ notice: NoticeViewController) {
        state = .presenting
        
        window?.rootViewController = notice
        window?.isHidden = false
        
        notice.displayNotification(completion: { () in
            let delay = notice.hasAction ? Times.waitLong : Times.waitShort
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.dismissNotification(notice)
            }
        })
    }
    
    private func dismissNotification(_ notice: NoticeViewController) {
        state = .dismissing
        
        notice.dismissNotification {
            if self.queue.isEmpty {
                notice.dismiss(animated: false, completion: nil)
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
