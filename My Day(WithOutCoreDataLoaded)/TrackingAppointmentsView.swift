//
//  ContentView.swift
//  My Day(WithOutCoreDataLoaded)
//
//  Created by mac on 3/27/23.
//

import SwiftUI

struct TrackingAppointmentsView: View {
    
    var motivate = ["Just do it!", "Failure is success in progress. ~Albert Einstein", "The only certainty in life is that everything is uncertain.", "Believe you can and you're halfway there. - Theodore Roosevelt", "Don't let yesterday take up too much of today. - Will Rogers", "It does not matter how slowly you go as long as you do not stop. - Confucius"]
    
    var goalHelp = ["Make your goals visible", "Write them down", "Break it down", "Develop a plan", "Take action", "Keep perspective", "Identify potential obstacles", "Be accountable","Reflect and adjust"]
    @State private var help: String = ""
    @State private var motivateArr: String = ""
//    @State private var TrackingProgress = 0.0
    @State private var showAlertHelp = false
    @State private var showAlertMot = false
    var body: some View {
        NavigationView {
            VStack {
                //            ProgressView(value: TrackingProgress)
                //            Track completed
                Text("Welcome nerds!")
                Text("This is My Day. An app to help track your day and all your wonderful goals/events")
                    .multilineTextAlignment(.center)
                //            Text("This is My Day. An app to help track your day and all your wonderful goals/events")
            }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            let index = Int.random(in: 0..<motivate.count)
                            motivateArr = motivate[index]
                            showAlertMot = true
                        }) {
                            Image(systemName: "scribble")
                        }
                        .alert(isPresented: $showAlertMot) {
                            Alert(title: Text("Here's some motivation!"), message: Text(motivateArr), dismissButton: .default(Text("I got this!")))
                        }
                        
                    }
                }
            
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            let index = Int.random(in: 0..<goalHelp.count)
                            help = goalHelp[index]
                            showAlertHelp = true
                        }) {
                            Image(systemName: "questionmark")
                        }
                        .alert(isPresented: $showAlertHelp) {
                            Alert(title: Text("Here's some help to acomplish your goals!"), message: Text(help), dismissButton: .default(Text("Thanks!")))
                        }
                    }
                }
            
            
        }
        .padding()
    }
    
}
//    func motavate() {
//        motivateArr.randomElement()
//
//    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingAppointmentsView()
    }
}
