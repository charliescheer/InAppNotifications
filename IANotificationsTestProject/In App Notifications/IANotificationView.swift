import UIKit

class IANotificationView: UIView {
    
    // MARK: Properties
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var notificationButton: UIButton!
    
    var message: String?
    var action: IANAction?
    
    // MARK: Initialization
    
    init(message: String, action: IANAction?, frame: CGRect) {
        self.message = message
        self.action = action
        
        super.init(frame: frame)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: View Layout
    
    private func setupView() {
        let nib = UINib(nibName: "IANotification", bundle: nil)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
            
            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: self.topAnchor),
                contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
            
            contentView.layer.cornerRadius = 25
            contentView.clipsToBounds = true
            contentView.backgroundColor = .lightGray
            
            if let action = action {
                notificationButton.setTitle(action.title, for: .normal)
            } else {
                notificationButton.isHidden = true
            }
            if let message = message {
                notificationTitle.text = message
            }
        }
    }
    
    // MARK: Action
    
    @IBAction func actionButtonWasPressed(_ sender: Any) {
        if let action = action {
            action.handler()
        }
    }
}
