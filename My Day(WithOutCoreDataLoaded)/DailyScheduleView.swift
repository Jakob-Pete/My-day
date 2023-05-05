//
//  ScheduledOverall.swift
//  My Day(WithOutCoreDataLoaded)
//
//  Created by mac on 3/27/23.
//

import SwiftUI


struct DailySchedule: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.startTime)
    ]) var reminders: FetchedResults<Reminder>
//Add a completeed aspect, and add it to a counter
    @State private var showingAddScreen = false

//    IDEAS: Change it so you can hold down on one goal/reminder and mark it completed and then switch editing to using the bar button and then it can move over to the edit screen and you can edit it so basically change that up lol.
//    IDEA 2: Delete the reminder after it's been a day so do 12am to 11 pm probably.
    var body: some View {
        NavigationView {
            List {
                ForEach(reminders) { reminder in
                    NavigationLink {
                        AddReminder(viewModel: .init(reminderToEdit: reminder))
                    } label: {
                        HStack {
                            Rectangle()
                                .frame(width: 20, height: 40)
                                .foregroundColor(.purple)
                            
                            VStack(alignment: .leading) {
                                Text(reminder.reminderTitle ?? "Error")
                                    .font(.headline)
                                
                                Text(reminder.additionalText ?? "Error")
                                    .foregroundColor(.secondary)
                                
                            }
                            Spacer()
                            VStack {
                                Text(reminder.startTime ?? Date(), format: .dateTime.hour().minute())
                                Text(reminder.endTime ?? Date(), format: .dateTime.hour().minute())
                            }
                            
                        }
                    }
                }
                .onDelete(perform: deleteReminders)
            }
            
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddScreen.toggle()
                        } label: {
                            Label("Add Reminder", systemImage: "plus")
                        }
                    }
                    
                }
                .sheet(isPresented: $showingAddScreen) {
                    AddReminder(viewModel: .init())
                }
        }
    }
    func deleteReminders(at offsets: IndexSet) {
        for offset in offsets {
//            This method loops through to delete the reminder you made before
            let reminder = reminders[offset]
            moc.delete(reminder)
        }
        try? moc.save()
    }
}

struct ScheduledOverall_Previews: PreviewProvider {
    static var previews: some View {
        DailySchedule()
    }
}
