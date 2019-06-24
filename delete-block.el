;;; delete-block.el --- Delete block effectively

;; Filename: delete-block.el
;; Description: Delete block effectively
;; Author: Andy Stewart <lazycat.manatee@gmail.com>
;; Maintainer: Andy Stewart <lazycat.manatee@gmail.com>
;; Copyright (C) 2019, Andy Stewart, all rights reserved.
;; Created: 2019-06-22 16:45:58
;; Version: 0.2
;; Last-Updated: 2019-06-24 20:21:16
;;           By: Andy Stewart
;; URL: http://www.emacswiki.org/emacs/download/delete-block.el
;; Keywords:
;; Compatibility: GNU Emacs 26.1.92
;;
;; Features that might be required by this library:
;;
;; `subword'
;;

;;; This file is NOT part of GNU Emacs

;;; License
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; Delete block effectively
;;
;; We can use `skip-syntax-forward' or `skip-syntax-backward' as word movement to delete block.
;; But `skip-syntax-*' unable to handle camel-style word movement,
;; such as just delete `Foo' part in `FooBar' word.
;;
;; So this plugins mix `skip-syntax-*' and `subword-mode' for better delete block experience.
;;

;;; Installation:
;;
;; Put delete-block.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'delete-block)
;;
;; No need more.

;;; Customize:
;;
;;
;;
;; All of the above can customize by:
;;      M-x customize-group RET delete-block RET
;;

;;; Change log:
;;
;; 2019/06/24
;;      * Fix bug that subword movement can't work `subword-mode' is disable.
;;
;; 2019/06/22
;;      * First released.
;;

;;; Acknowledgements:
;;
;;
;;

;;; TODO
;;
;;
;;

;;; Require
(require 'subword)

;;; Code:

(defun delete-block-forward ()
  (interactive)
  (if (eobp)
      (message "End of buffer")
    (let* ((syntax-move-point
            (save-excursion
              (skip-syntax-forward (string (char-syntax (char-after))))
              (point)
              ))
           (subword-move-point
            (save-excursion
              (subword-forward)
              (point))))
      (kill-region (point) (min syntax-move-point subword-move-point)))))

(defun delete-block-backward ()
  (interactive)
  (if (bobp)
      (message "Beginning of buffer")
    (let* ((syntax-move-point
            (save-excursion
              (skip-syntax-backward (string (char-syntax (char-before))))
              (point)
              ))
           (subword-move-point
            (save-excursion
              (subword-backward)
              (point))))
      (kill-region (point) (max syntax-move-point subword-move-point)))))

(provide 'delete-block)

;;; delete-block.el ends here
