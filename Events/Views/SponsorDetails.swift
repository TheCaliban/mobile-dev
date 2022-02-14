import SwiftUI

struct SponsorDetails: View {
    @State private var isLoaded = false
    
    @State private var showOverlay = false
    @State private var titleBanner = "Error"
    @State private var messageBanner = ""
    
    var sponsor: Sponsor
    @State private var contact: [Speaker] = []
    
    var body: some View {
        ZStack {
        ScrollView {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text(sponsor.fields.name)
                        .font(.title)
                    
                    if (sponsor.fields.previousSponsor != nil) {
                        Image(systemName: "heart.fill")
                    } else {
                        Image(systemName: "heart")
                    }
                }
                
                
                Text("Sponsor for " + String(sponsor.fields.sponsoredAmount ?? 0) + " $")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Divider()
                
                Group {
                    if (contact.count > 0) {
                        SpeakerRow(speakers: contact)
                    } else {
                        Text("No contact for this sponsor")
                    }
                }
                
                
            }
            .padding()
            
        }}
        .navigationTitle(sponsor.fields.name)
        .navigationBarTitleDisplayMode(.inline)
        // Banner notification
        .overlay(overlayView: Banner.init(data: Banner.BannerDataModel(title: titleBanner, detail: messageBanner, type: .error), show: $showOverlay)
                 , show: $showOverlay)
        .onAppear(perform: {
            // Prevent double data loading
            if (isLoaded) {
                return
            }
            
            if (sponsor.fields.contactsId != nil) {
                sponsor.fields.contactsId?.forEach { id in
                    ApiService.call(
                        Speaker.self,
                        url: "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Speakers%20%26%20attendees/\(id)"
                    ) { data in
                        isLoaded = true
                        
                        if (data != nil) {
                            contact.append(data!)
                        }
                    } errorHandler: { (error) in
                        // Display an error message
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
                }
            }
        })
    }
}
