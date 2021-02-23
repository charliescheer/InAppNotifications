import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func button2Tapped(_ sender: Any) {
        let action = NoticeAction(title: "click me") {
            print("well clicked")
        }
        let notification = NoticeViewController(message: "Notice!!", action: action)
        NoticePresenter.shared.present(notice: notification)
    }
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        let notification = NoticeViewController(message: "Notice!!", action: nil)
        NoticePresenter.shared.present(notice: notification)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setText()
    }
}

extension ViewController {
    func setText() {
        textView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent egestas neque ut molestie tempor. Etiam pulvinar diam eget vestibulum viverra. Proin rutrum ligula erat, eget bibendum diam mollis at. Vivamus rutrum eu elit eu tempor. Proin velit risus, consectetur pharetra neque et, sodales eleifend est. Mauris libero velit, tincidunt eu nibh ut, eleifend egestas erat. Nullam accumsan neque id accumsan ullamcorper. Nam et metus porta odio consequat rutrum vel vitae felis. Nullam quis nunc eget lorem bibendum condimentum eleifend eget erat. Praesent convallis nisi nec tempor vulputate. Mauris eu varius velit. Vestibulum tempus nisi vitae eros elementum, nec sagittis elit finibus. Vivamus luctus, nibh eget vulputate pretium, erat odio euismod lorem, ac cursus eros ipsum eu nibh. Vivamus nec libero vitae odio convallis varius a quis tellus. Quisque sem massa, vestibulum eu ipsum a, facilisis fringilla quam. Nulla tempus sem in justo tempus, condimentum placerat felis dictum. Praesent vitae nisl scelerisque nunc posuere aliquet. Etiam ultrices volutpat bibendum. Integer posuere tellus et magna ornare, eget dapibus tellus tempor. Vivamus vel metus eget libero posuere maximus vel sed ligula. Maecenas enim ex, tempus sit amet blandit vel, dignissim at nunc. Nam sit amet tristique augue. Pellentesque ornare venenatis imperdiet. Sed et magna turpis. Etiam dictum faucibus ornare. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Cras quis nisl vel lectus congue convallis. Etiam vel ultricies mi. Duis porttitor condimentum justo, dapibus scelerisque ligula malesuada non. Curabitur pretium vel nibh eget egestas. Sed mattis ultrices vehicula. Quisque vestibulum libero id nunc posuere ullamcorper. Praesent tempor, mi eu venenatis aliquam, lorem tortor posuere eros, eu porta enim ligula a urna. Quisque quis risus sit amet turpis luctus scelerisque non ut est. Quisque eget eros id nibh sagittis volutpat ut non nibh. Mauris et viverra leo, lobortis gravida ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Fusce vel dignissim nisi. Nunc commodo metus sed erat blandit venenatis. Proin pellentesque ipsum vitae lacus efficitur, eget venenatis massa tempus. Donec nunc dolor, tempor nec convallis a, viverra eget leo. In hac habitasse platea dictumst. Etiam accumsan urna sit amet sem hendrerit, a sodales magna interdum.Integer convallis arcu vitae massa auctor porta. Vestibulum pellentesque luctus elit id dignissim. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Aenean placerat ac dolor nec sollicitudin. Donec turpis sapien, porttitor et magna dignissim, lacinia porta erat. Maecenas laoreet tellus lorem, eget tincidunt ex ullamcorper maximus. Suspendisse faucibus lacus vitae mi efficitur vehicula. Integer malesuada orci at mauris gravida vestibulum. Sed quis tellus urna. Nulla imperdiet nunc urna, ut pharetra nulla tempus ut. Duis in aliquam diam. Praesent diam odio, ultricies at venenatis i"
    }
}
