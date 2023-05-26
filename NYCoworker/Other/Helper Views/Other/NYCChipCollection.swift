//
//  NYCChipCollection.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 5/26/23.
//

import SwiftUI

struct NYCChipCollection: View {
  var tags: [String]
  @Binding var title: String
  @State private var totalHeight
  = CGFloat.zero       // << variant for ScrollView/List
  //    = CGFloat.infinity   // << variant for VStack
  
  var body: some View {
    VStack {
      GeometryReader { geometry in
        self.generateContent(in: geometry)
      }
    }
    .frame(height: totalHeight)// << variant for ScrollView/List
    //.frame(maxHeight: totalHeight) // << variant for VStack
  }
  
  private func generateContent(in g: GeometryProxy) -> some View {
    var width = CGFloat.zero
    var height = CGFloat.zero
    
    return ZStack(alignment: .topLeading) {
      ForEach(self.tags, id: \.self) { tag in
        self.item(for: tag)
          .padding([.horizontal, .vertical], 4)
          .alignmentGuide(.leading, computeValue: { d in
            if (abs(width - d.width) > g.size.width)
            {
              width = 0
              height -= d.height
            }
            let result = width
            if tag == self.tags.last! {
              width = 0 //last item
            } else {
              width -= d.width
            }
            return result
          })
          .alignmentGuide(.top, computeValue: {d in
            let result = height
            if tag == self.tags.last! {
              height = 0 // last item
            }
            return result
          })
      }
    }.background(viewHeightReader($totalHeight))
  }
  
  private func item(for text: String) -> some View {
    Text(text)
      .padding([.horizontal,.vertical], 10)
      .font(Resources.Fonts.regular(withSize: 17))
      .background(title == text ? Resources.Colors.primary : Resources.Colors.customGrey)
      .foregroundColor(title == text ? Color.white : Resources.Colors.darkGrey)
      .cornerRadius(10)
      .onTapGesture {
        withAnimation(.easeOut) { title = text }
      }
  }
  
  private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
    return GeometryReader { geometry -> Color in
      let rect = geometry.frame(in: .local)
      DispatchQueue.main.async {
        binding.wrappedValue = rect.size.height
      }
      return .clear
    }
  }
}


struct NYCChipCollection_Previews: PreviewProvider {
  static var previews: some View {
    NYCChipCollection(tags: ["General information", "Amenities", "Working hours", "Image content"], title: .constant("Amenities"))
  }
}
