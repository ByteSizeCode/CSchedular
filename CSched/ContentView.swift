//
//  ContentView.swift
//  CSched
//
//  Created by Isaac Raval on 4/21/20.
//  Copyright © 2020 Isaac Raval. All rights reserved.
//

import SwiftUI

struct ContentView: View {
//     @State var showingDetail = false
    
    @State var singleIsPresented = false
    var rkManager = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0)
    
    var body: some View {
        Button(action: {
            self.singleIsPresented.toggle()
        }) {
            Text("Show Detail")
        }.sheet(isPresented: self.$singleIsPresented, content: {
            RKViewController(isPresented: self.$singleIsPresented, rkManager: self.rkManager)})
        //Text(self.getTextFromDate(date: self.rkManager1.selectedDate))
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
