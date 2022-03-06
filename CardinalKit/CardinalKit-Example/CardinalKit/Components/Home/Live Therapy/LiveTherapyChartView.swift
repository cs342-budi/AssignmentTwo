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
        yAxis.axisMinimum = 0
        
        chart.xAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawAxisLineEnabled = false
        chart.rightAxis.drawAxisLineEnabled = false
        chart.rightAxis.drawGridLinesEnabled = false
        chart.rightAxis.enabled = false
        chart.xAxis.labelPosition = XAxis.LabelPosition.bottom

        
        return chart
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        uiView.data = addData()
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
        let dataViewLength = 10
        for i in 1...dataViewLength {
              if dataViewLength <= maxData.count {
                //let xVal = Double(dataViewLength - i + 1)
                let xVal = Double(i)
                let yVal = maxData[maxData.count + i - dataViewLength - 1]*9.8
                maxAccelArray.append(ChartDataEntry(x: xVal, y: yVal))
                
              } else {
                if dataViewLength - i < maxData.count {
                  let xVal = Double(i)
                  let yVal = maxData[dataViewLength-i]*9.8
                  maxAccelArray.append(ChartDataEntry(x: xVal, y: yVal))
                } else {
                  let xVal = Double(i)
                  let yVal = 0.0
                  maxAccelArray.append(ChartDataEntry(x: xVal, y: yVal))
                }
              }
        }
        
        let dataSet = LineChartDataSet(entries : maxAccelArray)
        dataSet.mode = .cubicBezier
        dataSet.fill = Fill(color: .green)
        dataSet.fillAlpha = 0.8
        dataSet.lineWidth = 4
        dataSet.drawCirclesEnabled = false
        dataSet.drawFilledEnabled = true
      
     

        dataSet.colors = [NSUIColor.green]
        dataSet.label = "My Data"
        data.addDataSet(dataSet)
        return data
    }
    
    typealias UIViewType = LineChartView
}


