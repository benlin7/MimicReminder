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

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(todoitems, id: \.self) { item in
                        Text(item.title ?? "Undefined Reminder")
                    }
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


}


struct ContentView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, moc)
    }
}
