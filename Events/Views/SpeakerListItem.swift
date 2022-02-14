import SwiftUI

struct SpeakerListItem: View {
    var speaker: Speaker
    
    var body: some View {
        NavigationLink(destination: PersonView(person: speaker)) {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .foregroundColor(Color("Green"))
                        .frame(width: 155, height: 155)
                    
                    Text(NameUtils.initialsFromName(name: speaker.fields.name))
                        .font(.title)
                        .foregroundColor(.white)
                }
                
                Text(speaker.fields.name)
                    .foregroundColor(.primary)
                    .frame(width: 155)
                    .lineLimit(1)
            }
        }
    }
}
