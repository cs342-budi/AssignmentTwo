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

struct TherapyProgress: Hashable {
    static func == (lhs: TherapyProgress, rhs: TherapyProgress) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
       
    var id = UUID().uuidString
    var percent: Double
    var minsCompleted: Int
    var date: String
    var monthDate: String
    }

    class ProgressUIChartViewModel: ObservableObject {
    let defaults = UserDefaults.standard
    private var therapyGoal = 0
    @Published var modelData: Array<BarChartDataEntry> = [] // initialize array of barchart entry
    @Published var therapyProgress: Array<TherapyProgress> = [] // initialize array of barchart entry
    @Published var todaysProgress = TherapyProgress(percent: 0, minsCompleted: 0, date: "", monthDate: "");
    @Published var day6Progress = TherapyProgress(percent: 0, minsCompleted: 0, date: "", monthDate: "");
    @Published var day5Progress = TherapyProgress(percent: 0, minsCompleted: 0, date: "", monthDate: "");
    @Published var day4Progress = TherapyProgress(percent: 0, minsCompleted: 0, date: "", monthDate: "");
    @Published var day3Progress = TherapyProgress(percent: 0, minsCompleted: 0, date: "", monthDate: "");
    @Published var day2Progress = TherapyProgress(percent: 0, minsCompleted: 0, date: "", monthDate: "");
    @Published var day1Progress = TherapyProgress(percent: 0, minsCompleted: 0, date: "", monthDate: "");
    @Published var day0Progress = TherapyProgress(percent: 0, minsCompleted: 0, date: "", monthDate: "");

    func reset() -> Void {
        self.modelData = []
        self.therapyProgress = []
    }

    func getData() -> Void {
        
        // clear out existing data
        self.reset()
        
        // now get new data
        
        //ref to collection
        guard let authCollection =  CKStudyUser.shared.authCollection else { return } // stop executing if not logged in
        let db = Firestore.firestore()
        let collectionRef = db.collection(authCollection + "therapy-sessions")
        therapyGoal = defaults.integer(forKey: "therapyGoal")
        
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
                print("this is data arr")
                print(dataarr)
                getLast7Dates()
            } // have all our data
            
            // 1) create loop that goes days 1 - 7
            // 2) goes back, each day -> convert the same format, does it exist in data array.
            // 3) put value in
            // bar array =
            func getLast7Dates()
            {
                print(dataarr)
                let cal = Calendar.current
                let date = cal.startOfDay(for: Date())
                var days = [BarChartDataEntry]()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd-yyyy"
                
                for i in 0 ... 6 {
                    let newdate = cal.date(byAdding: .day, value: -i, to: date)!
                    let str = dateFormatter.string(from: newdate)
                    print(str)
                    let datacur = dataarr[str] ?? 0  // bar value 0
                    print(datacur)
                    let bar = BarChartDataEntry(x: Double(7-i), y: Double(datacur/60))
                    self.modelData.append(bar) //append each bar
                    
                    dateFormatter.dateFormat = "E"
                    let dayForRing = dateFormatter.string(from: newdate)
                    dateFormatter.dateFormat = "M/d"
                    let monthDay = dateFormatter.string(from: newdate)
                    self.therapyProgress.append(TherapyProgress(percent: (Double(datacur/60)/(Double(self.therapyGoal))), minsCompleted: Int(datacur/60), date: dayForRing, monthDate: monthDay))
                    dateFormatter.dateFormat = "MM-dd-yyyy"
                }
                
                
                //self.todaysProgress = self.therapyProgress[0];
                self.todaysProgress = self.therapyProgress[0];
                if self.todaysProgress.percent <= 0.01 {
                    self.todaysProgress.percent = 0.01
                }
                
                for i in 0...6 {
                    if self.therapyProgress[i].percent <= 0.07 {
                        self.therapyProgress[i].percent = 0.07
                    } else if self.therapyProgress[i].percent > 1 {
                        self.therapyProgress[i].percent = 1
                    }
                }
                
                self.day0Progress = self.therapyProgress[0];
                self.day1Progress = self.therapyProgress[1];
                self.day2Progress = self.therapyProgress[2];
                self.day3Progress = self.therapyProgress[3];
                self.day4Progress = self.therapyProgress[4];
                self.day5Progress = self.therapyProgress[5];
                self.day6Progress = self.therapyProgress[6];
                //self.therapyProgress.reverse()
                
                //
                //                for val in self.modelData {
                //                    print("\(val)")
                //                }
                
                print("goal \(self.therapyGoal)")
                for val in self.therapyProgress {
                    print("percentages: \(val)")
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

    init() {
       therapyGoal = defaults.integer(forKey: "therapyGoal")
       getData()
    }
    }

    final class ChartFormatter: NSObject, AxisValueFormatter {

    func stringForValue( _ value: Double, axis _: AxisBase?) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
    //        formatter.dateFormat = "MM/dd"
        formatter.dateFormat = "E"
        
        let cal = Calendar.current
        let date = cal.startOfDay(for: Date())
        let newdate = cal.date(byAdding: .day, value: -(7-Int(value)), to: date)!
        let str = formatter.string(from: newdate)
        
        return str
    }

    }

    struct ProgressUIChartView: UIViewRepresentable {
    @ObservedObject var viewModel = ProgressUIChartViewModel()

    //var entries: [BarChartDataEntry]
    func makeUIView(context: Context) -> BarChartView {
        let chart = BarChartView()
        chart.data = addData()

        let yAxis = chart.leftAxis
        yAxis.axisMinimum = 0

        chart.xAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawGridLinesEnabled = false
        //        chart.leftAxis.drawAxisLineEnabled = false
        chart.rightAxis.drawAxisLineEnabled = false
        chart.rightAxis.drawGridLinesEnabled = false
        chart.rightAxis.enabled = false
        chart.xAxis.labelPosition = XAxis.LabelPosition.bottom
        chart.legend.enabled = false
        chart.leftAxis.drawLabelsEnabled = false
        chart.xAxis.valueFormatter = DefaultAxisValueFormatter()

        return chart
    }
    //func makeUIView(context: Context) {
        
    // }
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
        
        //changed to match progress color
        dataSet.colors = [NSUIColor(red: 151.0/255.0, green: 156.0/255.0, blue: 233.0/255.0, alpha: 1.0)]
        dataSet.label = "My Data"
        data.dataSets.append(dataSet)
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
