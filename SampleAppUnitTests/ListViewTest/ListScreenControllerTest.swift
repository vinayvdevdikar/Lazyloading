//
//  ListViewController.swift
//  LazyLoadingSampleApp
//
//  Created by Vinay Devdikar on 22/01/22.
//
import XCTest
@testable import LazyLoadingSampleApp
class ListScreenControllerTest: XCTestCase {
    var mockViewController: ListScreenController!
    var mockTableView: UITableView!
    var mockResponseModel: [RecipeUIModel] = []
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockViewController = ListScreenController()
        mockTableView = UITableView(frame: .zero)
        mockTableView.register(ListItemTableViewCell.self)
        mockViewController.viewDidLoad()
        mockResponseModel.append(RecipeUIModel(name: "Crispy Fish Goujons",
                                               headline: "with Sweet Potato Wedges and Minted Snap Peas",
                                               imageUrl: "http://3.bp.blogspot.com/-MJJ_2T78qj4/Umfok8ua7AI/AAAAAAAANZw/t6Wgw9lfot0/s1600/IMG_5475-a.JPG", prepmin: 35))
        mockResponseModel.append(RecipeUIModel(name: "Moroccan Skirt Steak",
                                               headline: "with Spinach and Lemon Couscous",
                                               imageUrl: "http://3.bp.blogspot.com/-MJJ_2T78qj4/Umfok8ua7AI/AAAAAAAANZw/t6Wgw9lfot0/s1600/IMG_5475-a.JPG", prepmin: 30))
    }

    override func tearDownWithError() throws {
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // Test Datasource
    
    func test_numberOfRowsInSection() {
        mockViewController.recipesDidLoadSuccessfully(with: mockResponseModel)
        XCTAssertEqual(mockViewController.tableView(mockTableView, numberOfRowsInSection: 0), 2)
    }
    
    func test_cellForRowAt() {
        mockViewController.recipesDidLoadSuccessfully(with: mockResponseModel)
        let cell = mockViewController.tableView(mockTableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell.isKind(of: ListItemTableViewCell.self))
    }

}
