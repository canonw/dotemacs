;; https://truongtx.me/2014/08/23/setup-emacs-as-an-sql-database-client/
(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (toggle-truncate-lines t)))

;;;; Sample server list
;; Multiple servers setup sample
;; (setq sql-connection-alist
;;      '((server1 (sql-product 'postgres)
;;                  (sql-port 5432)
;;                  (sql-server "localhost")
;;                  (sql-user "user")
;;                  (sql-password "password")
;;                  (sql-database "db1"))
;;        (server2 (sql-product 'postgres)
;;                  (sql-port 5432)
;;                  (sql-server "localhost")
;;                  (sql-user "user")
;;                  (sql-password "password")
;;                  (sql-database "db2"))))


;; Call pre-set sql connection configuration.  It's prefer to define them in ~/init-setting.el
(defun my-sql-connect (product connection)
  ;; remember to set the sql-product, otherwise, it will fail for the first time
  (setq sql-product product)
  (sql-connect connection))


;;;; Sample server call function
;; (defun my-sql-server1 ()
;;   (interactive)
;;   (my-sql-connect 'postgres 'server1))

(provide 'init-sql)
