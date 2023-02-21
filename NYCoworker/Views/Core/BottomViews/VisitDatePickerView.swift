//
//  VisitDatePickerView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/21/23.
//

import SwiftUI

struct VisitDatePickerView: View {
    @Binding var date: Date
    @Binding var isPresented: Bool
    var body: some View {
        ActionSheetView(bgColor: .white) {
            VStack {
                DatePicker("", selection: $date, displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(.wheel)
                
                NYCActionButton(action: {
                    print(date)
                    DispatchQueue.main.async {
                        isPresented.toggle()
                    }
                }, text: "Select")
                .padding(.top, 10)
                .padding([.leading,.trailing], 16)
            }
        }
    }
}

//struct VisitDatePickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        VisitDatePickerView()
//    }
//}
