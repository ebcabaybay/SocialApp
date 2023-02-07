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

class FeedView: UIViewController {
    var user: User!
    
	@IBOutlet var tableView: UITableView!
    
	private var posts: [Post] = []
    private var users: [User] {
        var users = Array(Set(posts.map { $0.user }))
        users.removeAll { $0.id == user.id }
        return [user] + users
    }
    
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
        MessageHandler.hideLoading()
        super.viewWillAppear(animated)
        loadData()
    }
    
	func loadData() {
        PostApiService.getPosts.request { [weak self] (result: Result<[Post]>) in
            switch result {
                case .success(let posts):
                    self?.posts = posts
                    self?.refreshTableView()
                case .failure(let error):
                    print(error)
            }
        }
	}
    
	@IBAction func actionAdd(_ sender: UIButton) {
        let addPostView = AddPostView()
        addPostView.user = user
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

        return posts.count
	}
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
        cell.didTapProfile = { [weak self] in
            let accountView = AccountView()
            accountView.user = self?.user
            let controller = NavigationController(rootViewController: accountView)
            self?.present(controller, animated: true)
        }
        cell.bindData(data: users)
        return cell
    }

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        cell.didTapMore = { [weak self] in
            let controller = PostOptionsView()
            controller.post = self?.posts[indexPath.row]
            self?.present(controller, animated: true)
        }
        cell.user = user
        cell.bindData(post: posts[indexPath.row])
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
        controller.viewModel.post = self.posts[indexPath.row]
        present(controller, animated: true)
	}
}
