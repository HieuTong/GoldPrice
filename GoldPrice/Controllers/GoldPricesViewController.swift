//
//  GoldPricesController.swift
//  GoldPrice
//
//  Created by HieuTong on 3/30/21.
//

import UIKit
import SnapKit
import Reachability

class GoldPricesViewController: UIViewController {
    
    let reachability = try! Reachability()
    
    lazy var curvedlineChart: LineChart = {
        let lineChart = LineChart()
        return lineChart
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ContentTableViewCell.self, forCellReuseIdentifier: ContentTableViewCell.identifier)
        return tableView
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .whiteLarge)
        activity.color = UIColor.blue_1
        return activity
    }()
    
    private var prices = [GoldPrice]()
    private var viewModels = [ContentCellViewModel]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setReachabilityNotifier()
    }

    func setupViews() {
        view.addSubviews(views: activityIndicatorView, tableView, curvedlineChart)
        curvedlineChart.isCurved = true
        
        activityIndicatorView.snp.makeConstraints { (maker) in
            maker.centerX.centerY.equalToSuperview()
            maker.height.width.equalTo(20)
        }
        
        curvedlineChart.snp.makeConstraints { (maker) in
            maker.leading.top.trailing.equalToSuperview()
            maker.height.equalTo(screenHeight/3)
        }

        tableView.snp.makeConstraints { (maker) in
            maker.leading.bottom.trailing.equalToSuperview()
            maker.top.equalTo(curvedlineChart.snp.bottom).offset(padding)
        }
    }
    
    func setupNetworkErrorView() {
        navigationController?.hideBar(true)
        let offLineView = OfflineView()
        view.addSubviews(views: offLineView)
        offLineView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
 
    func formatBar() {
        title = "RTH Gold Price"
        navigationController?.setNavBarTitle(color: .blue_1, size: 20)
        navigationController?.setBackgroundAndShadowImage(bgColor: UIColor.white, sdColor: UIColor.blue_2)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "info_icon"), style: .done, target: self, action: #selector(didTapSettings))
    }
    
    private func setReachabilityNotifier() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
            do{
              try reachability.startNotifier()
            }catch{
              print("could not start reachability notifier")
            }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        if reachability.connection != .unavailable {
            DispatchQueue.main.async {
                self.setupViews()
                self.formatBar()
                self.fetchData()
            }
        } else {
            DispatchQueue.main.async {
                self.setupNetworkErrorView()
            }
        }
    }
    
    func fetchData() {
        activityIndicatorView.startAnimating()
        GetGoldPriceWorker(successAction: didGetDataSuccess, failAction: didGetDataFail).execute()
    }
    
    func didGetDataSuccess(_ prices: [GoldPrice]) {
        activityIndicatorView.stopAnimating()
        self.prices = prices
        curvedlineChart.dataEntries = prices.compactMap({ PointEntry(value: Int(Double($0.amount) ?? 0), label: String.formattedDate(string: $0.date, format: "d MMM")) })
        self.viewModels = prices.compactMap({ ContentCellViewModel(title: String.formattedDate(string: $0.date, format: "dd MMMM YYYY"), content: "$ \($0.amount)")}).reversed()
        self.tableView.reloadData()
    }
    
    func didGetDataFail(_ err: MError) {
        activityIndicatorView.stopAnimating()
        MessageManager.shared.show(message: err.error ?? "Oops, something went wrong!", type: .error)
    }
    
    @objc func didTapSettings() {
        let vc = SettingViewController()
        push(vc)
    }
    
    deinit {
        print("deinit")
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
}


extension GoldPricesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.identifier, for: indexPath) as? ContentTableViewCell else {
             return UITableViewCell()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
}



