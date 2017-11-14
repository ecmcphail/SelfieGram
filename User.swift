//
//  User.swift
//  SelfieGram
//
//  Created by Emma McPhail on 2017-11-13.
//  Copyright © 2017 Emma McPhail. All rights reserved.
//

import Foundation
import UIKit

class User {
    let username:String
    let profileImage: UIImage
    
    init(username:String, profileImage:UIImage) {
        self.username = username
        self.profileImage = profileImage
    }
}
