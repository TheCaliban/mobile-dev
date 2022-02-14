import SwiftUI

struct SponsorsCategoryRow: View {
    var categoryName: String
    var items: [Sponsor]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text(categoryName)
                    .font(.headline)
            }
            .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top ) {
                    ForEach(items) { sponsor in
                        NavigationLink(destination: SponsorDetails(sponsor: sponsor)) {
                            SponsorCategoryItem(sponsor: sponsor)
                        }
                        
                    }
                    .padding(.leading)
                }
            }
            .frame(height:185)
        }
    }
}
