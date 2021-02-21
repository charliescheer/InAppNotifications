import UIKit

class IAController: UIViewController {
    var message: String
    var action: IANAction?
    
    init(message: String, action: IANAction?) {
        self.message = message
        self.action = action
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.message = ""
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .green
        let notification = IANotificationView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height / 2, width: UIScreen.main.bounds.width, height: 50))

        setupNotification(notification)
        
        view.addSubview(notification)
        
        NSLayoutConstraint.activate([
            notification.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            notification.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        notification.backgroundColor = .red
    }
    
    private func setupNotification(_ notification: IANotificationView) {
        notification.notificationTitle.text = message
        notification.action = action
    }
}


class OtherViewController: ViewController {
    override func viewDidLoad() {
        view.backgroundColor = .black
    }
}
