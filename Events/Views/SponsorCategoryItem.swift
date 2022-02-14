import SwiftUI

struct SponsorCategoryItem: View {
    var sponsor: Sponsor
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    .foregroundColor(Color("Green"))
                    .frame(width: 155, height: 155)
                
                Text(NameUtils.initialsFromName(name: sponsor.fields.name))
                    .font(.title)
                    .foregroundColor(.white)
            }
            
            Text(sponsor.fields.name)
                .foregroundColor(.primary)
                .frame(width: 155)
                .lineLimit(1)
        }
        
    }
}

