//
//  AddNewTodoView.swift
//  MimicReminder
//
//  Created by benlin on 2021/5/11.
//

import SwiftUI

struct AddNewTodoView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var note = ""
    @State private var priority = 0
    @State private var duedate = Date()
    
    let priorities = ["None", "Low", "Medium", "High"]

    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Todo Title", text: $title)
                
                    Picker("Priority", selection: $priority) {
                        ForEach(0..<4, id: \.self) {
                            Text(priorities[$0])
                        }
                    }
//                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    TextField("Note", text: $note)
                    
                }
                
                Section(header: Text("Due Date")) {
                    DatePicker("Select a date", selection: $duedate, in: Date()..., displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .frame(maxHeight: 400)
                }
                
            }
            
            .navigationBarTitle("Add New Todo", displayMode: .inline)
            .navigationBarItems(leading: Button(action: CancelTodo) {
                Text("Cancel")
            }, trailing: Button(action: SaveTodo) {
                Text("Save")
            })
        }
    }
    
    func SaveTodo() {
        let newTodo = Todoitem(context: self.moc)
        newTodo.title = self.title
        newTodo.priority = Int16(self.priority)
        newTodo.note = self.note
        newTodo.duedate = self.duedate
        
        try? self.moc.save()
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func CancelTodo() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddNewTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTodoView()
    }
}
