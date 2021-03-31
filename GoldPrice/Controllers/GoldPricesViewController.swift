//
//  GoldPricesController.swift
//  GoldPrice
//
//  Created by HieuTong on 3/30/21.
//

import UIKit
import SnapKit

class GoldPricesViewController: UIViewController {
    
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
    
    private var prices = [GoldPrice]()
    private var viewModels = [ContentCellViewModel]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "RTH Gold Price"
        tableView.delegate = self
        tableView.dataSource = self
        fetchData()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        formatBar()
    }

    func setupViews() {
        view.addSubview(tableView)
        view.addSubview(curvedlineChart)
        curvedlineChart.isCurved = true
        
        curvedlineChart.snp.makeConstraints { (maker) in
            maker.leading.top.trailing.equalToSuperview()
            maker.height.equalTo(screenHeight/3)
        }

        tableView.snp.makeConstraints { (maker) in
            maker.leading.bottom.trailing.equalToSuperview()
            maker.top.equalTo(curvedlineChart.snp.bottom).offset(padding)
        }
    }
 
    func formatBar() {
        navigationController?.setNavBarTitle(color: .blue_1, size: 20)
        navigationController?.setBackgroundAndShadowImage(bgColor: UIColor.white, sdColor: UIColor.blue_2)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "info_icon"), style: .done, target: self, action: #selector(didTapSettings))
    }
    
    func fetchData() {
        GetGoldPriceWorker(successAction: didGetDataSuccess, failAction: didGetDataFail).execute()
    }
    
    func didGetDataSuccess(_ prices: [GoldPrice]) {
        self.prices = prices
        curvedlineChart.dataEntries = prices.compactMap({ PointEntry(value: Int(Double($0.amount) ?? 0), label: String.formattedDate(string: $0.date, format: "d MMM")) })
        self.viewModels = prices.compactMap({ ContentCellViewModel(title: String.formattedDate(string: $0.date, format: "dd MMMM YYYY"), content: "$ \($0.amount)")}).reversed()
        self.tableView.reloadData()
    }
    
    func didGetDataFail(_ err: MError) {
        MessageManager.shared.show(message: err.error ?? "Oops, something went wrong!", type: .error)
    }
    
    @objc func didTapSettings() {
        let vc = SettingViewController()
        push(vc)
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



