//
//  RKViewController.swift
//  RKCalendar
//
//  Based on code created by Raffi Kian on 7/14/19.
//  Additional Code Written by Isaac Raval on 4/21/20.
//  Copyright © 2020 Isaac Raval. All rights reserved.
//

import SwiftUI

struct RKViewController: View {
    
    @Binding var isPresented: Bool
    @State var showingTextField = false
    @State private var text: String = ""
//    let evengtStorage: Dictionary<<#Key: Hashable#>, Any> //["date": "event"]
    var evengtStorage: [String: String] = ["key1": "Value 1"]
    
    @ObservedObject var rkManager: RKManager
    
    var body: some View {
        VStack {
            HStack() {
                TextField("Enter Event Name", text: self.$text)
            }
            .opacity(showingTextField ? 100 : 0)
            .padding(.leading, 9.0)
            .offset(y: showingTextField ? 30 : 0)
            Spacer()
            Button(action: {
                self.showingTextField.toggle()
            }) {
                if(!self.showingTextField) {Text("Add Event")}
                else {
                    Text("Done")
                }
            } .offset(y: showingTextField ? -30 : 0)
            Spacer(minLength: 10)
                Group {
                    RKWeekdayHeader(rkManager: self.rkManager)
                    Divider()
                    List {
                        ForEach(0..<numberOfMonths()) { index in
                            RKMonth(isPresented: self.$isPresented, rkManager: self.rkManager, monthOffset: index)
                        }
                        Divider()
                    }
                }
            VStack {
                Text(self.text)
                //TODO:
                //The RKMonth function DateTapped() has the selected date
                //Use this info to store self.text (the event name) under that date
            }
        }
    }
    
    func numberOfMonths() -> Int {
        return rkManager.calendar.dateComponents([.month], from: rkManager.minimumDate, to: RKMaximumDateMonthLastDay()).month! + 1
    }
    
    func RKMaximumDateMonthLastDay() -> Date {
        var components = rkManager.calendar.dateComponents([.year, .month, .day], from: rkManager.maximumDate)
        components.month! += 1
        components.day = 0
        
        return rkManager.calendar.date(from: components)!
    }
}

#if DEBUG
struct RKViewController_Previews : PreviewProvider {
    static var previews: some View {
        Group {
        RKViewController(isPresented: .constant(false), rkManager: RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0))
            
                
        }
    }
}
#endif

