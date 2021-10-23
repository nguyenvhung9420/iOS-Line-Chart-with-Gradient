//
//  ChartInCellViewController.swift
//  LineChart
//
//  Created by Hung Nguyen on 23/10/2021.
//  Copyright © 2021 Nguyen Vu Nhat Minh. All rights reserved.
//

import UIKit

class ChartInCellViewController: UIViewController {

    @IBOutlet weak var coinsTableVIew: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        coinsTableVIew.delegate = self
        coinsTableVIew.dataSource = self
        
        coinsTableVIew.register(WithChartTableViewCell.self, forCellReuseIdentifier: "cell")
    }
}


extension ChartInCellViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WithChartTableViewCell
//        cell.coinNameLbl?.text = "Hung"
//        cell.priceLbl?.text = "Hung"
        cell.configCell()
        return cell
    }
}

 
extension ChartInCellViewController: UITableViewDelegate {
    
}

