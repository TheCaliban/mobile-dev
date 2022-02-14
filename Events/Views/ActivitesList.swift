import SwiftUI
import Foundation

struct ActivitesList: View {
    @State private var isLoaded = false
    
    @State var small = true
    @Namespace var namespace
    
    @State private var showOverlay = false
    @State private var titleBanner = "Error"
    @State private var messageBanner = ""
    
    @State private var activities: Array<Activity> = []
    
    @State private var availableDates: [Date] = []
    @State private var selectedDate: Date = Date()
    
    
    
    init(activities: Array<Activity>?) {
        if (activities != nil) {
            self.activities = activities!
        }
    }
    
    var body: some View {
        NavigationView {
            HStack {
                ZStack {
                    // Scrollview
                    ScrollView {
                        VStack {
                            HStack {
                                // Date picker
                                Text("Selected date:")
                                    .font(.title2)
                                
                                Picker(DateUtils.formattedStringFromDate(from: selectedDate), selection: $selectedDate) {
                                    ForEach(availableDates, id: \.self) {
                                        Text(DateUtils.formattedStringFromDate(from: $0))
                                    }
                                }
                                .accessibility(identifier: "Date picker")
                                .pickerStyle(MenuPickerStyle())
                                .font(.title2)
                            }
                            
                            // Display activies
                            ForEach(
                                activities.filter { activity in
                                    DateUtils.dayOnlyDateFromDate(from: activity.fields.startDate) == selectedDate
                                }.sorted(by: { (a, b) -> Bool in
                                    return (b.fields.startDate.compare(a.fields.startDate) == .orderedDescending)
                                }),
                                id: \.self
                            ) { activity in
                                NavigationLink(destination: ActivitiesDetails(activity: activity)) {
                                    ActivitiesRow(activity: activity)
                                    
                                }
                                .accessibility(identifier: "activity\(activities.firstIndex(of:activity) ?? -1)")
                            }
                        }
                        .accessibility(identifier: "Activies Container")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .navigationTitle("Activities")
                    .accessibility(identifier: "Activities List")
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        // Notification Banner
        .overlay(overlayView: Banner.init(data: Banner.BannerDataModel(title: titleBanner, detail: messageBanner, type: .error), show: $showOverlay)
                 , show: $showOverlay)
        .onAppear(perform: {
            // Prevent double loading
            if (isLoaded) {
                return
            }
            
            // Load activities
            ApiService.call(Root.self, url: "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Schedule") { (data) in
                isLoaded = true
                activities = data?.activities ?? []
                
                if (activities.count > 0) {
                    activities.forEach { activity in
                        let activityDate = DateUtils.dayOnlyDateFromDate(from: activity.fields.startDate)
                        
                        if (!availableDates.contains(activityDate)) {
                            availableDates.append(activityDate)
                        }
                    }
                    
                    availableDates = DateUtils.sortedDateArray(from: availableDates)
                    selectedDate = availableDates[0]
                }
            } errorHandler: { (error) in
                // Banner handling
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
