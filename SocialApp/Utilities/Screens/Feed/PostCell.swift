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

class PostCell: UITableViewCell {
    let viewModel = PostViewCellModel()
    
	@IBOutlet var imageViewProfile: UIImageView!
	@IBOutlet var labelName: UILabel!
	@IBOutlet var labelTime: UILabel!
	@IBOutlet var labelContent: UILabel!
	@IBOutlet var layoutConstraintContentHeight: NSLayoutConstraint!

    @IBOutlet weak var buttonMore: UIButton!
    @IBOutlet weak var postImageView: UIImageView!
    
    var didTapMore: (() -> Void)?
    
    func setup() {
        buttonMore.isHidden = !viewModel.isPostDeletable
        imageViewProfile.sd_setImage(with: viewModel.imageProfileUrl, placeholderImage: UIImage(named: "logo"))
        labelName.text = viewModel.name
        labelTime.text = viewModel.timestamp
        labelContent.text = viewModel.message
        if let imagePostRef = viewModel.imagePostRef {
            postImageView.isHidden = false
            postImageView.sd_setImage(with: imagePostRef)
        } else {
            postImageView.isHidden = true
        }
        
        if viewModel.message?.isEmpty ?? true {
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
