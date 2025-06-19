;; Billing Generation Contract
;; Generates utility bills based on usage calculations

(define-map utility-bills
  { customer: principal, bill-id: uint }
  {
    company-id: uint,
    billing-period: uint,
    usage-amount: uint,
    total-amount: uint,
    due-date: uint,
    status: (string-ascii 20),
    generated-date: uint
  }
)

(define-data-var next-bill-id uint u1)

;; Generate bill for customer
(define-public (generate-bill (customer principal) (company-id uint) (billing-period uint) (usage-amount uint) (total-amount uint) (days-until-due uint))
  (let (
    (bill-id (var-get next-bill-id))
    (due-date (+ block-height days-until-due))
  )
    (map-set utility-bills
      { customer: customer, bill-id: bill-id }
      {
        company-id: company-id,
        billing-period: billing-period,
        usage-amount: usage-amount,
        total-amount: total-amount,
        due-date: due-date,
        status: "pending",
        generated-date: block-height
      }
    )
    (var-set next-bill-id (+ bill-id u1))
    (ok bill-id)
  )
)

;; Update bill status
(define-public (update-bill-status (customer principal) (bill-id uint) (new-status (string-ascii 20)))
  (match (map-get? utility-bills { customer: customer, bill-id: bill-id })
    bill-data
    (begin
      (map-set utility-bills
        { customer: customer, bill-id: bill-id }
        (merge bill-data { status: new-status })
      )
      (ok true)
    )
    (err u404)
  )
)

;; Get bill information
(define-read-only (get-bill (customer principal) (bill-id uint))
  (map-get? utility-bills { customer: customer, bill-id: bill-id })
)

;; Check if bill is overdue
(define-read-only (is-bill-overdue (customer principal) (bill-id uint))
  (match (map-get? utility-bills { customer: customer, bill-id: bill-id })
    bill-data
    (and
      (is-eq (get status bill-data) "pending")
      (> block-height (get due-date bill-data))
    )
    false
  )
)
