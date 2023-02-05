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

//-----------------------------------------------------------------------------------------------------------------------------------------------
class Feed1Cell6: UICollectionViewCell {

	@IBOutlet var imageViewContent: UIImageView!
	@IBOutlet var viewMoreImages: UIView!
	@IBOutlet var labelImageCount: UILabel!

	//-------------------------------------------------------------------------------------------------------------------------------------------
	func bindData(index: Int, imageUrl: URL?) {

		imageViewContent.sample("Social", "Party", index)
//		if index == 2 {
//			viewMoreImages.isHidden = false
//			labelImageCount.text = "+\(data)"
//		}
//		else {
			viewMoreImages.isHidden = true
            imageViewContent.sd_setImage(with: imageUrl)
//		}
	}
}
