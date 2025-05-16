//
//  Created by Van Thanh on 15/5/25.
//

import Foundation

class UserDetailViewModel: ViewModelType {
    
    private var interactor: UserDetailInteractorProtocol
    private var navigator: UserDetailNavigatorProtocol
    private var input: Input!
    private var output: Output!
    
    private var loginUsername: String
    
    init(navigator: UserDetailNavigatorProtocol,
         interactor: UserDetailInteractorProtocol,
         loginUsername: String) {
        self.navigator = navigator
        self.interactor = interactor
        self.loginUsername = loginUsername
    }
    
    struct Input {}
    
    struct Output {}
    
    func transform(input: Input) -> Output {
        self.input = input
        self.output = Output()
        return output
    }
    
}
