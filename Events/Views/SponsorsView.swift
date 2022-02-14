import SwiftUI

struct SponsorsView: View {
    @State private var isLoaded = false
    
    @State private var showOverlay = false
    @State private var titleBanner = "Error"
    @State private var messageBanner = ""
    
    @State private var sponsors: [Sponsor] = []
    @State private var categorizedSponsors: [String: [Sponsor]] = Dictionary()
    
    var body: some View {
        NavigationView {
            HStack {
                ZStack {
                    ScrollView{
                        ForEach(Array(categorizedSponsors.keys), id: \.self) { key in
                            SponsorsCategoryRow(categoryName: key, items: categorizedSponsors[key] ?? [])
                                .padding(.top)
                        }
                    }
                    .accessibility(identifier: "Sponsors Container")
                    .navigationTitle("Sponsors")
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
            
            ApiService.call(RootSponsors.self, url: "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Sponsors") { (data) in
                isLoaded = true
                sponsors = data?.sponsors ?? []
                if (sponsors.count > 0) {
                    categorizedSponsors = Dictionary(
                        grouping: sponsors,
                        by: { $0.fields.status }
                    )
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
        })
    }
}

struct SponsorsView_Previews: PreviewProvider {
    static var previews: some View {
        SponsorsView()
    }
}
