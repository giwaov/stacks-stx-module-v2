# STX Module v2

## New Modules

### Reentrancy Guard
Prevents reentrancy attacks.
```clarity
(define-data-var reentrancy-locked bool false)
(define-private (lock-guard)
  (begin
    (asserts! (not (var-get reentrancy-locked)) (err u100))
    (var-set reentrancy-locked true)
    (ok true)))
```

### Multi-Sig
Multiple signatures for critical ops.

### Timelock
Time delays for sensitive operations.

### Emergency Stop
Circuit breaker pattern.
