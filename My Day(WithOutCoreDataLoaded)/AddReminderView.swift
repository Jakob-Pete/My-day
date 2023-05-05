//
//  AddReminder.swift
//  My Day(WithOutCoreDataLoaded)
//
//  Created by mac on 3/27/23.
//

import SwiftUI
import UserNotifications
import CoreData
class AddReminderViewModal: ObservableObject {
    @Published var reminderTitle = ""
    @Published var additionalText = ""
    //    @Published var color = Color.red
    //    Clean up the default types
    @Published var typeOfReminder = ""
    @Published var startTime = Date()
    //    @Published var startTimeTest = Date()
    @Published var endTime = Calendar.current.date(byAdding: .hour, value: 1, to: Date())!
    let reminderType = ["Event", "Goal"]
    var reminderToEdit: Reminder?
    
    init(reminderToEdit: Reminder? = nil) {
        self.reminderToEdit = reminderToEdit
        
        reminderTitle = reminderToEdit?.reminderTitle ?? ""
        additionalText = reminderToEdit?.additionalText ?? ""
        typeOfReminder = reminderToEdit?.typeOfReminder ?? ""
        startTime = reminderToEdit?.startTime ?? Date()
        endTime = reminderToEdit?.endTime ?? Calendar.current.date(byAdding: .hour, value: 1, to: Date())!
        
    }
    
    func scheduleNotification(at time: Date, title: String, body: String) {
        //        cancel old notifcation and make it be replaced by the new one set
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
//        let identifer = "regular"
        let components = Calendar.current.dateComponents([.hour, .minute], from: time)
        print(components)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        print(content.title)
        
        guard let reminder = reminderToEdit else { return }
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [reminder.id.hashValue.formatted()])
        
        let request = UNNotificationRequest(identifier: reminder.id.hashValue.formatted(), content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Notification scheduled!")
            }
        }
        
    }
    
    func saveButtonTapped(moc: NSManagedObjectContext) {
        scheduleNotification(at: startTime, title: reminderTitle, body: "Check out your next \(typeOfReminder)!")
        //                Code to save it to the my day view
        let reminder = reminderToEdit ?? Reminder(context: moc)
        reminder.reminderTitle = reminderTitle
        reminder.startTime = startTime
        reminder.endTime = endTime
        reminder.additionalText = additionalText
        reminder.typeOfReminder = typeOfReminder
        
        try? moc.save()
    }
}

struct AddReminder: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: AddReminderViewModal
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Reminder", text: $viewModel.reminderTitle)
                
                HStack {
                    Text("Select a start time")
                    Spacer()
                    
                    DatePicker("Please enter a time", selection: $viewModel.startTime,
                               displayedComponents: [.hourAndMinute])
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    //                    .minuteInterval(5)
                }
                
                DatePicker("End Time", selection: $viewModel.endTime,
                           displayedComponents: [.hourAndMinute])
                .datePickerStyle(.compact)
                
                
                Picker("Event", selection: $viewModel.typeOfReminder) {
                    ForEach(viewModel.reminderType, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                
                //                ColorPicker("Choose a color for your reminder", selection: $color)
                
                TextField("Extras", text: $viewModel.additionalText, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(5, reservesSpace: true)
                
                Button("Save") {
                    viewModel.saveButtonTapped(moc: moc)
                    dismiss()
                }
                .frame(width: 350.0, height: 40.0)
                .fixedSize()
                .foregroundColor(Color.white)
                .background(Color.blue)
                .clipShape(Capsule())
            }
        }
    }
}


struct AddReminder_Previews: PreviewProvider {
    
    static var previews: some View {
        AddReminder(viewModel: .init())
    }
}
