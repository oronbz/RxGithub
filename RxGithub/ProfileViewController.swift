//
//  ProfileViewController.swift
//  RxGithub
//
//  Created by Oron Ben Zvi on 2/20/17.
//  Copyright © 2017 Oron Ben Zvi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Spring

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userImage: DesignableImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var showCommentsButton: DesignableButton!
    
    var viewModel: ProfileViewModeling!
    
    private var disposeBag = DisposeBag()
    
    private var commentsViewModel: CommentsViewModeling!

    override func viewDidLoad() {
        super.viewDidLoad()

        userLabel.text = viewModel.username
        
        setupBindings()
    }
    
    private func setupBindings() {
        
        showCommentsButton.rx.tap
            .bindTo(viewModel.showCommentsDidTap)
            .disposed(by: disposeBag)
        
        viewModel.image
            .bindTo(userImage.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.showComments
            .subscribe(onNext: { [unowned self] in
                self.commentsViewModel = $0
                self.performSegue(withIdentifier: "Comments", sender: self)
            }).disposed(by: disposeBag)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Comments") {
            let controller = segue.destination as! CommentsViewController
            controller.viewModel = commentsViewModel
        }
    }

}
