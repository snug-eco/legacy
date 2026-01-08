import XCTest
import SwiftTreeSitter
import TreeSitterSnug

final class TreeSitterSnugTests: XCTestCase {
    func testCanLoadGrammar() throws {
        let parser = Parser()
        let language = Language(language: tree_sitter_snug())
        XCTAssertNoThrow(try parser.setLanguage(language),
                         "Error loading Snug grammar")
    }
}
