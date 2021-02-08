import UIKit

class IANotification: UIViewController {
    @IBOutlet weak var notificationView: UIStackView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    var message: String
    var action: IANAction?
    var direction: IANDirection
    var window: UIWindow!
    
    var hasAction: Bool {
        return action != nil
    }
    
    
    init(message: String, action: IANAction?, direction: IANDirection = .upFromBottom) {
        self.message = message
        self.action = action
        self.direction = direction
        self.window = UIWindow()
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
    
    @IBAction func actionWasTapped(_ sender: Any) {
        if let action = action {
            actionButton.titleLabel?.text = action.message
            action.action!(action)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .clear
        
        notificationView.translatesAutoresizingMaskIntoConstraints = false
        notificationView.layer.cornerRadius = 25
        notificationView.clipsToBounds = true
        notificationView.backgroundColor = .lightGray
        messageLabel.textColor = .black
        
        if action == nil {
            actionButton.isHidden = true
        } else {
            actionButton.titleLabel?.text = action!.message
        }
        
        messageLabel.text = message
    }
    
    private func setupWindow(direction: IANDirection) {
        var rect: CGRect
        switch direction {
        case .upFromBottom:
            rect = Constants.bottomRect
        case .downFromTop:
            rect = Constants.topRect
        }
        
        window.backgroundColor = .clear
        window.frame = rect
        window.rootViewController = self
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
