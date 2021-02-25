import UIKit

class NoticePresenter {
    
    // MARK: Properties
    var noticeView: NoticeView?
    var noticeTopConstraint: NSLayoutConstraint?

    var isPresenting: Bool {
        noticeView != nil
    }

    // MARK: Presenting/Dismissing Methods

    func presentNoticeView(_ noticeView: NoticeView, completion: @escaping () -> Void) {
        guard let keyWindow = getKeyWindow() else {
            return
        }
        self.noticeView = noticeView
        keyWindow.addSubview(noticeView)

        noticeTopConstraint = noticeView.topAnchor.constraint(equalTo: keyWindow.bottomAnchor)
        noticeTopConstraint?.isActive = true
        NSLayoutConstraint.activate([
            noticeView.centerXAnchor.constraint(equalTo: keyWindow.centerXAnchor),
            noticeView.widthAnchor.constraint(equalToConstant: CGFloat(275)),
            noticeView.heightAnchor.constraint(equalToConstant: 50)
        ])

        keyWindow.layoutIfNeeded()
        displayNotificationView {
            completion()
        }
    }

    private func displayNotificationView(completion: @escaping () -> Void) {
        guard let keyWindow = getKeyWindow(),
              let noticeView = noticeView else {
            return
        }

        noticeTopConstraint?.isActive = false
        let newConstraint = noticeView.bottomAnchor.constraint(equalTo: keyWindow.bottomAnchor, constant: Constants.notificationBottomMargin)
        newConstraint.isActive = true

        let delay = noticeView.action == nil ? Times.waitShort : Times.waitLong

        UIView.animate(withDuration: Times.animationTime) {
            keyWindow.layoutIfNeeded()
        } completion: { (_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                completion()
            }
        }
    }

    func dismissNotification(completion: @escaping () -> Void) {
        guard let noticeView = noticeView else {
            return
        }

        UIView.animate(withDuration: Times.animationTime) {
            noticeView.alpha = 0
        } completion: { (_) in
            self.noticeView = nil
            completion()
        }
    }
}


extension NoticePresenter {

    // Convenience method to fetch current key window
    //
    func getKeyWindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
    }
}

private struct Times {
    static let waitShort = 1.5
    static let waitLong = 2.75
    static let animationTime = TimeInterval(0.5)
    static let tapWait = TimeInterval(3)
}

private struct Constants {
    static let notificationBottomMargin = CGFloat(-150)
}
