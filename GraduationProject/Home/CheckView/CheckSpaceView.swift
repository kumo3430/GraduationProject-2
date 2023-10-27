//
//  CheckSpaceView.swift
//  GraduationProject
//
//  Created by heonrim on 2023/9/24.
//

import SwiftUI

struct CheckSpaceView: View {
    @State var accumulatedValue: Float = 0.0
    @Binding var isTaskCompleted: Bool
    @State private var isCompleted: Bool = false
    
    let titleColor = Color(red: 229/255, green: 86/255, blue: 4/255)
    let customBlue = Color(red: 175/255, green: 168/255, blue: 149/255)
    var task: DailyTask
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(task.name)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(titleColor)
                    .padding(.bottom, 1)
                
                Text("習慣類型：間隔學習")
                    .font(.system(size: 13, weight: .medium, design: .default))
                    .foregroundColor(Color.secondary)
                    .padding(.bottom, 1)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("目標")
                            .font(.system(size: 12, weight: .medium, design: .serif))
                            .foregroundColor(Color.secondary)
                        
                        Text("\(task.targetValue, specifier: "%.1f") 次")
                            .font(.system(size: 16, weight: .semibold, design: .default))
                            .foregroundColor(customBlue)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("已完成")
                            .font(.system(size: 12, weight: .medium, design: .serif))
                            .foregroundColor(Color.secondary)
                        
                        Text("\(accumulatedValue, specifier: "%.1f") 次")
                            .font(.system(size: 16, weight: .semibold, design: .default))
                            .foregroundColor(customBlue)
                    }
                }
                .padding(.horizontal, 10)
                
                Button(action: {
                    accumulatedValue += 1.0
                    if accumulatedValue >= task.targetValue {
                        isTaskCompleted = true
                    }
                }) {
                    Image(systemName: "checkmark")
                        .foregroundColor(isTaskCompleted ? Color.gray : Color.white)
                        .padding(6)
                        .background(Capsule().fill(customBlue).shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2))
                        .font(.system(size: 16))
                }
                .disabled(isTaskCompleted)
                .padding(.horizontal, 10)
            }
            .padding(12)
            .background(isTaskCompleted ? Color.gray : Color.clear)
            if isTaskCompleted {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
                    .padding(15)
                    .background(Circle().fill(Color.green))
            }
        }
        .background(isTaskCompleted ? Color.gray : Color.clear)
    }
}

struct CheckSpaceView_Previews: PreviewProvider {
    @State static var isTaskCompletedPreview: Bool = false
    @State static var remainingValuePreview: Float = 0.0
    static var taskPreview = DailyTask(id: 1, name: "背單字", type: .space, isCompleted: false, targetValue: 5.0)
    
    static var previews: some View {
        CheckSpaceView(isTaskCompleted: $isTaskCompletedPreview, task: taskPreview)
            .environmentObject(TaskService.shared)
    }
}
