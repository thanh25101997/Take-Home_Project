//
//  Created by Van Thanh on 15/5/25.
//

import Foundation
import RxSwift
import RxCocoa

class UserDetailViewModel: ViewModelType {
    
    private var interactor: UserDetailInteractorProtocol
    private var navigator: UserDetailNavigatorProtocol
    private var input: Input!
    private var output: Output!
    private var disposeBag = DisposeBag()
    
    private var loginUsername: String
    
    init(navigator: UserDetailNavigatorProtocol,
         interactor: UserDetailInteractorProtocol,
         loginUsername: String) {
        self.navigator = navigator
        self.interactor = interactor
        self.loginUsername = loginUsername
    }
    
    struct Input {
        let viewWillAppear: ControlEvent<Bool>
        let backBtn: Driver<Void>?
    }
    
    struct Output {
        
        let avatarUrl: BehaviorRelay<String> = .init(value: "")
        let userDetails: BehaviorRelay<UserDetailsEntity?> = .init(value: nil)
        
    }
    
    func transform(input: Input) -> Output {
        self.input = input
        self.output = Output()
        
        input.viewWillAppear.flatMap({ _ in
            return self.interactor.getUser(loginUserName: self.loginUsername)
                .catch({ _ in
                    return Observable.empty()
                })
        })
        .bind(to: output.userDetails)
        .disposed(by: disposeBag)
        
        input.backBtn?.drive(onNext: { [weak self] _ in
            self?.navigator.backToHome()
        }).disposed(by: disposeBag)
        
        return output
    }
    
}
