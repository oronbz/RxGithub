//
//  CommentsViewController.swift
//  RxGithub
//
//  Created by Oron Ben Zvi on 2/20/17.
//  Copyright © 2017 Oron Ben Zvi. All rights reserved.
//

import UIKit
import Spring

class CommentsViewController: UIViewController {

    @IBOutlet weak var inserCommentField: DesignableTextField!
    @IBOutlet weak var insertCommentView: UIView!
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var inputAccessoryView: UIView {
        return insertCommentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertCommentView.removeFromSuperview()
        // Do any additional setup after loading the view.
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

// MARK: - UITableViewDatasource
extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "CommentCell") ?? UITableViewCell()
    }
}
