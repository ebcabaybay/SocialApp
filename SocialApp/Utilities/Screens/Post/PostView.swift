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
import FirebaseStorageUI

class PostView: UIViewController {

	@IBOutlet var imagePost: UIImageView!
	@IBOutlet var imageUser: UIImageView!
	@IBOutlet var labelUser: UILabel!
	@IBOutlet var labelTime: UILabel!
	@IBOutlet var labelDescription: UILabel!
	@IBOutlet var layoutConstraintDescriptionHeight: NSLayoutConstraint!

    var post: Post?

	override func viewDidLoad() {
		super.viewDidLoad()
		loadData()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if let navController = navigationController as? NavigationController {
			navController.setBackground(color: .clear)
		}
	}

	override func viewWillDisappear(_ animated: Bool) {

		super.viewWillDisappear(animated)
		if let navController = navigationController as? NavigationController {
			navController.setNavigationBar()
		}
	}

	func loadData() {
        let imageUrl = post?.imageUrl
        if let imageUrl = imageUrl {
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let imageRef = storageRef.child(imageUrl.absoluteString)
            imagePost.sd_setImage(with: imageRef)
        }
        
        imageUser.sd_setImage(with: post?.user.profileImageUrl, placeholderImage: UIImage(named: "logo"))
        labelUser.text = post?.user.name
        labelTime.text = post?.timestamp
        labelDescription.text = post?.message

		if let descriptiontHeight = labelDescription.text?.height(withConstrainedWidth: labelDescription.frame.size.width, font: UIFont.systemFont(ofSize: 16)) {
			layoutConstraintDescriptionHeight.constant = descriptiontHeight
		}

	}
}
