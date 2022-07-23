//
//  LiveTherapyView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import CareKitStore
import CareKit
import Charts

struct LiveTherapyChartView: UIViewRepresentable {
//    var entries: [BarChartDataEntry]
    var maxData = [Double]()
//    func makeUIView(context: Context) -> BarChartView {
//        let chart = BarChartView()
//        chart.data = addData()
//        return chart
//    }
    
    func makeUIView(context: Context) -> LineChartView {
        let chart = LineChartView()
        chart.data = addData()
        let yAxis = chart.leftAxis
        yAxis.axisMinimum = -0.8 //hard sets minimum
        
        chart.xAxis.drawGridLinesEnabled = false //hides horizontal gridlines
        chart.leftAxis.drawGridLinesEnabled = false //hides vertical gridlines
        //chart.leftAxis.drawAxisLineEnabled = false
        chart.rightAxis.drawAxisLineEnabled = false //hides right axis
        chart.rightAxis.drawGridLinesEnabled = false //hides other vertical gridlines
        chart.rightAxis.enabled = false //hides right axis fully
        chart.xAxis.labelPosition = XAxis.LabelPosition.bottom //puts x axis on bottom
        chart.xAxis.drawLabelsEnabled = false //hides x axis labels
        chart.leftAxis.drawLabelsEnabled = false //hides y axis labels
        
        //chart.leftAxis.axisMinimum = -0.5 //hard sets minimum
        chart.legend.enabled = false //hides little square legend
        chart.leftAxis.drawTopYLabelEntryEnabled = false //hides values on top of each data point

        
        return chart
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        DispatchQueue.main.async {
            uiView.data = addData()
        }
        
        //get the latest data from watch
        
    }
    
    func addData() -> LineChartData{
//        let data = BarChartData()
//        var maxAccelArray : [BarChartDataEntry] = []
        let data = LineChartData()
        var maxAccelArray : [ChartDataEntry] = []
        print("in add data")
        // convert the Doubles to BarChartDataEntry
//        maxData.suffix(maxData from maxData.count - 6)
//        for i in 1...5 {
//            if i <= maxData.count {
//                var xVal = 6 - Double(i)
//                var yVal = maxData[maxData.count - i]*9.8
//                maxAccelArray.append(ChartDataEntry(x: xVal, y: yVal))
//                print("the y is \(yVal)")
//            }
//        }
        //Option B: live data grows from left & resets every at the end of the x axis, where limits go from 0 to <dataViewLengh>
        let dataViewLength = 15

        for i in 1...dataViewLength {
              if dataViewLength <= maxData.count {
                //let xVal = Double(dataViewLength - i + 1)
                let xVal = Double(i)
                let yVal = (maxData[maxData.count + i - dataViewLength - 1]*9.8)
                maxAccelArray.append(ChartDataEntry(x: xVal, y: yVal))
              
              } else {
                if dataViewLength - i < maxData.count {
                  let xVal = Double(i)
                  let yVal = (maxData[maxData.count - dataViewLength + i - 1]*9.8)
                  maxAccelArray.append(ChartDataEntry(x: xVal, y: yVal))
                } else {
                  let xVal = Double(i)
                  let yVal = 0.0
                  maxAccelArray.append(ChartDataEntry(x: xVal, y: yVal))
                }
              }
           // print("data looped")
        }
        
        let dataSet = LineChartDataSet(entries : maxAccelArray)
        dataSet.colors = [NSUIColor(red: 32.0/255.0, green: 172.0/255.0, blue: 84.0/255.0, alpha: 1.0)]
        let gradientColors = [UIColor.green.cgColor, UIColor.clear.cgColor] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [0.3, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        dataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient
        dataSet.drawFilledEnabled = true // Draw the Gradient
        //dataSet.label = “My Data”
        dataSet.mode = .cubicBezier
        //dataSet.fill = Fill(color: .green)
        //dataSet.fillAlpha = 0.8
        dataSet.lineWidth = 4
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false //remove data values on top of each data point
        //dataSet.drawFilledEnabled = true
        data.addDataSet(dataSet)
        return data
    }
    
    typealias UIViewType = LineChartView
}


