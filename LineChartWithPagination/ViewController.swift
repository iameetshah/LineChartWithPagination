//
//  ViewController.swift
//  LineChartWithPagination
//
//  Created by Mit Shah on 21/12/21.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    @IBOutlet var lineChartView: LineChartView!
    struct Constants {
        static let currentLineDataSetLabel = "currentLineDataSetLabel"
        static let previousLineDataSetLabel = "previousLineDataSetLabel"
        static let totalValue : Double = 1200 // Received from backend
        static let currency = "INR" // Received from backend
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupDataSets(currency: Constants.currency,
                      dataSets1: SomeEntity.sampleDataSet1,
                      dataSets2: SomeEntity.sampleDataSet2,
                      totalVal: Constants.totalValue)
    }
    func setupLineChart() {
        // Graph Position
        lineChartView.extraLeftOffset = 25.0
        lineChartView.extraTopOffset = 15.0
        lineChartView.extraBottomOffset = 15.0
        lineChartView.extraRightOffset = 25.0
        
        // Graph Config
        let xAxis = lineChartView.xAxis
        let leftAxis = lineChartView.leftAxis
        let rightAxis = lineChartView.rightAxis
        rightAxis.spaceBottom = 0
        leftAxis.enabled = false
        xAxis.labelPosition = .bottom
        lineChartView.legend.enabled = false
        lineChartView.drawGridBackgroundEnabled = false
        
        xAxis.granularity = 1.0
        xAxis.labelCount = 10
        
        lineChartView.pinchZoomEnabled = false
        lineChartView.doubleTapToZoomEnabled = false
        
        lineChartView.backgroundColor = .white
        
        // Graph Chart Description
        lineChartView.chartDescription?.textColor = UIColor.black.withAlphaComponent(0.5)
        lineChartView.chartDescription?.enabled = true
        lineChartView.chartDescription?.text = "Count" // Update as per your needs
        lineChartView.chartDescription?.position = CGPoint(x: UIScreen.main.bounds.width - 32, y: 0)
        lineChartView.chartDescription?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        // Graph X Axis and Right Axis Color
        xAxis.axisLineColor = UIColor.black.withAlphaComponent(0.2)
        xAxis.gridColor = UIColor.black.withAlphaComponent(0.2)
        xAxis.labelTextColor = UIColor.black.withAlphaComponent(0.5)
        rightAxis.gridColor = UIColor.black.withAlphaComponent(0.2)
        rightAxis.axisLineColor = UIColor.black.withAlphaComponent(0.2)
        rightAxis.labelTextColor = UIColor.black.withAlphaComponent(0.5)
        
        // Graph X Axis and Right Axis Font
        rightAxis.labelFont = UIFont.systemFont(ofSize: 12, weight: .regular)
        xAxis.labelFont = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
    func lineDataEntry(xValue: Double,
                           yValue: Double) -> LineChartDataEntry {
        return LineChartDataEntry(xValue: xValue, yValue: yValue)
    }
    
    
    
    func setupDataSets(currency: String,
                       dataSets1: [SomeEntity],
                       dataSets2: [SomeEntity],
                       totalVal:Double,
                       showPrevious: Bool = true) {
        setupLineChart()
        var currentLineEntries = [ChartDataEntry]()
        var previousLineEntries = [ChartDataEntry]()
        for interval in 0..<dataSets1.count {
            currentLineEntries.append(lineDataEntry(xValue: Double(interval), yValue: Double(dataSets1[interval].count)))
            
            if showPrevious {
                previousLineEntries.append(lineDataEntry(xValue: Double(interval), yValue:Double(dataSets2[interval].count)))
                
            }
        }
        // Update as per your needs
        let computedInterval = (totalVal / 30).rounded(.up)
        lineChartView.xAxis.valueFormatter = CustomValueFormatter(interval: Int(computedInterval), currency: currency)
        lineChartView.setScaleMinima(2.9, scaleY: 1)
        lineChartView.scaleXEnabled = false
        lineChartView.scaleYEnabled = false

        /* Line data set */
        let currentLineDataSet = dataSetWith(entries: currentLineEntries,
                                             color: UIColor.blue,
                                             label: Constants.currentLineDataSetLabel)
        currentLineDataSet.axisDependency = .right
        
        if !previousLineEntries.isEmpty {
            let previousLineDataSet = dataSetWith(entries: previousLineEntries,
                                                  color: UIColor.red,
                                                  label: Constants.previousLineDataSetLabel)
            previousLineDataSet.axisDependency = .right
            var combinedData = LineChartData()
            if showPrevious {
                combinedData = LineChartData(dataSets: [currentLineDataSet, previousLineDataSet])
            }
            else {
                combinedData = LineChartData(dataSets: [currentLineDataSet])
            }
            lineChartView.data = combinedData
            lineChartView.rightAxis.labelCount = 5 // Update as per your needs
        }
        
        lineChartView.notifyDataSetChanged()
    }
   
    func dataSetWith(entries: [ChartDataEntry], color: UIColor, label: String = "") -> LineChartDataSet {
        
        let lineChartSet = LineChartDataSet(entries: entries, label: label)
        lineChartSet.drawCirclesEnabled = false
        lineChartSet.drawValuesEnabled = false
        lineChartSet.highlightColor = .clear
        lineChartSet.drawCircleHoleEnabled = false
        lineChartSet.lineWidth = 2
        lineChartSet.fillColor = UIColor.blue
        lineChartSet.colors = [UIColor.blue]
        
        
        if label == Constants.previousLineDataSetLabel {
            lineChartSet.lineDashPhase = 0
            lineChartSet.lineDashLengths = [3, 6]
        }
        return lineChartSet
        
    }
}

