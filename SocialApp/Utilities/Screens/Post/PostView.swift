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
    var viewModel = PostViewModel()
    
	@IBOutlet var imagePost: UIImageView!
	@IBOutlet var imageUser: UIImageView!
	@IBOutlet var labelUser: UILabel!
	@IBOutlet var labelTime: UILabel!
	@IBOutlet var labelDescription: UILabel!
	@IBOutlet var layoutConstraintDescriptionHeight: NSLayoutConstraint!

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}

	func setup() {
        imageUser.sd_setImage(with: viewModel.imageUserUrl, placeholderImage: UIImage(named: "logo"))
        labelUser.text = viewModel.name
        labelTime.text = viewModel.timestamp
        labelDescription.text = viewModel.message
        if let imagePostRef = viewModel.imagePostRef {
            imagePost.sd_setImage(with: imagePostRef)
        }
        if let descriptiontHeight = labelDescription.text?.height(withConstrainedWidth: labelDescription.frame.size.width, font: UIFont.systemFont(ofSize: 16)) {
            layoutConstraintDescriptionHeight.constant = descriptiontHeight
        }
	}
}
