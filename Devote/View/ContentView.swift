//
//  ContentView.swift
//  Devote
//
//  Created by 鈴木航太 on 2024/02/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - propaty
    @AppStorage("idDarkMode") private var isDarkMode: Bool = false
    @State var task: String = ""
    @State private var showNewTaskItem: Bool = false
    
    
    // Fetch Data
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>


    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    // MARK: - body
    var body: some View {
        
        NavigationView {
            ZStack {
                // MARK: - MainView
        
                VStack {
                    // MARK: - Header
                    
                    HStack(spacing: 10) {
                        // Title
                        Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        
                        Spacer()
                        
                        // Edit Button
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2))
                        
                        
                        // Appearance Button
                        Button {
                            // Toggle Appearence
                            isDarkMode.toggle()
                            playSound(sound: "sound-tap", type: "mp3")
                            feedback.notificationOccurred(.success)
                        } label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width:24, height: 24)
                                .font(.system(.title, design: .rounded ))
                        }

                    } // Hstack
                    .padding()
                    .foregroundColor(.white)
                    Spacer(minLength: 80)
                    // MARK: - NewTask Button
                    
                    Button {
                       showNewTaskItem = true
                        playSound(sound: "sound-ding", type: "mp3")
                        feedback.notificationOccurred(.success)
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .semibold, design: .rounded))
                        
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .leading, endPoint: .trailing)
                            .clipShape(Capsule())
                    )
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0, y: 4 )

                    
                    List {
                        ForEach(items) { item in
                           ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    } // List
                    .scrollContentBackground(.hidden)
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue:0, opacity: 0.3),
                        radius: 10
                    )
                    .padding(.vertical, 0)

                    .frame(maxWidth: 640)
                    
                } // vstack
                .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.5))
                
                // MARK: - NewTaskITem
                
                if showNewTaskItem {
                    BlankView(
                        backgroundColor: isDarkMode ? Color.black : Color.gray,
                        backgroundOpacity: isDarkMode ? 0.3 : 0.5)
                        .onTapGesture {
                            withAnimation() {
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
            } // ZStack
            .onAppear() {
                UITableView.appearance().backgroundColor = UIColor.clear
            }
            
            .navigationBarTitle("Daily Tasks", displayMode: .large)
            .navigationBarHidden(true)

            .background(
            BackgroundImageView()
                .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
            )
            .background(
                backgroundGradient.ignoresSafeArea(.all)
            )
          
        } // NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

// MARK: - preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
