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
  // Location information
  @State private var locationName: String = ""
  @State private var latitude: Double = 0.0
  @State private var longitude: Double = 0.0
  @State private var locationType: LocationType = .library
  @State private var locationID: String = ""
  @State private var locationAmenitiesText: String = ""
  @State private var locationAmenities: [String] = []
  @State private var locationImages: [URL] = [URL(string: "https://firebasestorage.googleapis.com/v0/b/nycoworker-10d04.appspot.com/o/LocationImages%2F1.png?alt=media&token=1d1fa8d4-367c-480e-b8bc-9fd5c6d72dc8")!]
  @State private var locationTags: [String] = []
  @State private var reviews: Int = 0
  @State private var locationAddress: String = ""
  // Location updates
  @State private var title: String = ""
  @State private var text: String = ""
  @State private var url: String = ""
  @State private var locationUpdates: [LocationUpdates] = []
  // Location working hours
  @State private var weekday: String = ""
  @State private var hours: String = ""
  @State private var locationHours: [WorkingHours] = []
  var body: some View {
    ScrollView(.vertical, showsIndicators: true, content: {
      VStack(spacing: 10) {
        NYCTextField(title: "Location name", placeholder: "Public Hotel", text: $locationName)
        HStack {
          TextField("Latitude", value: $latitude, formatter: createFormatter())
            .padding()
          TextField("Longitude", value: $longitude, formatter: createFormatter())
            .padding()
        }
        Picker("Location Type", selection: $locationType) {
          Text("Library").tag(LocationType.library)
          Text("Hotel").tag(LocationType.hotel)
          Text("Public Space").tag(LocationType.publicSpace)
          Text("Café").tag(LocationType.cafe)
        }
        .pickerStyle(SegmentedPickerStyle())
        NYCTextField(title: "Location ID", placeholder: "adamsLibrary", text: $locationID)
        NYCTextField(title: "Location Address", placeholder: "9 Adams St", text: $locationAddress)
        NYCTextField(title: "Location Amenities", placeholder: "Wi-Fi", text: $locationAmenitiesText)
        Button("Append") {
          locationAmenities.append(locationAmenitiesText)
          locationAmenitiesText = ""
          print(locationAmenities)
        }
        .disabled(locationAmenitiesText.isEmpty)
        .padding()
        
        VStack {
          Text("Working Hours")
            .font(.headline)
            .padding(.top)
          NYCTextField(title: "Week Day", placeholder: "Monday", text: $weekday)
          NYCTextField(title: "Working Hours", placeholder: "5AM - 7PM", text: $hours)
          Button("Append") {
            let newData = WorkingHours(hours: hours, weekDay: weekday)
            locationHours.append(newData)
            clearHours()
            print(locationHours)
          }
          .disabled(weekday.isEmpty || hours.isEmpty)
          .padding()
        }
        
        VStack {
          Text("Spot updates")
            .font(.headline)
            .padding(.top)
          NYCTextField(title: "Card Title", placeholder: "Stay connected", text: $title)
          NYCTextField(title: "Card Text", placeholder: "Start typing...", text: $text)
          NYCTextField(title: "Card Url", placeholder: "Start typing...", text: $url)
          Button("Append") {
            let newData = LocationUpdates(title: title, text: text, url: url)
            locationUpdates.append(newData)
            clearUpdates()
            print(locationUpdates)
          }
          .disabled(weekday.isEmpty || hours.isEmpty)
          .padding()
        }
        Button {
          saveLocation()
        } label: {
          Text("Save Location")
        }
        .disabled(title.isEmpty || text.isEmpty)
        .buttonStyle(NYCActionButtonStyle(showLoader: .constant(false)))
        
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
      db.collection(Endpoints.locations.rawValue).document(location.locationID).setData(locationData)
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
      locationUpdates: locationUpdates,
      locationAddress: locationAddress
    )
    addLocationToFirestore(location: location)
  }
  
  func createFormatter() -> NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 20
    return formatter
  }
  
  func clearUpdates() {
    title = ""
    text = ""
    url = ""
  }
  func clearHours() {
    hours = ""
    weekday = ""
  }
}

