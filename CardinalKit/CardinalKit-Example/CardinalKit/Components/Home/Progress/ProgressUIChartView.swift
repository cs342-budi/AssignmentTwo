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
import FirebaseFirestore

class ProgressUIChartViewModel: ObservableObject {
    @Published var modelData: Array<BarChartDataEntry> = [] // initialize array of barchart entry
    @Published var last7Dates: Array<String> = [] // initialize array of barchart entry
    
    init() {
       //ref to collection
        guard let authCollection =  CKStudyUser.shared.authCollection else { return } // stop executing if not logged in
        let db = Firestore.firestore()
        let collectionRef = db.collection(authCollection + "therapy-sessions")
        
        // last 7 days doc using the timestamp comparison,
        // query our therapy sessions in collection - order them by date - limit them by 7; decending order
        
        // set up array to fill; array of dictionary - day - strings, and doubles
        // array = set of dates & values
        var dataarr : [String : Double] = [:]  //date: key, value:
        collectionRef.order(by: "payload.date", descending: true).limit(to: 7).getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            print("\(document.documentID) => \(document.data())")
                            let payload = document.data()["payload"] as? [String : Any]  // cast payload to dic
                            let runningtotal = payload?["totaltime"] as? Double ?? 0
                            // add in dictionary with key = document date
                            dataarr[document.documentID] = runningtotal
                        }
                        getLast7Dates()
                        
                    } // have all our data
            
            // 1) create loop that goes days 1 - 7
            // 2) goes back, each day -> convert the same format, does it exist in data array.
            // 3) put value in
            // bar array =
            func getLast7Dates()
            {
                let cal = Calendar.current
                let date = cal.startOfDay(for: Date())
                var days = [BarChartDataEntry]()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd"

                for i in 1 ... 7 {
                    let newdate = cal.date(byAdding: .day, value: -i, to: date)!
                    let str = dateFormatter.string(from: newdate)
                    let datacur = dataarr[str] ?? 0  // bar value 0
                    let bar = BarChartDataEntry(x: Double(8-i), y: datacur)
                    self.modelData.append(bar) //append each bar
                    self.last7Dates.append(str)
                }
                self.last7Dates.reverse()
                
                for val in self.last7Dates {
                    print("dates: \(val)")
                }
            }
            
            // if there's any gaps - how many days are in between
            // create last 7 days array, find days that exist
            
            // string format
            
            
            

        
        
        
        
        
//        //only want to grab documents from last 7 days
//        let currDate = Date()
//        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: currDate)!.timeIntervalSince1970
        
        
        
        // possible way to convert date to epochs: currDate.timeIntervalSince1970
        
        
//        docRef.whereField("Date", isGreaterThan: startDate).whereField("Date", isLessThan: currDate).getDocuments { (snapshot, error) in
//
//            for document in snapshot!.documents {
//                //document.get("date")
//                print(document.documentID)
//            }
            
            // goes to exact second? Check range - 
//            if (document != nil) && document.get("date") == currDate {
//                 do something
//                 modelData[document.get("date")] = document.get("total_duration")
                
                 //1 . compile multiple values from 1 day into 1 summed value
                 //2. write the value to our modelData Dictionary
            }
        }
}

//class ChartFormatter: NSObject, IAxisValueFormatter {
//    @ObservedObject var viewModel = ProgressUIChartViewModel()
//
//    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        return Calendar.current.shortWeekdaySymbols[Int(value)]
//    }
//}

struct ProgressUIChartView: UIViewRepresentable {
    @ObservedObject var viewModel = ProgressUIChartViewModel()
    
    //var entries: [BarChartDataEntry]
    func makeUIView(context: Context) -> BarChartView {
        let chart = BarChartView()
        chart.data = addData()
        
        //chart.xAxis.valueFormatter = ChartFormatter()
        return chart
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) {
        uiView.data = addData()
    }
    
    func addData() -> BarChartData{
        let data = BarChartData()
        let dataSet = BarChartDataSet(entries: viewModel.modelData)  //set out actual data
        
        // createe dataset using fetched data
//        for (date, total_duration) in viewModel.modelData {
//            dataSet.append(BarChartDataEntry(x: Double(date), y: Double(total_duration)))
//            //string - actual date - convert?
//        }
        
        dataSet.colors = [NSUIColor.green]
        dataSet.label = "My Data"
        data.addDataSet(dataSet)
        return data
    }
    
    typealias UIViewType = BarChartView
}
// 7 days with current date.
// load data.
//struct ProgressUIChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressUIChartView(entries: [
//            //x - position of a bar, y - height of a bar
//            BarChartDataEntry(x: 1, y: 1),
//            BarChartDataEntry(x: 2, y: 2),
//            BarChartDataEntry(x: 3, y: 3),
//            BarChartDataEntry(x: 4, y: 4),
//            BarChartDataEntry(x: 5, y: 5)
//        ])
//    }
//}

