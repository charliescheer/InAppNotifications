import UIKit

class NoticeView: UIView {
    
    // MARK: Properties
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var noticeButton: UIButton!
    var action: (() -> Void)? {
        didSet {
            noticeButton.isHidden = action == nil ? true : false
        }
    }
    
    // MARK: Initialization
    
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
        let nib = UINib(nibName: "SnackbarNoticeView", bundle: nil)
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
        }
    }
    
    // MARK: Action
    
    @IBAction func noticeButtonWasTapped(_ sender: Any) {
        action?()
    }
    
}
