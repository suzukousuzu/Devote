//
//  NewTaskItemView.swift
//  Devote
//
//  Created by 鈴木航太 on 2024/02/23.
//

import SwiftUI

struct NewTaskItemView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @State private var task: String = ""
    @Binding var isShowing: Bool
    
    
    private var isButtonDisable: Bool {
        task.isEmpty
    }
    
     func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()
            
            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            task = ""
            hideKeyboard()
            isShowing = false
        }
    }
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 16) {
                TextField("New Task", text: $task)
                    .foregroundColor(.pink)
                    .font(.system(size:24, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground)
                        
                    )
                    .cornerRadius(10)
                
                Button {
                    addItem()
                    playSound(sound: "sound-ding", type: "mp3")
                    feedback.notificationOccurred(.success)
                } label: {
                    Spacer()
                    Text("Save")
                        .font(.system(size:24, weight: .bold, design: .rounded))
                    Spacer()
                }
                .disabled(isButtonDisable)
                .onTapGesture {
                    if isButtonDisable{
                        playSound(sound: "sound-tap", type: "mp3")
                        
                    }
                }
                .padding()
                .font(.headline)
                .foregroundColor(.white)
                .background(isButtonDisable ? Color.blue :Color.pink)
                .cornerRadius(10)

                
            } // vstack
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(
                isDarkMode
                ? Color(UIColor.tertiarySystemBackground)
                : Color(UIColor.secondarySystemBackground)
            )
            .cornerRadius(16)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0), radius: 24)
            .frame(maxWidth: 640)
            
        } // VStack
        .padding()
        
    }
}

struct NewTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskItemView(isShowing: .constant(true))
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
