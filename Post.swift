//
//  Post.swift
//  SelfieGram
//
//  Created by Emma McPhail on 2017-11-13.
//  Copyright © 2017 Emma McPhail. All rights reserved.
//

import Foundation
import UIKit

class Post {
    
    let imageURL:URL
    let user:User
    let comment:String
    
    init(imageURL:URL, user:User, comment:String){
        self.imageURL = imageURL
        self.user = user
        self.comment = comment
    }
    
}
