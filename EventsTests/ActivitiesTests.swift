import XCTest

@testable import Events

class ActivitiesTests: XCTestCase {
    
    func testLoadingFromAPI() throws {
        var activities: [Activity]?
        let expectation = self.expectation(description: "API call")

        Events.ApiService.call(Root.self, url: "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Schedule") { (data) in
            activities = data?.activities ?? nil
            expectation.fulfill()
        } errorHandler: { _ in }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(activities)
    }

}
