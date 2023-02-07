//
// Copyright (c) 2021 Related Code - https://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import FirebaseAuth
import FirebaseFirestore

class FeedView: UIViewController {
	@IBOutlet var tableView: UITableView!

	private var stories: [String] = []
	private var feeds: [[String: Any]] = []

	override func viewDidLoad() {

		super.viewDidLoad()
		title = "Feed"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.largeTitleDisplayMode = .always
        
		tableView.register(UINib(nibName: "HeaderCell", bundle: Bundle.main), forCellReuseIdentifier: "HeaderCell")
		tableView.register(UINib(nibName: "PostCell", bundle: Bundle.main), forCellReuseIdentifier: "PostCell")
		tableView.tableFooterView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100)))
	}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
	func loadData() {
        
        stories = ["My Profile", "Amy", "Betty", "Chloe", "Doris", "Emma", "Fabia"]
        feeds.removeAll()
        
        let db = Firestore.firestore()
        db.collection("posts").order(by: "date", descending: true).getDocuments() { [weak self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let data = document.data()
                    var dict: [String: Any] = [:]
                    dict["documentId"] = document.documentID
                    dict["name"] = data["displayName"]
                    dict["time"] = data["date"]
                    dict["content"] = data["message"]
                    dict["imageUrl"] = data["imageUrl"]
                    dict["likes"] = "89.4K likes"
                    dict["comments"] = "93 comments"
                    self?.feeds.append(dict)
                }
                self?.refreshTableView()
            }
        }
	}
    
	@IBAction func actionAdd(_ sender: UIButton) {
        let addPostView = AddPostView()
        let controller = NavigationController(rootViewController: addPostView)
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
	}

	func refreshTableView() {
		tableView.reloadData()
	}
}

extension FeedView: UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {

		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return feeds.count
	}
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
        cell.didTapProfile = { [weak self] in
            let accountView = AccountView()
            let controller = NavigationController(rootViewController: accountView)
            self?.present(controller, animated: true)
        }
        cell.bindData(data: stories)
        return cell
    }

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        cell.didTapMore = { [weak self] in
            let controller = PostOptionsView()
            controller.post = self?.feeds[indexPath.row]
            self?.present(controller, animated: true)
        }
        cell.bindData(data: feeds[indexPath.row])
        return cell
	}
}

extension FeedView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 140
    }

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = PostView()
        controller.post = self.feeds[indexPath.row]
        present(controller, animated: true)
	}
}
