//
//  AddNewTodo.swift
//  MimicReminder
//
//  Created by benlin on 2021/5/11.
//

import SwiftUI

struct AddNewTodo: View {
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
                }
                
                Section {
                    TextField("Note", text: $note)
                    
                }
                
                Section(header: Text("Due Date")) {
                    DatePicker(selection: $duedate) {
                        Text("Select a date")
                    }
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .frame(maxHeight: 400)
                }
                
            }
            
            .navigationBarTitle("Add New Todo")
            .navigationBarItems(leading: Button(action: CancelTodo) {
                Text("Cancel")
            }, trailing: Button(action: SaveTodo) {
                Text("Save")
            })
        }
    }
    
    func SaveTodo() {
        
    }
    
    func CancelTodo() {
        
    }
}

struct AddNewTodo_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTodo()
    }
}
