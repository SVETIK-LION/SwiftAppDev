import XCTest

@testable import Homeworks

final class NetworkServiceTests: XCTestCase {

    private var networkService: NetworkServiceSpy!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkServiceSpy()
    }
    
    override func tearDown() {
        networkService = nil
        super.tearDown()
    }
    
    func testGetAuthorizeRequest(){
        networkService.getAuthorizeRequest()
        XCTAssertTrue(networkService.isNetworkServiceCalled, "doesn't called")
    }

}
