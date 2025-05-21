//
//  UserDetailViewController.swift
//  Take-Home
//
//  Created by Van Thanh on 17/5/25.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class UserDetailViewController: BaseViewController<UserDetailViewModel> {

    // Mark: @IBOutlet
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var viewInfoContent: UIView!
    @IBOutlet private weak var imgFollower: UIImageView!
    @IBOutlet private weak var imgFollowing: UIImageView!
    @IBOutlet private weak var locationLB: UILabel!
    @IBOutlet private weak var userNameLB: UILabel!
    @IBOutlet private weak var totalFollowingLB: UILabel!
    @IBOutlet private weak var totalFollowerLB: UILabel!
    @IBOutlet private weak var blogLB: UILabel!
    
    override func bindViewModel() {
        super.bindViewModel()
        let input = UserDetailViewModel.Input(viewWillAppear: rx.viewWillAppear.asDriver(),
                                              backBtn: self.navigationItem.leftBarButtonItem?.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        
        output.userDetails
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] user in
                guard let self = self else { return }
                self.userNameLB.text = user?.name
                self.locationLB.text = user?.location
                self.totalFollowerLB.text = (user?.followers ?? 0) < 100 ? String(user?.followers ?? 0) : "100+"
                self.totalFollowingLB.text = (user?.following ?? 0) < 100 ? String(user?.following ?? 0) : "100+"
                self.blogLB.text = user?.blog
                if let url = URL(string: user?.avatarURL ?? "") {
                    self.avatarImage.kf.setImage(with: url,
                                                 placeholder: UIImage(named: "avatar_default"),
                                                 options: [.cacheMemoryOnly])
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    override func configView() {
        super.configView()
        setDefautNavigationBar(title: ScreenTitleConst.titleUserDetail)
        viewInfoContent.clipsToBounds = true
        viewInfoContent.layer.cornerRadius = 10
        viewInfoContent.superview?.sketchShadow(x: 4, y: 4, opacity: 0.2)
        imgFollower.superview?.makeCircle()
        imgFollowing.superview?.makeCircle()
        avatarImage.makeCircle()
        avatarImage.drawBackGroundView()
    }
    
}
