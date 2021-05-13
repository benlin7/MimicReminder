//
//  ContentView.swift
//  MimicReminder
//
//  Created by benlin on 2021/5/11.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // Customize NavigationBarTitile Color
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemRed]

        //Use this if NavigationBarTitle is with displayMode = .inline
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.systemRed]
    }
    
    @Environment(\.managedObjectContext) var moc

    @FetchRequest(entity: Todoitem.entity(), sortDescriptors: []) var todoitems: FetchedResults<Todoitem>
    
    @State private var showingNewItemSheet = false
    @State private var bindingItemTitle = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(todoitems, id: \.self) { item in
                        HStack {
                            if item.priority > 0 {
                                Image(systemName: priorityMark(priority: item.priority))
                                    .foregroundColor(.orange)
                            }
                            
                            Text(item.title ?? "Undefined Reminder")
                            
//                            bindingItemTitle = item.title ?? "todo title"
//
//                            TextField("Todo Title", text: $bindingItemTitle)
                            
                            
                            Spacer()
                            
                            
                            Image(systemName: "info.circle")
                                .foregroundColor(.orange)
                                .onTapGesture {
                                    self.showingNewItemSheet.toggle()
                                }
                        }
                    }
                    .onDelete(perform: DeleteItem)
                }
                
                Button(action: { self.showingNewItemSheet.toggle()}) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        
                        Text("New Reminder")
                        
                        Spacer()
                    }
                    .padding()
                    .accentColor(Color(UIColor.systemRed))
                    .frame(alignment: .leading)
                }
            }
            .navigationTitle("Reminders")
//            .navigationBarItems(trailing: Button(action: { self.showingNewItemSheet.toggle()
//            }) {
//                Image(systemName: "plus")
//            })
            .sheet(isPresented: $showingNewItemSheet) {
                AddNewTodoView()
            }
        }
        
    }
    
    func DeleteItem(at offsets: IndexSet) {
        for offset in offsets {
            let item = todoitems[offset]
            
            moc.delete(item)
        }
        
        try? moc.save()
    }
    
    func priorityMark(priority: Int16) -> String {
        switch priority {
        case 1:
            return "exclamationmark"
        case 2:
            return "exclamationmark.2"
        case 3:
            return "exclamationmark.3"
        default:
            return ""
        }
    }

}


struct ContentView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        
//        let item = Todoitem(context: moc)
//        item.title = "sample todo"
//        item.priority = 2
//        item.duedate = Date()
//        item.note = "some note"
        
        return ContentView().environment(\.managedObjectContext, moc)
    }
}
