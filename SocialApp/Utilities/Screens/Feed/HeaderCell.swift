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

//-----------------------------------------------------------------------------------------------------------------------------------------------
class HeaderCell: UITableViewCell {

	@IBOutlet var collectionView: UICollectionView!

	private var users: [User] = []

    var didTapProfile: (() -> Void)?
	
	override func awakeFromNib() {

		super.awakeFromNib()

		collectionView.register(UINib(nibName: "MyProfileCell", bundle: Bundle.main), forCellWithReuseIdentifier: "MyProfileCell")
		collectionView.register(UINib(nibName: "UserCell", bundle: Bundle.main), forCellWithReuseIdentifier: "UserCell")
	}

	func bindData(data: [User]) {
		users = data
		refreshCollectionView()
	}

	func refreshCollectionView() {
		collectionView.reloadData()
	}
}

extension HeaderCell: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {

		return 1
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		return users.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCell", for: indexPath) as! UserCell
			cell.bindData(index: indexPath.item, data: users[indexPath.row])
			return cell
	}
}

extension HeaderCell: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if (indexPath.row == 0) {
            didTapProfile?()
        }
    
		print("didSelectItemAt \(indexPath.row)")
	}
}

extension HeaderCell: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		let height = (collectionView.frame.size.height-30)
		return CGSize(width: 85, height: height)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

		return 10
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

		return 10
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

		return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
	}
}