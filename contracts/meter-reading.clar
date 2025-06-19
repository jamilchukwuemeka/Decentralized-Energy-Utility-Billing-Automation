;; Meter Reading Contract
;; Manages smart meter readings and data collection

(define-map meter-readings
  { meter-id: (string-ascii 50), reading-id: uint }
  {
    company-id: uint,
    customer-address: principal,
    reading-value: uint,
    reading-type: (string-ascii 20),
    timestamp: uint,
    verified: bool
  }
)

(define-map customer-meters
  { customer: principal }
  { meter-id: (string-ascii 50), company-id: uint }
)

(define-data-var next-reading-id uint u1)

;; Register a meter for a customer
(define-public (register-meter (customer principal) (meter-id (string-ascii 50)) (company-id uint))
  (begin
    ;; Check if company is verified (would call utility-verification contract)
    (map-set customer-meters
      { customer: customer }
      { meter-id: meter-id, company-id: company-id }
    )
    (ok true)
  )
)

;; Submit meter reading
(define-public (submit-reading (meter-id (string-ascii 50)) (customer-address principal) (company-id uint) (reading-value uint) (reading-type (string-ascii 20)))
  (let ((reading-id (var-get next-reading-id)))
    (map-set meter-readings
      { meter-id: meter-id, reading-id: reading-id }
      {
        company-id: company-id,
        customer-address: customer-address,
        reading-value: reading-value,
        reading-type: reading-type,
        timestamp: block-height,
        verified: false
      }
    )
    (var-set next-reading-id (+ reading-id u1))
    (ok reading-id)
  )
)

;; Verify reading (utility company only)
(define-public (verify-reading (meter-id (string-ascii 50)) (reading-id uint))
  (match (map-get? meter-readings { meter-id: meter-id, reading-id: reading-id })
    reading-data
    (begin
      (map-set meter-readings
        { meter-id: meter-id, reading-id: reading-id }
        (merge reading-data { verified: true })
      )
      (ok true)
    )
    (err u404)
  )
)

;; Get meter reading
(define-read-only (get-reading (meter-id (string-ascii 50)) (reading-id uint))
  (map-get? meter-readings { meter-id: meter-id, reading-id: reading-id })
)

;; Get customer meter info
(define-read-only (get-customer-meter (customer principal))
  (map-get? customer-meters { customer: customer })
)
