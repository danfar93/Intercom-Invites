import XCTest

@testable import Intercom_Invites

class Intercom_Invites_Tests: XCTestCase {

    var customerLine = String()
    var customerLineNullLatValue = String()
    var customerLineNullIDValue = String()
    var customerLineNullNameValue = String()
    var customerLineNullLongValue = String()

    override func setUp() {
        customerLine = "{\"latitude\": \"52.986375\", \"user_id\": 12, \"name\": \"Christina McArdle\", \"longitude\": \"-6.043701\"}"
        customerLineNullLatValue = "{\"latitude\": , \"user_id\": 12, \"name\": \"Christina McArdle\", \"longitude\": \"-6.043701\"}"
        customerLineNullIDValue = "{\"latitude\": \"52.986375\", \"user_id\": , \"name\": \"Christina McArdle\", \"longitude\": \"-6.043701\"}"
        customerLineNullNameValue = "{\"latitude\": \"52.986375\", \"user_id\": 12, \"name\": , \"longitude\": \"-6.043701\"}"
        customerLineNullLongValue = "{\"latitude\": \"52.986375\", \"user_id\": 12, \"name\": \"Christina McArdle\", \"longitude\": }"
    }

    override func tearDown() {

    }

    /// Tests Converting Degrees to Radians
    /// Method Under Test: DegreesConverterSupport.convertDegreesToRadians()
    /// Assert - true
    func testDegreesConverterSuccess() {

        var didConvertCorrectly = Bool()
        var radian = Double()
        let sampleDegree = 53.339428
        let correctRadianValue = 0.9304766884444444
        let degreesConverter = DegreesConverter()
        radian = degreesConverter.convertDegreesToRadians(degree: sampleDegree)

        didConvertCorrectly = radian.isEqual(to: correctRadianValue) ? true : false
        XCTAssertTrue(didConvertCorrectly)
    }

    /// Tests Converting Degrees to Radians
    /// Method Under Test: DegreesConverterSupport.convertDegreesToRadians()
    /// Assert - false
    func testDegreesConverterFailure() {

        var didConvertCorrectly = Bool()
        var radian = Double()
        let sampleDegree = 53.339428
        let incorrectRadianValue = 1.930484444444
        let degreesConverter = DegreesConverter()
        radian = degreesConverter.convertDegreesToRadians(degree: sampleDegree)

        didConvertCorrectly = radian.isEqual(to: incorrectRadianValue) ? true : false
        XCTAssertFalse(didConvertCorrectly)
    }

    /// Tests Calculating Distance Between Customer & Intercom
    /// Method Under Test: HaversineFormulaSupport.calculateDistanceUsingHaversine()
    /// Assert - true
    func testHarversineFormulaSuccess() {

        var didCalculateDistanceFromIntercomCorrectly = Bool()
        let sampleCustomerLat: Double = 53.1489345
        let sampleCustomerLong: Double = -6.8422408
        let correctDistance: Double = 44.33856573057924
        var distance = Double()

        let haversineFormula = HaversineFormula()
        distance = haversineFormula.calculateDistanceUsingHaversine(
            customerLat: sampleCustomerLat,
            customerLong: sampleCustomerLong)

        didCalculateDistanceFromIntercomCorrectly = distance.isEqual(to: correctDistance) ? true : false
        XCTAssertTrue(didCalculateDistanceFromIntercomCorrectly)
    }

    /// Tests Calculating Distance Between Customer & Intercom
    /// Method Under Test: HaversineFormulaSupport.calculateDistanceUsingHaversine()
    /// Assert - false
    func testHarversineFormulaFailure() {

        var didCalculateDistanceFromIntercomCorrectly = Bool()
        let sampleCustomerLat: Double = 53.1489345
        let sampleCustomerLong: Double = -6.8422408
        let incorrectDistance: Double = 61.33856573057924
        var distance = Double()

        let haversineFormula = HaversineFormula()
        distance = haversineFormula.calculateDistanceUsingHaversine(
            customerLat: sampleCustomerLat,
            customerLong: sampleCustomerLong)

        didCalculateDistanceFromIntercomCorrectly = distance.isEqual(to: incorrectDistance) ? true : false
        XCTAssertFalse(didCalculateDistanceFromIntercomCorrectly)
    }

