//
//  Activity.swift
//  SelfieGram
//
//  Created by Emma McPhail on 2017-11-29.
//  Copyright © 2017 Emma McPhail. All rights reserved.
//

import Foundation
import UIKit
import Parse

class Activity:PFObject, PFSubclassing {
    
    @NSManaged var type:String
    @NSManaged var post:Post
    @NSManaged var user:PFUser
    
    static func parseClassName() -> String {
        return "Activity"
    }
    
    convenience init(type:String, post:Post, user:PFUser){
        self.init()
        self.type = type
        self.post = post
        self.user = user
    }
    
}
