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
    
    var body: some View {

        
        Button(action: {
            self.showingAddMenu.toggle()
        }) {
            HStack(alignment: .lastTextBaseline) {
                Image("plus")
            }
            .padding(Metrics.PADDING_VERTICAL_MAIN*3.2)
            .background(Color.gray)
            .cornerRadius(10)
 
            
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
