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
    var rkManager = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(10*(60*60*24*365)), mode: 0)
    
    var body: some View {
        
        RKViewController(isPresented: self.$singleIsPresented, rkManager: self.rkManager)

    }
    
    func getTextFromDate(date: Date!) -> String {
           let formatter = DateFormatter()
           formatter.locale = .current
           formatter.dateFormat = "EEEE, MMMM d, yyyy"
           return date == nil ? "" : formatter.string(from: date)
       }
   
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
