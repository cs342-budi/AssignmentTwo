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
    var entries: [BarChartDataEntry]
    func makeUIView(context: Context) -> BarChartView {
        let chart = BarChartView()
        chart.data = addData()
        return chart
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) {
        uiView.data = addData()
    }
    
    func addData() -> BarChartData{
        let data = BarChartData()
        let dataSet = BarChartDataSet(entries: entries)
        dataSet.colors = [NSUIColor.green]
        dataSet.label = "My Data"
        data.addDataSet(dataSet)
        return data
    }
    
    typealias UIViewType = BarChartView
}



struct LiveTherapyChartView_Previews: PreviewProvider {
    static var previews: some View {
        LiveTherapyChartView(entries: [
                //x - position of a bar, y - height of a bar
                BarChartDataEntry(x: 1, y: 1),
                BarChartDataEntry(x: 2, y: 2),
                BarChartDataEntry(x: 3, y: 3),
                BarChartDataEntry(x: 4, y: 4),
                BarChartDataEntry(x: 5, y: 5)
            ]).padding(.top, 20 )
            .padding(.leading, 50)
            .overlay(Text("Acceleration")
            .font(.system(size: 15))
            .fontWeight(.medium)
            .rotationEffect(.degrees(270))
            .offset(x: -10.0, y: 0.0),
            alignment: .leading)
            .overlay(Text("Time (seconds)")
            .font(.system(size: 15))
            .fontWeight(.medium)
            .offset(x: 10.0, y: 0.0),
            alignment: .top)
    }
}

