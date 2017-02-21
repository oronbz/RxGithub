//
//  CommentCell.swift
//  RxGithub
//
//  Created by Oron Ben Zvi on 2/21/17.
//  Copyright © 2017 Oron Ben Zvi. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var commentLabel: UILabel!
    
    // You could define a view model here
    var comment: String = "" {
        didSet {
            commentLabel.text = comment
        }
    }

}
