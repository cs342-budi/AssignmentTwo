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
    var entries: [ChartDataEntry]
//    func overlay<Overlay>(_ overlay: Overlay, alignment: Alignment = .center) {
//        LiveTherapyChartView(entries: populateXYCharData( xvec: myXData, yvec: myYData ) , mylinecolor: [UIColor(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1))] )
//
//        .padding(.top, 30 )
//        .padding(.leading, 30)
//        .overlay(Text("Time")
//        .font(.system(size: 15))
//        .fontWeight(.medium)
//        .rotationEffect(.degrees(270))
//        .offset(x: -60.0, y: 0.0),
//        alignment: .leading)
//        .overlay(Text("Acceleration")
//        .font(.system(size: 15))
//        .fontWeight(.medium)
//        .offset(x: 0, y: 0),
//        alignment: .top)
//    }
    func makeUIView(context: Context) -> LineChartView {
        let chart = LineChartView()
        chart.data = addData()
        return chart
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        uiView.data = addData()
    }
    
    func addData() -> LineChartData{
        let data = LineChartData()
        let dataSet = LineChartDataSet(entries: entries)
        dataSet.colors = [NSUIColor.green]
        dataSet.label = "My Data"
        data.addDataSet(dataSet)
        return data
    }
    
    typealias UIViewType = LineChartView
}



struct LiveTherapyChartView_Previews: PreviewProvider {
    static var previews: some View {
        LiveTherapyChartView(entries: [
            //x - position of a bar, y - height of a bar
            ChartDataEntry(x: 1, y: 1),
            ChartDataEntry(x: 2, y: 2),
            ChartDataEntry(x: 3, y: 3),
            ChartDataEntry(x: 4, y: 4),
            ChartDataEntry(x: 5, y: 5)
        ]).padding(.top, 30 )
            .padding(.leading, 30)
            .overlay(Text("Time")
            .font(.system(size: 15))
            .fontWeight(.medium)
            .rotationEffect(.degrees(270))
            .offset(x: 0.0, y: 0.0),
            alignment: .leading)
            .overlay(Text("Acceleration")
            .font(.system(size: 15))
            .fontWeight(.medium)
            .offset(x: 0, y: 0),
            alignment: .top)
    }
}

