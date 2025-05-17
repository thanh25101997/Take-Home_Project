//
//  Created by Van Thanh on 15/5/25.
//

import Foundation

protocol UserDetailNavigatorProtocol {
    
    func backToHome()
    
}

class UserDetailNavigator: BaseNavigator,
                           UserDetailNavigatorProtocol {
    
    func backToHome() {
        vc?.navigationController?.popViewController(animated: true)
    }
    
}
