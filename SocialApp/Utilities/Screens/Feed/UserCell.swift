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

class UserCell: UICollectionViewCell {
	@IBOutlet var imageViewProfile: UIImageView!
	@IBOutlet var labelName: UILabel!
    @IBOutlet weak var contentBackgroundView: UIView!
    
    func bindData(index: Int, data: User) {
        imageViewProfile.sd_setImage(with: data.profileImageUrl, placeholderImage: UIImage(named: "logo"))
        labelName.text = index == 0 ? "My Profile" : data.firstName
        contentBackgroundView.backgroundColor = index == 0 ? AppColor.Border : AppColor.Gradient
	}
}
