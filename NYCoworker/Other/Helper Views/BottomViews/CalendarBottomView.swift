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
  
  private func generateDatesForCurrentMonth() -> [Date] {
    let currentDate = calendar.startOfDay(for: Date())
    let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate))!
    let range = calendar.range(of: .day, in: .month, for: selectedDate)!
    let days = Range(uncheckedBounds: (lower: 1, upper: range.upperBound))
    
    return days.compactMap { day in
      let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)!
      return calendar.isDate(date, inSameDayAs: currentDate) || date < currentDate ? date : nil
    }
  }
  
  var body: some View {
    VStack(alignment: .center) {
      GrabberView()
      VStack(alignment: .leading) {
        HStack {
          Button {
            showDate.toggle()
          } label: {
            Text("Cancel")
              .foregroundColor(Resources.Colors.primary)
              .font(Resources.Fonts.medium(withSize: 17))
          }
          
          Spacer()
          Button {
            date = selectedDate
            showDate.toggle()
          } label: {
            Text("Done")
              .foregroundColor(Resources.Colors.primary)
              .font(Resources.Fonts.medium(withSize: 17))
          }
          
        }
        .padding([.leading,.trailing], 10)
        .padding(.top, 15)
        .padding(.bottom, 10)
        
        Text(currentMonthYear)
          .foregroundColor(Resources.Colors.customBlack)
          .font(Resources.Fonts.medium(withSize: 20))
          .padding(.leading, 10)
        VStack {
          LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: 7), spacing: 5) {
            ForEach(0..<generateDatesForCurrentMonth().count, id: \.self) { index in
              Button(action: {
                DispatchQueue.main.async {
                  withAnimation(.spring()) {
                    selectDate(generateDatesForCurrentMonth()[index])
                  }
                }
              }) {
                Text(formatter.string(from: generateDatesForCurrentMonth()[index]))
                  .font(isDateSelected(generateDatesForCurrentMonth()[index]) ? Resources.Fonts.medium(withSize: 15) : Resources.Fonts.regular(withSize: 15))
                  .foregroundColor(isDateSelected(generateDatesForCurrentMonth()[index]) ? Color.white : Resources.Colors.customBlack)
                  .padding(10)
                  .background(isDateSelected(generateDatesForCurrentMonth()[index]) ? Resources.Colors.primary : Color.clear)
                  .clipShape(Circle())
              }
            }
          }
        }
      }
      .padding(.bottom, 30)
      .background(Color.white)
      .cornerRadius(16, corners: [.topLeft,.topRight])
    }
  }
}

struct CalendarBottomView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarBottomView(showDate: .constant(true), date: .constant(Date()))
  }
}
