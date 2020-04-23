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
    @State var listOfEvents:[String] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    var body: some View {
        VStack(spacing: 70) {
            Text(getTextFromDate(date: chosenDate))
//            TextField("Type Here", text: $name)
            MultilineTextField("Type Here", text: $name)
            Text(eventsStoredForToday)
            
            List(listOfEvents) { item in
              Text(item)
            }
            .frame(height: 200)
            
            
            Button("Update") {
                self.SaveEventToDate(clearField: false)
                self.UpdateTextWithEventName()
                
                self.listOfEvents = self.eventsStoredForToday.components(separatedBy: "|") //Make an array
                print(self.listOfEvents)
                print(self.eventsStoredForToday)
//                self.ListWhatWeHave()
            }
            
            Button("dismiss") {
                self.SaveEventToDate(clearField: true)
                
//                Text(self.dayKeyEventnameValue[self.getTextFromDate(date: self.chosenDate)]!)
//                self.dayKeyEventnameValue[self.getTextFromDate(date: self.chosenDate)]! += self.name //Save by reference event name for lookup by date
                
                self.presentedAsModal = false
                if(!self.name.isEmpty) {
                    self.input = self.name
                }
            }
        }
    }
    
    func UpdateTextWithEventName() {
        if(self.dayKeyEventnameValuePassByRefrence[self.getTextFromDate(date: self.chosenDate)] != nil) {
    //                    //Show in Text()
            self.eventsStoredForToday = self.dayKeyEventnameValuePassByRefrence[self.getTextFromDate(date: self.chosenDate)]!
    //                      self.name = self.dayKeyEventnameValuePassByRefrence[self.getTextFromDate(date: self.chosenDate)]!
        }
    }
    
    func SaveEventToDate(clearField: Bool) {
        if(!self.name.isEmpty) {
            
            if(self.dayKeyEventnameValuePassByRefrence[self.getTextFromDate(date: self.chosenDate)] == nil) {
                self.dayKeyEventnameValuePassByRefrence[self.getTextFromDate(date: self.chosenDate)] = self.name //Save textfield event name to date
            }
            else { //Add with a delimeter
                self.dayKeyEventnameValuePassByRefrence[self.getTextFromDate(date: self.chosenDate)]! += "|\(self.name)" //Save textfield event name to date
            }
            
             
            print("'\(self.name)'")
        }
        if(clearField) {
            self.eventsStoredForToday = "---"
        }
    }
    
    func getTextFromDate(date: Date!) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return date == nil ? "" : formatter.string(from: date)
    }
}
