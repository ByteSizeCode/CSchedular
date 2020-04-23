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
    let ENABLE_SAVE_EVENT_DATE = false //Keep false until data-saving issues are resolved
    let ENABLE_CLEAR_BUTTON = true
    @State var showingAlert = false
    @Binding var presentedAsModal: Bool
    @Binding var input: String
    @Binding var chosenDate: Date
    @Binding var dayKeyEventnameValuePassByRefrence: [String: String]
    @State public var name: String = ""
    @Binding var eventsStoredForToday:String
    @State var listOfEvents:[String] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    var body: some View {
        VStack(spacing: ENABLE_CLEAR_BUTTON ? 50 : 70) {
            if(ENABLE_CLEAR_BUTTON) {
//                Button("Clear All") {
//                    self.DeleteAllCalendarEvents()
//                }.padding(.leading, 600.0)
                
                Button(action: {self.showingAlert = true}) {Text("Clear All")}
                        .padding(.leading, 600.0)
                       .alert(isPresented:$showingAlert) {Alert(title: Text("Delete All Events From Today?"), message: Text("There is no undo"), primaryButton: .destructive(Text("Delete")) {print(self.DeleteAllCalendarEvents())}, secondaryButton: .cancel())}
            }
            Text(getTextFromDate(date: chosenDate))
//            TextField("Type Here", text: $name)
            MultilineTextField("Type Here", text: $name)
            Text(eventsStoredForToday)
            
            List(listOfEvents) { item in
              Text(item)
            }
            .frame(height: 200)
            
            
            Button("Add Event") {
                self.Reload_UpdateData()
            }
            
            Button("Back") {
                self.SaveEventToDate(clearField: true)
                
//                Text(self.dayKeyEventnameValue[self.getTextFromDate(date: self.chosenDate)]!)
//                self.dayKeyEventnameValue[self.getTextFromDate(date: self.chosenDate)]! += self.name //Save by reference event name for lookup by date
                
                self.presentedAsModal = false
                if(!self.name.isEmpty) {
                    self.input = self.name
                }
            }
        }
        .onAppear() {
            self.Reload_UpdateData()
            print("Updating Data")
        }
    }
    
    func Reload_UpdateData() {
        if(self.ENABLE_SAVE_EVENT_DATE) {
            if(UserDefaults.standard.string(forKey: "events") != nil) {
                self.eventsStoredForToday = UserDefaults.standard.string(forKey: "events")!
            }
        }
        
        self.SaveEventToDate(clearField: false)
        self.UpdateTextWithEventName()
        
        self.listOfEvents = self.eventsStoredForToday.components(separatedBy: "|") //Make an array
        print(self.listOfEvents)
        print(self.eventsStoredForToday)
        
        self.name = "" //Clear TextField after submission
        
        if(self.ENABLE_SAVE_EVENT_DATE) {
            //Save dict in string format to string to userDefaults
            var data = UserDefaults.standard.set(self.eventsStoredForToday, forKey: "events")
        }
                        
        //                self.ListWhatWeHave()
    }
    
    func DeleteAllCalendarEvents() {
        UserDefaults.standard.removeObject(forKey: "events")
        self.dayKeyEventnameValuePassByRefrence[self.getTextFromDate(date: self.chosenDate)] = ""
        UpdateTextWithEventName()
        self.Reload_UpdateData()
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
