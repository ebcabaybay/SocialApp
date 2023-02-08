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
    let viewModel = FeedViewModel()
    
	@IBOutlet var tableView: UITableView!
    
	override func viewDidLoad() {
		super.viewDidLoad()
		initUI()
        initBinding()
	}
    
    func initUI() {
        title = "Feed"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        tableView.register(UINib(nibName: "HeaderCell", bundle: Bundle.main), forCellReuseIdentifier: "HeaderCell")
        tableView.register(UINib(nibName: "PostCell", bundle: Bundle.main), forCellReuseIdentifier: "PostCell")
        tableView.tableFooterView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100)))
    }
    
    func initBinding() {
        viewModel.posts.addObserver { [weak self] _ in
            self?.refreshTableView()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MessageHandler.hideLoading()
        loadData()
    }
    
	func loadData() {
        viewModel.getPosts()
	}
    
	@IBAction func actionAdd(_ sender: UIButton) {
        let addPostView = AddPostView()
        addPostView.viewModel.user = viewModel.user
        let controller = NavigationController(rootViewController: addPostView)
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
        return viewModel.posts.value.count
	}
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
        cell.didTapProfile = { [weak self] in
            let accountView = AccountView()
            accountView.viewModel.user = self?.viewModel.user
            let controller = NavigationController(rootViewController: accountView)
            self?.present(controller, animated: true)
        }
        cell.viewModel.users.value = viewModel.users
        return cell
    }

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.viewModel.user = viewModel.user
        cell.viewModel.post = viewModel.posts.value[indexPath.row]
        cell.didTapMore = { [weak self] in
            let controller = PostOptionsView()
            controller.viewModel.post = self?.viewModel.posts.value[indexPath.row]
            self?.present(controller, animated: true)
        }
        cell.setup()
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
        controller.viewModel.post = viewModel.posts.value[indexPath.row]
        present(controller, animated: true)
	}
}
