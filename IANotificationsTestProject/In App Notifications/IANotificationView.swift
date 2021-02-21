import UIKit

class IANotificationView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var notificationButton: UIButton!
    
    var action: IANAction? {
        didSet {
            if let action = action {
                notificationButton.setTitle(action.title, for: .normal)
            } else {
                notificationButton.isHidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
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
            
            notificationButton.titleLabel?.text = "test two"
        }
    }
    
    @IBAction func actionButtonWasPressed(_ sender: Any) {
        if let action = action {
            action.handler()
        }
    }
}
