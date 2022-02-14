import SwiftUI

struct AttendeesListView: View {
    @State private var isLoaded = false
    
    @State private var showOverlay = false
    @State private var titleBanner = "Error"
    @State private var messageBanner = ""
    
    @State private var attendees: Array<Speaker> = []
    
    private var twoColumnsGrid: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            HStack {
                ZStack {
 
                    ScrollView {
                        LazyVGrid(columns: twoColumnsGrid) {
                            ForEach(attendees) { attendee in
                                SpeakerListItem(speaker: attendee)
                            }
                        }
                    }
                    .accessibility(identifier: "Attendees Container")
                    .navigationTitle("Attendees")
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        // Banner notification
        .overlay(overlayView: Banner.init(data: Banner.BannerDataModel(title: titleBanner, detail: messageBanner, type: .error), show: $showOverlay)
                 , show: $showOverlay)
        .onAppear(perform: {
            // Prevent double data loading
            if (isLoaded) {
                return
            }
            
            ApiService.call(RootSpeaker.self, url: "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Speakers%20%26%20attendees?filterByFormula=SEARCH(%22Attendee%22%2CType)") { data in
                isLoaded = true
                attendees = data?.speakers ?? []
            } errorHandler: { (error) in
                // Display a banner with an error message
                withAnimation { () -> Void in
                    switch (error) {
                    case .none:
                        break
                    case .some(.apiError(_, _)):
                        self.messageBanner = "An issue occured when querying the API"
                        break
                    case .some(.httpError(_)):
                        self.messageBanner = "We couldn't reach the API"
                        break
                    case .some(.parseError(_, _)):
                        self.messageBanner = "An issue occured while parsing the data"
                        break
                    }
                    
                    self.showOverlay = true
                }
            }
        })
    }
}

struct AttendeesListView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeesListView()
    }
}
