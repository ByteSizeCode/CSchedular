//
//  Tools.swift
//  CSched
//
//  Created by Isaac Raval on 4/21/20.
//  Copyright © 2020 Isaac Raval. All rights reserved.
//

import SwiftUI
import Foundation

struct ModalView: View {
    @Binding var presentedAsModal: Bool
    @Binding var input: String
    @Binding var chosenDate: Date
    @Binding var dayKeyEventnameValuePassByRefrence: [String: String]
    @State public var name: String = ""
    @Binding var eventsStoredForToday:String
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    var body: some View {
        VStack(spacing: 100) {
            Text(getTextFromDate(date: chosenDate))
            TextField("Type Here", text: $name)
            Text(eventsStoredForToday)
            
            Button("Update") {
//                guard case let self.eventsStoredForToday = self.dayKeyEventnameValue[self.getTextFromDate(date: self.chosenDate)] else {
//                    print("didn't work")
//                    return
//                }
                if(self.dayKeyEventnameValuePassByRefrence[self.getTextFromDate(date: self.chosenDate)] != nil) {
                    self.eventsStoredForToday = self.dayKeyEventnameValuePassByRefrence[self.getTextFromDate(date: self.chosenDate)]!
                }
            }
            
            Button("dismiss") {
                self.eventsStoredForToday = "---"
                if(!self.name.isEmpty) {
                    self.dayKeyEventnameValuePassByRefrence[self.getTextFromDate(date: self.chosenDate)] = self.name //Save textfield event name to date
                    print("'\(self.name)'")
                }
                
//                Text(self.dayKeyEventnameValue[self.getTextFromDate(date: self.chosenDate)]!)
//                self.dayKeyEventnameValue[self.getTextFromDate(date: self.chosenDate)]! += self.name //Save by reference event name for lookup by date
                
                self.presentedAsModal = false
                if(!self.name.isEmpty) {
                    self.input = self.name
                }
            }
        }
    }
    
    func getTextFromDate(date: Date!) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return date == nil ? "" : formatter.string(from: date)
    }
}
