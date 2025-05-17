//
//  BaseViewController.swift
//  Take-Home
//
//  Created by Van Thanh on 15/5/25.
//

import UIKit
import RxSwift

class BaseViewController<T>: UIViewController {
    
    var disposeBag = DisposeBag()
    var viewModel: T!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configView()
        self.bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setDefautNavigationBar(title: String? = nil, leftBarButtonImage: UIImage? = nil, rightBarButtonImage: UIImage? = nil) {
        self.title = title ?? "メールアドレスを認証"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftBarButtonImage ?? UIImage(systemName: "arrow.backward"),
                                                                style: .plain,
                                                                target: self,
                                                                action: nil)
    }
    
    func configView() {}
    func bindViewModel() {}
    
//    func initCustomNavigation<T:NavigationBarView>(_ type: NavigationBarType) -> T {
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
//        let nav = NavigationBarView.initUsingAutoLayout(type, view: view) as! T
//        myNavigationBar = nav
//        return nav
//    }
//    
//    func initNaviBarSearch(withType type: NavigationBarType = .delivery, frame: CGRect?) {
//        if myNavigationBar == nil {
//            let rect = frame == nil ? CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: CGFloat(MyAppLication.navigationBarHeight + 44).makeSizeScaleForIPad()) : frame
//            myNavigationBar = NavigationBarView.initFromNib(type: type, frame: rect ?? CGRect())
//            self.view.addSubview(myNavigationBar!)
//            
//            if let navigation = myNavigationBar as? HeaderOrderView {
//                navigation.lbTitle.makeFontSizeScaleForIPad()
//            }
//        }
//    }
//    
//    @objc func dismissThisView() {
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    @objc func popScreen() {
//        self.dismissViewController()
//    }
    
    deinit { print("deinit: \(self)") }
}
