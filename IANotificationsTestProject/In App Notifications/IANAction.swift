import Foundation

struct IANAction {
    let message: String
    var action: ((IANAction) -> Void)?
    
    init(message: String, action: ((IANAction) -> Void)? = nil) {
        self.message = message
        
        if let action = action {
            self.action = action
        }
    }
}
