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
                            TodoListItemView(item: item)
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
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
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
            AddTodoItemView(viewModel: viewModel, isPresented: $isShowingAddSheet)
                .environmentObject(viewModel)
        }
        .environmentObject(viewModel)
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
