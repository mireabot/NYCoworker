//
//  NYCResizableTextField.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 2/21/23.
//

import SwiftUI

struct NYCResizableTextField: UIViewRepresentable{
    @Binding var text:String
    @Binding var height:CGFloat
    var placeholderText: String
    @State var editing:Bool = false
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.text = placeholderText
        textView.delegate = context.coordinator
        textView.textColor = UIColor(Resources.Colors.customBlack)
        textView.backgroundColor = UIColor(Resources.Colors.customGrey)
        textView.font = UIFont(name: "Nunito-Regular", size: 17)
        textView.tintColor = UIColor(Resources.Colors.primary)
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
        if self.text.isEmpty == true {
            textView.text = self.editing ? "" : self.placeholderText
            textView.textColor = self.editing ? UIColor(Resources.Colors.customBlack) : .lightGray
        }
        
        DispatchQueue.main.async {
            self.height = textView.contentSize.height
            textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        NYCResizableTextField.Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate{
        var parent: NYCResizableTextField
        
        init(_ params: NYCResizableTextField) {
            self.parent = params
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            DispatchQueue.main.async {
               self.parent.editing = true
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            DispatchQueue.main.async {
               self.parent.editing = false
            }
        }
        
        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.height = textView.contentSize.height
                self.parent.text = textView.text
            }
        }
    }
    
}

//struct NYCResizableTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        NYCResizableTextField()
//    }
//}
