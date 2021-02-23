import UIKit

//IANotificationPresenter is the class that will be most frequently interacted with in SN.
//This class will contain a queue of notifications, present them on screen, and manage animations
//This class will also manage listening to keyboard changes and rotation changes, and manage pausing dismissal if user interacts with notification

class NoticePresenter {
    
    // MARK: Properties
    
    static let shared = NoticePresenter()
    
    var queue = NoticeQueue<Notice>()
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
    
    func present(_ notice: Notice) {
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
        let noticeViewController = NoticeViewController(notice: noticeToPresent)
        window?.rootViewController = noticeViewController
        
        presentNotice()
    }
    
    private func presentNotice() {
        guard let noticeWindow = window,
              let noticeViewController = noticeWindow.rootViewController as? NoticeViewController else {
            state = .inactive
            return
        }
        state = .presenting

        noticeWindow.isHidden = false
        
        noticeViewController.displayNotification(completion: { () in
            let delay = noticeViewController.notice.hasAction ? Times.waitLong : Times.waitShort
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.dismissNotice()
            }
        })
    }
    
    private func dismissNotice() {
        guard let noticeWindow = window,
              let noticeViewController = noticeWindow.rootViewController as? NoticeViewController else {
            state = .inactive
            return
        }
        state = .dismissing
        
        noticeViewController.dismissNotification {
            if self.queue.isEmpty {
                noticeViewController.dismiss(animated: false, completion: nil)
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
