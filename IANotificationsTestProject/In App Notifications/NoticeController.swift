import UIKit

class NoticeController {
    private var notices: [Notice] = []
    private let noticePresenter = NoticePresenter()

    private var activeViewIsBeingTouched: Bool = false

    func present(_ notice: Notice) {
        if noticePresenter.isPresenting {
            notices.append(notice)
        } else {
            let noticeView = makeNoticeView(from: notice)

            noticePresenter.presentNoticeView(noticeView) {
                self.dismiss(noticeView)
            }
        }
    }

    func dismiss(_ noticeView: NoticeView) {
        guard !activeViewIsBeingTouched else {
            DispatchQueue.main.asyncAfter(deadline: .now() + Times.tapDelay) {
                self.dismiss(noticeView)
            }
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + Times.tapDelay) {
            self.noticePresenter.dismissNotification {
                if !self.notices.isEmpty {
                    self.present(self.notices.removeFirst())
                }
            }
        }
    }

    private func makeNoticeView(from notice: Notice) -> NoticeView {
        let noticeView = NoticeView(frame: .zero)
        noticeView.noticeLabel.text = notice.message
        noticeView.noticeButton.setTitle(notice.action?.title, for: .normal)
        noticeView.action = notice.action?.handler
        noticeView.delegate = self

        return noticeView
    }
}

extension NoticeController: NoticePresentingDelegate {
    func noticeTouchBegan() {
        activeViewIsBeingTouched = true
    }

    func noticeTouchEnded() {
        activeViewIsBeingTouched = false
    }
}

private struct Times {
    static let tapDelay = TimeInterval(2)
}

