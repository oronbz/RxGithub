//
//  UserCell.swift
//  RxGithub
//
//  Created by Oron Ben Zvi on 2/21/17.
//  Copyright © 2017 Oron Ben Zvi. All rights reserved.
//

import UIKit
import Spring
import RxSwift
import RxCocoa

class UserCell: UITableViewCell {
    
    
    @IBOutlet weak var userImage: DesignableImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    private var disposeBag: DisposeBag? = DisposeBag()
    
    var viewModel: UserCellModeling? {
        didSet {
            let disposeBag = DisposeBag()
            
            guard let viewModel = viewModel else { return }
            
            viewModel.image
                .bind(to: userImage.rx.image)
                .disposed(by: disposeBag)
            
            userLabel.text = viewModel.username
            
            self.disposeBag = disposeBag
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        viewModel = nil
        disposeBag = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
