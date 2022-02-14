import XCTest

@testable import Events

class SponsorsTests: XCTestCase {
    
    func testLoadingFromAPI() throws {
        var sponsors: [Sponsor]? = nil
        let expect = expectation(description: "API call")
        
        Events.ApiService.call(RootSponsors.self, url: "https://api.airtable.com/v0/appXKn0DvuHuLw4DV/Sponsors") { (data) in
            sponsors = data?.sponsors
            expect.fulfill()
        } errorHandler: { _ in }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(sponsors)
    }

}
