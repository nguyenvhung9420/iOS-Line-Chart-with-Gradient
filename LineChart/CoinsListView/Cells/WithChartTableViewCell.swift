//
//  WithChartTableViewCell.swift
//  LineChart
//
//  Created by Hung Nguyen on 23/10/2021.
//  Copyright © 2021 Nguyen Vu Nhat Minh. All rights reserved.
//

import UIKit
import Charts


class WithChartTableViewCell: UITableViewCell {
    @IBOutlet weak var coinNameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var chartView: LineChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        generateData()
        configCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell() {
        self.priceLbl?.text = "Hung"
        self.coinNameLbl?.text = "Ahyhy"
        self.chartView.delegate = self
    }
    
    func generateData() {
//        self.setDataCount(20, range: 100)
        let count = 20
        let range: UInt32 = 100
        let values = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 3)
            return ChartDataEntry(x: Double(i), y: val, icon: #imageLiteral(resourceName: "icon"))
        }
        
        let set1 = LineChartDataSet(entries: values, label: "DataSet 1")
        set1.drawIconsEnabled = false
        set1.mode = .cubicBezier
//        set1.lineDashLengths = [5, 2.5]
//        set1.highlightLineDashLengths = [5, 2.5]
        set1.setColor(.black)
        set1.setCircleColor(.black)
        set1.lineWidth = 0.5
        set1.circleRadius = 5
        set1.drawCircleHoleEnabled = false
//        set1.valueFont = .systemFont(ofSize: 9)
//        set1.formLineDashLengths = [5, 2.5]
//        set1.formLineWidth = 1
//        set1.formSize = 15
        
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set1.fillAlpha = 1
        set1.fill = Fill(linearGradient: gradient, angle: 90)
        set1.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: set1)
        
        chartView.data = data
        chartView.dragXEnabled = true
        chartView.gridBackgroundColor = .clear
        
        set1.drawValuesEnabled = false
        set1.drawIconsEnabled = false
        set1.drawCirclesEnabled = false
        set1.drawCircleHoleEnabled = false
        set1.drawVerticalHighlightIndicatorEnabled = false
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.setDrawHighlightIndicators(false)
        
        chartView.drawBordersEnabled = false
        chartView.drawMarkers = false
        chartView.legend.enabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.xAxis.enabled = false
    }
    
    
}

extension WithChartTableViewCell: ChartViewDelegate {
    
}
