//
//  AdminHomeView.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 4/10/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct AdminLocationView: View {
    @Environment(\.dismiss) var makeDismiss
    @State private var locationName: String = ""
    @State private var latitude: Double = 0
    @State private var longitude: Double = 0
    @State private var locationType: LocationType = .library
    @State private var locationID: String = ""
    @State private var locationAmenities: [String] = []
    @State private var locationHours: [WorkingHours] = Array(repeating: WorkingHours(hours: "", weekDay: ""), count: 7)
    @State private var locationImages: [URL] = [URL(string: "https://firebasestorage.googleapis.com/v0/b/nycoworker-10d04.appspot.com/o/LocationImages%2F1.png?alt=media&token=1d1fa8d4-367c-480e-b8bc-9fd5c6d72dc8")!]
    @State private var locationTags: [String] = []
    @State private var reviews: Int = 0
    @State private var locationAddress: String = ""
    var body: some View {
        ScrollView(.vertical, showsIndicators: true, content: {
            VStack(spacing: 10) {
                NYCTextField(title: "Location name", placeholder: "Public Hotel", text: $locationName)
                HStack {
                    TextField("Latitude", value: $latitude, formatter: NumberFormatter())
                        .padding()
                    TextField("Longitude", value: $longitude, formatter: NumberFormatter())
                        .padding()
                }
                Picker("Location Type", selection: $locationType) {
                    Text("Library").tag(LocationType.library)
                    Text("Hotel").tag(LocationType.hotel)
                    Text("Public Space").tag(LocationType.publicSpace)
                }
                .pickerStyle(SegmentedPickerStyle())
                NYCTextField(title: "Location ID", placeholder: "adamsLibrary", text: $locationID)
                NYCTextField(title: "Location Address", placeholder: "9 Adams St", text: $locationAddress)
                
                VStack {
                    Text("Working Hours")
                        .font(.headline)
                        .padding(.top)
                    ForEach(0..<7) { index in
                        HStack {
                            Text(weekday(for: index))
                            TextField("Hours", text: $locationHours[index].hours)
                        }
                        .padding(.bottom)
                    }
                }
                Button {
                    saveLocation()
                } label: {
                    Text("Save Location")
                }
                .disabled(locationName.isEmpty || locationID.isEmpty)
                .buttonStyle(NYCActionButtonStyle(showLoader: .constant(false)))
                
                Spacer()
            }.padding([.leading,.trailing], 16)
        })
        .navigationBarBackButtonHidden()
        .toolbarBackground(.white, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    makeDismiss()
                } label: {
                    Resources.Images.Navigation.arrowBack
                        .foregroundColor(Resources.Colors.primary)
                }
                
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Text("Add location")
                    .foregroundColor(Resources.Colors.customBlack)
                    .font(Resources.Fonts.medium(withSize: 17))
            }
        }
    }
    func weekday(for index: Int) -> String {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2
        let weekdaySymbols = calendar.shortWeekdaySymbols
        return weekdaySymbols[index]
    }
}

struct AdminLocationView_Previews: PreviewProvider {
    static var previews: some View {
        AdminLocationView()
    }
}

extension AdminLocationView {
    func addLocationToFirestore(location: Location) {
        let db = Firestore.firestore()
        
        do {
            let locationData = try Firestore.Encoder().encode(location)
            db.collection("Locations").document().setData(locationData)
        } catch let error {
            print("Error encoding location: \(error.localizedDescription)")
        }
    }
    
    func saveLocation() {
        let location = Location(
            locationName: locationName,
            locationCoordinates: GeoPoint(latitude: latitude, longitude: longitude),
            locationType: locationType,
            locationID: locationID,
            locationAmenities: locationAmenities,
            locationHours: locationHours,
            locationImages: locationImages,
            locationTags: locationTags,
            reviews: reviews,
            locationAddress: locationAddress
        )
        addLocationToFirestore(location: location)
    }
}
