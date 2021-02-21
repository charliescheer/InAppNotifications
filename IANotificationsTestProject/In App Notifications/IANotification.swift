import UIKit

//IANotification is where the content of an in app notification is stored
//This class contains the window that displays the notification and all of the UI elements
//This class handles triggering actions if present and tapped

class IANotification: UIViewController {
//    var notificationView: IANotificationView!
    var message: String
    var action: IANAction?
    var direction: IANDirection
//    var window: UIWindow!
    
    var hasAction: Bool {
        return action != nil
    }
    
    
    init(message: String, action: IANAction?, direction: IANDirection = .upFromBottom) {
//        self.notificationView = IANotificationView(frame: Constants.bottomRect)
        self.message = message
        self.action = action
        self.direction = direction
//        self.window = UIWindow()
        super.init(nibName: nil, bundle: nil)
        
        setupWindow(direction: direction)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Setup notification view appearance
    private func setupView() {
//        let notificationView = IANotificationView(frame: Constants.bottomRect)
//        view.addSubview(notificationView)
//        notificationView.notificationTitle.textColor = .black
        
        //Prepare action button if needed
//        if action == nil {
//            notificationView.notificationButton.isHidden = true
//        } else {
//            notificationView.notificationButton.titleLabel?.text = action!.message
//        }
        
//        notificationView.notificationTitle.text = message
    }
    
    private func setupWindow(direction: IANDirection) {
        //Set window to top or bottom of screen
        var rect: CGRect
        switch direction {
        case .upFromBottom:
            rect = Constants.bottomRect
        case .downFromTop:
            rect = Constants.topRect
        }
//        
//        window.backgroundColor = .clear
//        window.frame = rect
//        window.rootViewController = self
    }
}

enum IANDirection {
    case upFromBottom
    case downFromTop
}

private struct Constants {
    static let bottomRect = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 50)
    static let topRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
}
