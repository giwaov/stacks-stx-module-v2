# Migration Guide: v1 to v2

## Breaking Changes
None. v2 is fully backward compatible.

## Adding Reentrancy Guard
```clarity
;; v2 protected function
(define-public (my-function)
  (begin
    (try! (lock-guard))
    ;; Protected logic
    (unlock-guard)
    (ok true)))
```

## Steps
1. Review public functions for reentrancy risks
2. Add guards to functions that transfer STX
3. Add timelocks to admin functions
4. Test on testnet first
