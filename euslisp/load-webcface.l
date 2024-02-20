(setq wcf-m (load-foreign "/usr/lib/libwebcface.so"))
(defforeign wcf-init-default wcf-m "wcfInitDefault" (:string) :integer)
(defforeign wcf-sync wcf-m "wcfSync" (:integer) :integer)
(defforeign wcf-value-set wcf-m "wcfValueSet" (:integer :string :float) :integer)
