//
//  CommentsViewController.swift
//  RxGithub
//
//  Created by Oron Ben Zvi on 2/20/17.
//  Copyright © 2017 Oron Ben Zvi. All rights reserved.
//

import UIKit
import Spring
import RxSwift
import RxCocoa

class CommentsViewController: UIViewController {

    @IBOutlet weak var inserCommentField: DesignableTextField!
    @IBOutlet weak var insertCommentView: UIView!
    @IBOutlet weak var submitButton: DesignableButton!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CommentsViewModeling!
    
    private let disposeBag = DisposeBag()
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var inputAccessoryView: UIView {
        return insertCommentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertCommentView.removeFromSuperview()
        
        setupBindings()
    }
    
    private func setupBindings() {
        
        inserCommentField.rx.text.orEmpty
            .bind(to: viewModel.commentText)
            .disposed(by: disposeBag)
        
        submitButton.rx.tap
            .do(onNext: { [unowned self] in
                self.inserCommentField.text = ""
            })
            .bind(to: viewModel.submitDidTap)
            .disposed(by: disposeBag)
        
        viewModel.submitEnabled
            .bind(to: submitButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.comments
            .bind(to: tableView.rx.items(cellIdentifier: "CommentCell", cellType: CommentCell.self)) { index, comment, cell in
                cell.comment = comment
            }.disposed(by: disposeBag)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        inserCommentField.resignFirstResponder()
    }
    
    
    @IBAction func submitDidTap(_ sender: Any) {
        inserCommentField.resignFirstResponder()
    }
    @IBAction func tableViewDidTap(_ sender: Any) {
        inserCommentField.resignFirstResponder()

    }
}

// MARK: - UITableViewDelegate
extension CommentsViewController: UITableViewDelegate {
    
}
