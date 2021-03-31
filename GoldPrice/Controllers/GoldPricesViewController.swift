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
        tableView.register(GoldPriceTableViewCell.self, forCellReuseIdentifier: GoldPriceTableViewCell.identifier)
        return tableView
    }()
    
    private var prices = [GoldPrice]()
    private var viewModels = [GoldPriceCellViewModel]()
        
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
        let infoButton = UIButton(type: .system)
        infoButton.setImage(UIImage(named: "info_icon"), for: .normal)
        infoButton.addTarget(self, action: #selector(handleShowInfo), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: infoButton)
    }
    
    func fetchData() {
        GetGoldPriceWorker(successAction: didGetDataSuccess, failAction: didGetDataFail).execute()
    }
    
    func didGetDataSuccess(_ prices: [GoldPrice]) {
        self.prices = prices
        curvedlineChart.dataEntries = prices.compactMap({ PointEntry(value: Int(Double($0.amount) ?? 0), label: String.formattedDate(string: $0.date, format: "d MMM")) })
        self.viewModels = prices.compactMap({ GoldPriceCellViewModel(date: String.formattedDate(string: $0.date, format: "dd MMMM YYYY"), price: "$ \($0.amount)")}).reversed()
        self.tableView.reloadData()
    }
    
    func didGetDataFail(_ err: MError) {
        MessageManager.shared.show(message: err.error ?? "Oops, something went wrong!", type: .error)
    }
    
    @objc func handleShowInfo() {
        //handle show info
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GoldPriceTableViewCell.identifier, for: indexPath) as? GoldPriceTableViewCell else {
             return UITableViewCell()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
}



