//
//  UserCellViewModel.swift
//  Yay!
//
//  Created by Spam C. on 2/8/23.
//

import UIKit

class UserCellViewModel {
    var user: User!
    var isMainUser = false
    
    var imageProfileUrl: URL? { user.profileImageUrl }
    var firstName: String { isMainUser ? "My Profile" : user.firstName }
    var backgroundColor: UIColor { isMainUser ? AppColor.Border : AppColor.Gradient }
}
