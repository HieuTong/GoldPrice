//
//  ProfileViewController.swift
//  GoldPrice
//
//  Created by HieuTong on 4/1/21.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
    let avatarURL = "https://i.scdn.co/image/ab6775700000ee85918449113dd3eb8d1344ddf7"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ContentTableViewCell.self, forCellReuseIdentifier: ContentTableViewCell.identifier)
        return tableView
    }()
    
    private var models = [UserProfile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackButton(tintColor: .black)
        title = "Profile"
        addProfile()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func addProfile() {
        models.append(UserProfile(info: "Name", value: "HieuTong"))
        models.append(UserProfile(info: "Email", value: "hieutongle@gmail.com"))
        createTableHeader(with: avatarURL)
        tableView.reloadData()
    }
    
    private func createTableHeader(with string: String?) {
        guard let urlString = string, let url = URL(string: urlString) else { return }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width/1.5))
        
        let imageSize: CGFloat = headerView.height/2
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        imageView.contentMode = .scaleAspectFill
        imageView.sd_setImage(with: url, completed: nil)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize / 2
        
        tableView.tableHeaderView = headerView
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.identifier, for: indexPath) as? ContentTableViewCell else {
            return UITableViewCell()
        }
        let model = models[indexPath.row]
        cell.configure(with: ContentCellViewModel(title: model.info, content: model.value))
        return cell
    }
}
