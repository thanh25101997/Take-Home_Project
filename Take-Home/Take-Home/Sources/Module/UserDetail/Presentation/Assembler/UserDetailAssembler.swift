//
//  Created by Van Thanh 2025.
//

import Foundation

protocol UserDetailAssembler where Self: DefaultAssembler {
    func createModule(loginUsername: String) -> UserDetailViewController
}

extension UserDetailAssembler where Self: DefaultAssembler {
    
    func createModule(loginUsername: String) -> UserDetailViewController {
        let vc = UserDetailViewController()
        let vm = UserDetailViewModel(navigator: UserDetailNavigator(vc: vc),
                                     interactor: UserDetailInteractor(),
                                     loginUsername: loginUsername)
        vc.viewModel = vm
        return vc
    }
    
}
