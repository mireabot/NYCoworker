//
//  CalendarBottomView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 5/17/23.
//

import SwiftUI

struct CalendarBottomView: View {
  @State private var selectedDate: Date = Date()
  @Binding var showDate: Bool
  @Binding var date: Date
  private let calendar = Calendar.current
  private let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "d"
    return formatter
  }()
  
  private var currentMonthYear: String {
    let monthYearFormatter = DateFormatter()
    monthYearFormatter.dateFormat = "MMMM yyyy"
    return monthYearFormatter.string(from: selectedDate)
  }
  
  private func isDateSelected(_ date: Date) -> Bool {
    return calendar.isDate(date, inSameDayAs: selectedDate)
  }
  
  private func selectDate(_ date: Date) {
    selectedDate = date
  }
  
  private func generateDatesForCurrentMonth(for month: Date) -> [Date] {
    let monthRange = calendar.range(of: .day, in: .month, for: month)!
    var dateComponents = calendar.dateComponents([.year, .month], from: month)
    dateComponents.day = 1
    guard let startDate = calendar.date(from: dateComponents) else {
      return []
    }
    
    var dates: [Date] = []
    var date = startDate
    
    for _ in monthRange {
      dates.append(date)
      date = calendar.date(byAdding: .day, value: 1, to: date)!
    }
    
    return dates
  }
  
  private func moveToPreviousMonth() {
    guard let previousMonth = calendar.date(byAdding: .month, value: -1, to: Date()) else {
      return
    }
    withAnimation(.easeOut(duration: 0.2)) {
      DispatchQueue.main.async {
        selectedDate = previousMonth
      }
    }
  }
  
  private func moveToCurrentMonth() {
    withAnimation(.easeOut(duration: 0.2)) {
      DispatchQueue.main.async {
        selectedDate = Date()
      }
    }
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text(currentMonthYear)
          .foregroundColor(Resources.Colors.customBlack)
          .font(Resources.Fonts.medium(withSize: 20))
        
        Spacer()
        
        HStack(alignment: .center, spacing: 10) {
          Button(action: moveToPreviousMonth) {
            Resources.Images.Navigation.chevronLeft
              .resizable()
              .frame(width: 30, height: 30)
              .foregroundColor(Resources.Colors.customBlack)
          }
          
          Button(action: moveToCurrentMonth) {
            Resources.Images.Navigation.chevronRight
              .resizable()
              .frame(width: 30, height: 30)
              .foregroundColor(Resources.Colors.customBlack)
          }
        }
      }
      .padding([.leading,.trailing], 15)
      .padding(.top, 20)
      
      VStack {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: 7), spacing: 5) {
          ForEach(generateDatesForCurrentMonth(for: selectedDate), id: \.self) { date in
            let isDateEnabled = calendar.isDate(date, inSameDayAs: selectedDate) || date <= calendar.startOfDay(for: Date())
            
            
            Button(action: {
              withAnimation(.spring()) {
                if isDateEnabled {
                  selectDate(date)
                }
              }
            }) {
              Text(formatter.string(from: date))
                .font(isDateSelected(date) ? Resources.Fonts.regular(withSize: 15) : Resources.Fonts.regular(withSize: 15))
                .foregroundColor(isDateSelected(date) ? Color.white : isDateEnabled ? Resources.Colors.customBlack : Color.gray)
                .padding(10)
                .background(isDateSelected(date) ? Resources.Colors.primary : Color.clear)
                .clipShape(Circle())
            }
          }
        }
      }
      
      Button {
        date = selectedDate
        showDate.toggle()
      } label: {
        Text("Apply")
      }
      .buttonStyle(NYCActionButtonStyle(showLoader: .constant(false)))
      .padding([.leading,.trailing], 10)

    }
    .padding(.bottom, 10)
    .background(Color.white)
  }
}

struct CalendarBottomView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarBottomView(showDate: .constant(true), date: .constant(Date()))
  }
}
