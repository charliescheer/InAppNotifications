import UIKit

class NoticeViewController: UIViewController {
    
    // MARK: Properties
    var notice: Notice
    var noticeView: NoticeView?
    var noticeTopConstraint: NSLayoutConstraint?

    // MARK: Initialization
    
    init(notice: Notice) {
        self.notice = notice
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.notice = Notice(message: "", action: nil)
        super.init(coder: coder)
    }
    
    // MARK: View Layout
    
    override func viewDidLoad() {
        let noticeToPresent = NoticeView(frame: Constants.notificationFrame)
        noticeToPresent.noticeLabel.text = notice.message
        noticeToPresent.action = notice.action?.handler
        noticeToPresent.noticeButton.setTitle(notice.action?.title, for: .normal)
        
        noticeView = noticeToPresent
        
        view.addSubview(noticeToPresent)
        prepareView(noticeToPresent)
    }
    
    private func prepareView(_ notification: NoticeView) {
        noticeTopConstraint = notification.topAnchor.constraint(equalTo: view.bottomAnchor)
        noticeTopConstraint?.isActive = true
        notification.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.layoutIfNeeded()
    }
    
    // MARK: Display/Dismiss Animations
    
    func displayNotification(completion: @escaping () -> Void) {
        guard let noticeView = noticeView else {
            return
        }
        
        self.noticeTopConstraint?.isActive = false
        let newConstraint = noticeView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.notificationBottomMargin)
        newConstraint.isActive = true
            
        UIView.animate(withDuration: Times.animationTime) {
            self.view?.layoutIfNeeded()
        } completion: { (_) in
            completion()
        }
    }
    
    func dismissNotification(completion: @escaping () -> Void) {
        guard let _ = noticeView else {
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
