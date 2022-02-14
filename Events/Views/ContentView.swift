import SwiftUI

struct ContentView: View {
    var body: some View {
     
        TabView{
            
            ActivitesList(activities: nil)
                .padding(.all, 0.0)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Schedule")
                }
            SponsorsView()
                .tabItem {
                    Image(systemName: "rosette")
                    Text("Sponsors")
                }
            AttendeesListView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Attendees")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

