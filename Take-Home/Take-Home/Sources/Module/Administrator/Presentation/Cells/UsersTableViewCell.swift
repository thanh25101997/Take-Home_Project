//
//  UsersTableViewCell.swift
//  Take-Home
//
//  Created by Van Thanh on 15/5/25.
//

import UIKit
import Kingfisher

class UsersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var userNameLb: UILabel!
    @IBOutlet weak var htmlLinkLB: UILabel!
    @IBOutlet weak var viewInfoUser: UIView!
    
    var user: User?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        viewInfoUser.clipsToBounds = true
        viewInfoUser.layer.cornerRadius = 10
        viewInfoUser.superview?.sketchShadow(x: 4, y: 4, opacity: 0.2)
        imgAvatar.makeCircle()
        imgAvatar.drawBackGroundView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(user: User) {
        self.user = user
        userNameLb.text = user.login
        htmlLinkLB.text = user.htmlUrl
        
        self.imgAvatar.image = UIImage(named: "avatar_default")
        guard let url = URL(string: user.avatarUrl ?? "") else { return }
        KingfisherManager.shared.retrieveImage(with: url,
                                               options: [.cacheMemoryOnly]) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    if self.user?.id == user.id {
                        self.imgAvatar.image = value.image
                    }
                }
            case .failure(let error):break
            }
        }
    }
    
}
