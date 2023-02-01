//
//  HomeView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/30/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                /// Map section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Locations nearby")
                        .foregroundColor(Resources.Colors.customBlack)
                        .font(Resources.Fonts.bold(withSize: 22))
                    
                    ZStack {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width - 16, height: 100)
                            .cornerRadius(10)
                        
                        Button {
                            
                        } label: {
                            Text("Open map")
                                .frame(width: UIScreen.main.bounds.width / 2, height: 40)
                        }
                        .buttonStyle(NYCActionButtonStyle())
                    }
                }
                .padding([.leading,.trailing], 20)
                .padding(.top, 20)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("appLogo")
                        .resizable()
                        .frame(width: 44, height: 44)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NYCCircleImageButton(size: 20, image: Image("rate")) {
                        
                    }
                }
            }
            .toolbarBackground(.white, for: .navigationBar, .automatic)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
