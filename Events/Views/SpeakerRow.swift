import SwiftUI

struct SpeakerRow: View {
    var speakers: [Speaker]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("Speakers")
                    .font(.headline)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top ) {
                    ForEach(speakers) { speaker in
                        SpeakerListItem(speaker: speaker)
                    }
                }
            }
            .frame(height:185)
        }
    }
}
