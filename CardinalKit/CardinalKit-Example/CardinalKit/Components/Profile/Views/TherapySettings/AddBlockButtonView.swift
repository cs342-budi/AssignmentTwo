//
//  AddBlockButtonView.swift
//  CardinalKit_Example
//
//  Created by Taylor  Lallas on 2/9/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

struct AddBlockButtonView: View {
    @State private var showingAddMenu = false
    
    let color: Color
    let config = CKPropertyReader(file: "CKConfiguration")
    
    var onComplete: (() -> Void)? = nil
    
    init(onComplete: (() -> Void)? = nil) {
        self.color = Color(config.readColor(query: "Primary Color"))
    }

    
    var body: some View {

        
        Button(action: {
            self.showingAddMenu.toggle()
        }) {
            HStack(alignment: .center) {
                Text("Add Session")
                    .fontWeight(.heavy)
                    .font(.title2)
                    .foregroundColor(Color.white)
                Image("plus")
            }
            .frame(maxWidth: .infinity)
            .padding(Metrics.PADDING_VERTICAL_MAIN*3.2)
            .background(self.color)
            .cornerRadius(10)
            .padding(.leading)
            .padding(.trailing)
 
            
        }.sheet(isPresented: $showingAddMenu) {
            AddMenuView()
    }
    
    }
}

struct AddBlockButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddBlockButtonView()
    }
}
