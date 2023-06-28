//
//  ContentView.swift
//  ToDoList
//
//  Created by Kateřina Černá on 27.06.2023.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @StateObject private var viewModel = TodoViewModel()
    @State private var isShowingAddSheet = false
    @State private var filterState: Bool? = nil
    @State private var isEditing = false
    @State private var isFaceIDAuthenticated = false
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.todoItems
                            .filter { filterState == nil ? true : $0.state == filterState }
                            .sorted(by: { $0.dueDate ?? Date() < $1.dueDate ?? Date() })
                        ) { item in
                            NavigationLink(destination: DetailView(item: item)) {
                                TodoListItemView(item: item, deleteTodoItem: { viewModel.deleteTodoItem(item: item) })
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .onDelete(perform: viewModel.deleteTodoItem)
                    }
                    .padding()
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
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    WeatherView()
                }
                
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



