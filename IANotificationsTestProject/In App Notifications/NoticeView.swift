import UIKit

class NoticeView: UIView {
    
    // MARK: Properties

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var noticeButton: UIButton!

    var delegate: NoticePresentingDelegate?
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
                stackView.topAnchor.constraint(equalTo: self.topAnchor),
                stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
            
            stackView.layer.cornerRadius = 25
            stackView.clipsToBounds = true
            stackView.backgroundColor = .lightGray
        }
    }
    
    // MARK: Action
    
    @IBAction func noticeButtonWasTapped(_ sender: Any) {
        action?()
    }
    
}
