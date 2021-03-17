//
//  PopUpWindow.swift
//  Weather-app-swiftUI
//
//  Created by Théo on 16/03/2021.
//

import SwiftUI

struct PopUpWindow: View {
    
    @Binding var showAlert: Bool
    
    var body: some View {
        
        if $showAlert.wrappedValue {
            
            VStack {
                Color.white
                VStack {
                    Text("Custom Pop Up")
                    Spacer()
                    Button(action: {
                        self.showAlert = false
                    }, label: {
                        Text("Close")
                    })
                }.padding()
            }
            .frame(width: 300, height: 200)
            .cornerRadius(20).shadow(radius: 20)
        }
    }
}

struct PopUpWindow_Previews: PreviewProvider {
    @State static var whatever = true
    
    static var previews: some View {
        PopUpWindow(showAlert: $whatever)
    }
    
}
