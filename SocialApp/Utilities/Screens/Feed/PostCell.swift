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
import FirebaseStorage

class PostCell: UITableViewCell {

	@IBOutlet var imageViewProfile: UIImageView!
	@IBOutlet var labelName: UILabel!
	@IBOutlet var labelTime: UILabel!
	@IBOutlet var labelContent: UILabel!
	@IBOutlet var layoutConstraintContentHeight: NSLayoutConstraint!

    @IBOutlet weak var postImageView: UIImageView!
    
    var didTapMore: (() -> Void)?

    func bindData(post: Post) {
        let name = post.user.name
        // convert time stamp to string
        let time = post.timestamp
        let content = post.message
        let imageUrl = post.imageUrl
        
        imageViewProfile.sd_setImage(with: post.user.profileImageUrl, placeholderImage: UIImage(named: "logo"))
        labelName.text = name
        labelTime.text = time
        labelContent.text = content
        if let imageUrl = imageUrl {
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let imageRef = storageRef.child(imageUrl.absoluteString)
            postImageView.isHidden = false
            postImageView.sd_setImage(with: imageRef)
        } else {
            postImageView.isHidden = true
        }
        
        if content?.isEmpty ?? true {
            layoutConstraintContentHeight.constant = 0
        } else {
            if let descriptionHeight = labelContent.text?.height(withConstrainedWidth: labelContent.frame.size.width, font: UIFont.boldSystemFont(ofSize: 24)) {
                layoutConstraintContentHeight.constant = descriptionHeight
            }
        }
	}
    
    @IBAction func didTapMoreButton(_ sender: Any) {
        didTapMore?()
    }
}
