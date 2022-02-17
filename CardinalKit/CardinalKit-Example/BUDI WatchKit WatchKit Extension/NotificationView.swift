//
//  NotificationView.swift
//  BUDI WatchKit Extension
//
//  Created by Tracy Cai on 1/18/22.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        VStack (alignment: .leading){
            HStack (alignment: .center) {
//            Image("budi-icon-square 1").resizable()
//                    .frame(width: 30, height: 30)
//                .scaledToFit()
                
            Text("It's therapy time!")
                .foregroundColor(.black)
                .font(.headline)
            }
            .padding(.leading)
            
            Divider()
                .background(Color(red: 0.8980392156862745, green: 0.8980392156862745, blue: 0.8980392156862745))
                .padding(.trailing)
                .padding(.leading)
              
            
            Button(action: {
                print("Test")
            }) {
                Text("START THERAPY")
                    .font(.headline)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color(red: 0.103, green: 0.685, blue: 0.33))
                    .cornerRadius(10)
            }
            
//            Button(action: {
//                print("Test")
//            }) {
//                Text("Dismiss")
//                    .font(.body)
//                    .padding()
//                    .frame(minWidth: 0, maxWidth: .infinity)
//                    .foregroundColor(.black
//                    )
//                    .background(Color(red: 0.8980392156862745, green: 0.8980392156862745, blue: 0.8980392156862745))
//                    .cornerRadius(10)
//            }
//
            
        }.background(.white)
//            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
    }
    
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
