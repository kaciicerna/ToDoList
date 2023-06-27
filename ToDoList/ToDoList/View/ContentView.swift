//
//  ContentView.swift
//  ToDoList
//
//  Created by Kateřina Černá on 27.06.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TodoViewModel()
    @State private var isShowingAddSheet = false
    @State private var filterState: Bool? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.todoItems.filter {
                        filterState == nil ? true : $0.state == filterState
                    }) { item in
                        NavigationLink(destination: DetailView(item: item)) {
                            Text(item.title!)
                        }
                    }
                    .onDelete(perform: viewModel.deleteTodoItem)
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        isShowingAddSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding()
                }
            }
            .navigationTitle("Todo List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {
                            filterState = true
                        }) {
                            Label("Done", systemImage: "checkmark.circle.fill")
                        }
                        
                        Button(action: {
                            filterState = false
                        }) {
                            Label("Open", systemImage: "circle")
                        }
                        
                        Button(action: {
                            filterState = nil
                        }) {
                            Label("All", systemImage: "list.bullet")
                        }
                    } label: {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingAddSheet) {
            AddTodoView(viewModel: viewModel, isPresented: $isShowingAddSheet)
        }

    }
}

struct AddTodoView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: TodoViewModel
    @Binding var isPresented: Bool
    
    @State private var title = ""
    @State private var description = ""
    @State private var dueDate = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    DatePicker("Due Date", selection: $dueDate)
                }
                
                Section {
                    Button("Add Todo") {
                        viewModel.addTodoItem(title: title, description: description, dueDate: dueDate)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("Add Todo")
        }
    }
}


struct DetailView: View {
    @ObservedObject var item: TodoItem
    
    var body: some View {
        VStack {
            Text(item.title ?? "Unknown")
                .font(.title)
                .padding()
            
            Text(item.itemDescription ?? "None")
                .padding()
            
            // Add additional details like attachments, location, etc.
        }
        .navigationTitle("Detail")
    }
}


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
