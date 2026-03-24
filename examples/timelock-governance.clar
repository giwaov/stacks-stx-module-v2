;; Timelock governance

(define-data-var delay-blocks uint u144)
(define-map queued-actions uint { proposer: principal, execute-after: uint })
(define-data-var action-nonce uint u0)

(define-public (queue-action (action-id uint))
  (let ((nonce (var-get action-nonce)))
    (map-set queued-actions nonce
      { proposer: tx-sender, execute-after: (+ block-height (var-get delay-blocks)) })
    (var-set action-nonce (+ nonce u1))
    (ok nonce)))

(define-public (execute-action (nonce uint))
  (let ((action (unwrap! (map-get? queued-actions nonce) (err u1))))
    (asserts! (>= block-height (get execute-after action)) (err u5))
    (asserts! (is-eq tx-sender (get proposer action)) (err u401))
    (map-delete queued-actions nonce)
    (ok true)))
