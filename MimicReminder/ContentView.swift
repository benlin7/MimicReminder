//
//  ContentView.swift
//  MimicReminder
//
//  Created by benlin on 2021/5/11.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc

    @FetchRequest(entity: Todoitem.entity(), sortDescriptors: []) var todoitems: FetchedResults<Todoitem>
    
    @State private var showingNewItemSheet = false

    var body: some View {
        NavigationView {
            List {
                
            }
            .navigationTitle("Reminder")
            .navigationBarItems(trailing: Button(action: { self.showingNewItemSheet.toggle()
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingNewItemSheet) {
                Text("Need to add things")
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
