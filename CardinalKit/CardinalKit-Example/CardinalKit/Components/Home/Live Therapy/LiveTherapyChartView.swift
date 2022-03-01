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
    func makeUIView(context: Context) -> BarChartView {
        let chart = BarChartView()
        chart.data = addData()
        return chart
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) {
        uiView.data = addData()
        //get the latest data from watch
        
    }
    
    func addData() -> BarChartData{
        let data = BarChartData()
        
        var maxAccelArray : [BarChartDataEntry] = []

        // convert the Doubles to BarChartDataEntry
//        maxData.suffix(maxData from maxData.count - 6)
        for i in 1...5 {
            if i <= maxAccelArray.count {
                var xVal = 6 - Double(i)
                var yVal = maxData[maxData.count - i]
                maxAccelArray.append(BarChartDataEntry(x: xVal, y: yVal))
            }
        }
        let dataSet = BarChartDataSet(entries : maxAccelArray)
        dataSet.colors = [NSUIColor.green]
        dataSet.label = "My Data"
        data.addDataSet(dataSet)
        return data
    }
    
    typealias UIViewType = BarChartView
}