    /// Tests Successful Validation of Customer within 100 miles of Intercom
    /// Method Under Test: DistanceValidator.isCustomerEligibleForInvite()
    /// Assert - true
    func testDistanceValidatorSuccess() {
        var isEligible = Bool()
        let distance: Double = 86.3
        let validator = DistanceValidator()
        isEligible = validator.isCustomerEligibleForInvite(distance: distance)
        XCTAssertTrue(isEligible)
    }

    /// Tests Successful Validation of Customer within 100 miles of Intercom
    /// Method Under Test: DistanceValidator.isCustomerEligibleForInvite()
    /// Assert - false
    func testDistanceValidatorFailure() {
        var isEligible = Bool()
        let distance: Double = 101.1
        let validator = DistanceValidator()
        isEligible = validator.isCustomerEligibleForInvite(distance: distance)
        XCTAssertFalse(isEligible)
    }

    /// Tests converting a single line to a Customer object
    /// Method Under Test: HomeViewController.convertEachLinetoJsonObject()
    /// Assert - No Error Thrown
    func testConvertingSingleLineToCustomerObjectSuccess() throws {
        let vc = HomeViewController()
        XCTAssertNoThrow(try vc.convertEachLinetoJsonObject(customerLine: customerLine))
    }

    /// Tests converting a single line to a Customer object with null latitude value
    /// Method Under Test: HomeViewController.convertEachLinetoJsonObject()
    /// Assert - Error Thrown
    func testConvertingSingleLineToCustomerObjectNullLatValueFailure() throws {
        let vc = HomeViewController()
        XCTAssertThrowsError(try vc.convertEachLinetoJsonObject(customerLine: customerLineNullLatValue))
    }

    /// Tests converting a single line to a Customer object with null longitude value
    /// Method Under Test: HomeViewController.convertEachLinetoJsonObject()
    /// Assert - Error Thrown
    func testConvertingSingleLineToCustomerObjectNullLongValueFailure() throws {
        let vc = HomeViewController()
        XCTAssertThrowsError(try vc.convertEachLinetoJsonObject(customerLine: customerLineNullLongValue))
    }

    /// Tests converting a single line to a Customer object with null user_id value
    /// Method Under Test: HomeViewController.convertEachLinetoJsonObject()
    /// Assert - Error Thrown
    func testConvertingSingleLineToCustomerObjectNullIDValueFailure() throws {
        let vc = HomeViewController()
        XCTAssertThrowsError(try vc.convertEachLinetoJsonObject(customerLine: customerLineNullIDValue))
    }

    /// Tests converting a single line to a Customer object with null name value
    /// Method Under Test: HomeViewController.convertEachLinetoJsonObject()
    /// Assert - Error Thrown
    func testConvertingSingleLineToCustomerObjectNullNameValueFailure() throws {
        let vc = HomeViewController()
        XCTAssertThrowsError(try vc.convertEachLinetoJsonObject(customerLine: customerLineNullNameValue))
    }

    /// Test initalisation of Customer object
    /// Assert - not nil
    func testCustomerModelInitialisation() {
        let customer = Customer(longitude: "53.1489345", latitude: "-6.8422408", name: "Daniel Farrell", userId: 13)
        XCTAssertNotNil(customer)
    }

    /// Test initalisation of Customer object & setting radian values after initialisation
    /// Assert - not nil
    func testCustomerModelSetRadians() {
        var customer = Customer(longitude: "53.1489345", latitude: "-6.8422408", name: "Daniel Farrell", userId: 13)
        customer.latRadian = 0.930948639728
        customer.longRadian = -0.10921684028
        XCTAssertTrue(customer.latRadian != nil && customer.longRadian != nil)
    }
}
