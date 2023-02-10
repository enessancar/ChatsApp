//
//  MessageViewController.swift
//  ChatsApp
//
//  Created by Enes Sancar on 27.01.2023.
//

import UIKit
import SnapKit

private let reuseIdentidier = "MessageCell"

protocol MessageViewControllerProtocol: AnyObject {
    func showChatViewController(_ messageViewController: MessageViewController, user: User )
}

class MessageViewController: UIViewController {

    //MARK: - Properties
    weak var delegate: MessageViewControllerProtocol?
    private let tableView = UITableView()
    private var lastUsers = [LastUser]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLastUsers()
        style()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchLastUsers()
    }
    
    //MARK: - Service
    private func fetchLastUsers() {
        Service.fethLastUsers { lastUsers in
            self.lastUsers = lastUsers
            self.tableView.reloadData()
        }
    }
}

//MARK: - Helpers
extension MessageViewController {
    private func style() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MessageCell.self, forCellReuseIdentifier: reuseIdentidier)
    }
    
    private func layout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDelegate/DataSource
extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentidier, for: indexPath) as! MessageCell
        cell.lastUser = lastUsers[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lastUsers.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.showChatViewController(self, user: lastUsers[indexPath.row].user)
    }
}
