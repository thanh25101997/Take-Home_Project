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
        let interactor =  UserDetailInteractor(userDetailRepository: UserDetailRepository())
        let navigator = UserDetailNavigator(vc: vc)
        let vm = UserDetailViewModel(navigator: navigator,
                                     interactor: interactor,
                                     loginUsername: loginUsername)
        vc.viewModel = vm
        return vc
    }
    
}
