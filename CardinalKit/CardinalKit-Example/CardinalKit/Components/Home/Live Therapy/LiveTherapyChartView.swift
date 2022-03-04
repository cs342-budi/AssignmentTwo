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
        print("in add data")
        // convert the Doubles to BarChartDataEntry
//        maxData.suffix(maxData from maxData.count - 6)
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        // Blynn - To modify Live Therapy Chart Appearance:
        //Option A: live data enters from right, pushing older data to left
        let dataViewLength = 15
        
        for i in 1...dataViewLength {
            if i <= maxData.count {
                let xVal = Double(dataViewLength - i + 1)
                let yVal = maxData[maxData.count - i]*9.8
                maxAccelArray.append(BarChartDataEntry(x: xVal, y: yVal))
                print("the y is \(yVal)")
            } else {
                let xVal = Double(dataViewLength - i + 1)
                let yVal = 0.0
                maxAccelArray.append(BarChartDataEntry(x: xVal, y: yVal))
            }
        }
        
        //Option B: live data grows from left & resets every at the end of the x axis, where limits go from 0 to <dataViewLengh>
        
//        for i in 1...dataViewLength {
//            if (dataViewLength + maxData.count - i) % dataViewLength == 0 {
//                for j in 1...dataViewLength {
//                    //let xVal = Double(j)
//                    if j <= i {
//                        let xVal = Double(j)
//                        let yVal = maxData[maxData.count - i + j - 1]*9.8
//                        maxAccelArray.append(BarChartDataEntry(x: xVal, y: yVal))
//                    } else {
//                        let xVal = Double(j)
//                        let yVal = 0.0
//                        maxAccelArray.append(BarChartDataEntry(x: xVal, y: yVal))
//                    }
//                }
//            }
//        }
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        
        let dataSet = BarChartDataSet(entries : maxAccelArray)
        dataSet.colors = [NSUIColor(red: 255.0/255.0, green: 153.0/255.0, blue: 205.0/255.0, alpha: 1.0)]
        dataSet.label = "My Data"
        data.addDataSet(dataSet)
        return data
    }
    
    typealias UIViewType = BarChartView
}


