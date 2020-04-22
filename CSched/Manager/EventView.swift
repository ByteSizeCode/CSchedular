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
    @State public var name: String = ""
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    var body: some View {
        VStack(spacing: 100) {
            Text(getTextFromDate(date: chosenDate))
            TextField("Type Here", text: $name)
            Button("dismiss") {
                self.presentedAsModal = false
                self.input = self.name
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
