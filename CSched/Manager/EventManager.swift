//
//  EventManager.swift
//  CSched
//
//  Created by Isaac Raval on 4/21/20.
//  Copyright © 2020 Isaac Raval. All rights reserved.
//

import SwiftUI

struct EventManager: View {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @State private var eventNameStr:String = ""
    
    var body: some View {
        VStack {
            Button(action: {}) {
                Text("Add Event")
                .bold()
            }
            Spacer()
            TextField("Event Name", text: $eventNameStr)
        }
    }
}

struct EventManager_Previews: PreviewProvider {
    static var previews: some View {
        EventManager()
    }
}
