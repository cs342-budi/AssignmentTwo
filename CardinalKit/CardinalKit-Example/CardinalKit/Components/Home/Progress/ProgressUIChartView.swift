//
//  ProgressUIView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import CareKitStore
import CareKit
import Charts
import Firebase
import FirebaseAuth

class ProgressUIChartViewModel: ObservableObject {
    @Published var modelData: Dictionary<Int, Int> = [:]// keys: date, value: total_duration // initialize
    
    init() {
        // find current user
        let currUser = Auth.auth().currentUser
        
        let db = Firestore.firestore()
        let docRef = db.collection("studies").document("edu.stanford.budi.blynn").collection("users").document(currUser!.uid).collection("Dummy-therapy-session")
        
        //only want to grab documents from last 7 days
        let currDate = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: currDate)!.timeIntervalSince1970
        
        
        
        // possible way to convert date to epochs: currDate.timeIntervalSince1970
        
        
        docRef.whereField("Date", isGreaterThan: startDate).whereField("Date", isLessThan: currDate).getDocuments { (snapshot, error) in
            
            for document in snapshot!.documents {
                //document.get("date")
                print(document.documentID)
            }
            
            // goes to exact second? Check range - 
//            if (document != nil) && document.get("date") == currDate {
//                 do something
//                 modelData[document.get("date")] = document.get("total_duration")
                
                 //1 . compile multiple values from 1 day into 1 summed value
                 //2. write the value to our modelData Dictionary
            }
        }
    }


struct ProgressUIChartView: UIViewRepresentable {
    @ObservedObject var viewModel = ProgressUIChartViewModel()
    
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
        
        // createe dataset using fetched data
        for (date, total_duration) in viewModel.modelData {
            dataSet.append(BarChartDataEntry(x: Double(date), y: Double(total_duration)))
            //string - actual date - convert?
        }
        
        dataSet.colors = [NSUIColor.green]
        dataSet.label = "My Data"
        data.addDataSet(dataSet)
        return data
    }
    
    typealias UIViewType = BarChartView
}
// 7 days with current date.
// load data.
struct ProgressUIChartView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressUIChartView(entries: [
            //x - position of a bar, y - height of a bar
            BarChartDataEntry(x: 1, y: 1),
            BarChartDataEntry(x: 2, y: 2),
            BarChartDataEntry(x: 3, y: 3),
            BarChartDataEntry(x: 4, y: 4),
            BarChartDataEntry(x: 5, y: 5)
        ])
    }
}
