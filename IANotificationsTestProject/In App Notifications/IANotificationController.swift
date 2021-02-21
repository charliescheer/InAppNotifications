import UIKit

class IAController: UIViewController {
    
    // MARK: Properties
    
    var message: String
    var action: IANAction?
    var notification: IANotificationView?
    var notificationTopConstraint: NSLayoutConstraint?
    
    var hasAction: Bool {
        return action != nil
    }
    
    // MARK: Initialization
    
    init(message: String, action: IANAction?) {
        self.message = message
        self.action = action
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.message = ""
        super.init(coder: coder)
    }
    
    // MARK: View Layout
    
    override func viewDidLoad() {
        let notificationToPresent = IANotificationView(message: message, action: action, frame: Constants.notificationFrame)
        notification = notificationToPresent
        
        view.addSubview(notificationToPresent)
        prepareView(notificationToPresent)
    }
    
    private func prepareView(_ notification: IANotificationView) {
        notificationTopConstraint = notification.topAnchor.constraint(equalTo: view.bottomAnchor)
        notificationTopConstraint?.isActive = true
        notification.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.layoutIfNeeded()
    }
    
    // MARK: Display/Dismiss Animations
    
    func displayNotification(completion: @escaping () -> Void) {
        guard let notification = notification else {
            return
        }
        
        self.notificationTopConstraint?.isActive = false
        let newConstraint = notification.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.notificationBottomMargin)
        newConstraint.isActive = true
            
        UIView.animate(withDuration: Times.animationTime) {
            self.view?.layoutIfNeeded()
        } completion: { (_) in
            completion()
        }
    }
    
    func dismissNotification(completion: @escaping () -> Void) {
        guard let _ = notification else {
            return
        }
        
        UIView.animate(withDuration: Times.animationTime) {
            self.view.alpha = 0
        } completion: { (_) in
            completion()
        }
    }
}

private struct Constants {
    static let notificationFrame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 50)
    static let notificationBottomMargin = CGFloat(-150)
}

private struct Times {
    static let animationTime = TimeInterval(0.5)
}
