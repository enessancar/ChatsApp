//
//  NewMessageViewController.swift
//  ChatsApp
//
//  Created by Enes Sancar on 27.01.2023.
//

import UIKit

protocol NewMessageViewControllerProtocol: AnyObject {
    func goToChatView(user: User)
}

class NewMessageViewController: UIViewController {

    //MARK: - Properties
    weak var delegate: NewMessageViewControllerProtocol?
    private let reuseIdentifer = "UserCell"
    private let tableView = UITableView()
    private var users = [User]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Service.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
}

extension NewMessageViewController {
    
    private func style() {
        //tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifer)
        tableView.rowHeight = 75
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
//MARK: - UITableView function
extension NewMessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! UserCell
        cell.user = users[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.goToChatView(user: users[indexPath.row])
    }
}
