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

//-----------------------------------------------------------------------------------------------------------------------------------------------
class AccountView: UIViewController {

	@IBOutlet var imageProfile: UIImageView!
	@IBOutlet var tableView: UITableView!

	@IBOutlet var cellLogout: UITableViewCell!

	@IBOutlet var labelLanguage: UILabel!

	//-------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.largeTitleDisplayMode = .never

		loadData()
	}

	// MARK: - Data methods
	//-------------------------------------------------------------------------------------------------------------------------------------------
	func loadData() {
		imageProfile.sample("Social", "Friendships", 17)
	}

	// MARK: - User actions
	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionFriends(_ sender: UIButton) {

		print(#function)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionGroups(_ sender: UIButton) {

		print(#function)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionEvents(_ sender: UIButton) {

		print(#function)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionPhotos(_ sender: UIButton) {

		print(#function)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionPlaces(_ sender: UIButton) {

		print(#function)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionLiveVideo(_ sender: UIButton) {

		print(#function)
	}
}

// MARK: - UITableViewDataSource
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension AccountView: UITableViewDataSource {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func numberOfSections(in tableView: UITableView) -> Int {

		return 1
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellLogout
	}
}

// MARK: - UITableViewDelegate
//-----------------------------------------------------------------------------------------------------------------------------------------------
extension AccountView: UITableViewDelegate {

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            try Auth.auth().signOut()
        } catch {
            
        }
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

		cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

		return 45
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

		if (section == 1) { return 10 }
		return 0.01
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

		if (section == 1) { return "" }
		return nil
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

		if let header = view as? UITableViewHeaderFooterView {
			header.contentView.backgroundColor = .tertiarySystemFill
		}
	}

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {

		return 0.01
	}
}
