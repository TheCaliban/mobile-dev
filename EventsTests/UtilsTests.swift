import XCTest
import MapKit

@testable import Events

class UtilsTests: XCTestCase {

   
    func testInitialsFromSimpleName() throws {
        let initals = Events.NameUtils.initialsFromName(name: "Thibault LEPEZ")
        
        XCTAssertEqual(initals, "TL")
    }
    
    func testInitialsFromComplexName() throws {
        let initals = Events.NameUtils.initialsFromName(name: "Thibault of the Hill")
        
        XCTAssertEqual(initals, "TH")
    }
    
}
