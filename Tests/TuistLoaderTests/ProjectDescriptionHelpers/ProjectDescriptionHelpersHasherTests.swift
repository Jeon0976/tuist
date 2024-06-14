import MockableTest
import Path
import ProjectDescription
import TuistCore
import TuistSupport
import XCTest

@testable import TuistLoader
@testable import TuistSupportTesting

class ProjectDescriptionHelpersHasherTests: TuistUnitTestCase {
    var subject: ProjectDescriptionHelpersHasher!

    override func setUp() {
        super.setUp()
        given(swiftVersionProvider)
            .swiftVersion()
            .willReturn("5.2")
        subject = ProjectDescriptionHelpersHasher(tuistVersion: "3.2.1")
    }

    override func tearDown() {
        subject = nil
        super.tearDown()
    }

    func test_hash() throws {
        // Given
        let temporaryDir = try temporaryPath()
        let helperPath = temporaryDir.appending(component: "Project+Templates.swift")
        try FileHandler.shared.write("import ProjectDescription", path: helperPath, atomically: true)
        environment.manifestLoadingVariables = ["TUIST_VARIABLE": "TEST"]

        // Then
        for _ in 0 ..< 20 {
            let got = try subject.hash(helpersDirectory: temporaryDir)
            XCTAssertEqual(got, "0a46768e766bdd05bdf901098d323b8a")
        }
    }

    func test_prefixHash() throws {
        // Given
        let path = try AbsolutePath(validating: "/path/to/helpers")
        let pathString = path.pathString
        let index = pathString.index(pathString.startIndex, offsetBy: 7)
        let expected = String(pathString.md5[..<index])

        // When
        let got = subject.prefixHash(helpersDirectory: path)

        // Then
        XCTAssertEqual(got, expected)
    }
}
