# 100 days Cairo

###### tags: `100daysCairo`

## day 1
Hi gang, 
I'm trying to solve day 13 of the 17 days of the Cairo Challenge: Pedersen Hash
This is my solution so far

```rust
// Computes the Pedersen hash chain on an array of size `length` starting from `data_ptr`.
func hash_chain{hash_ptr: HashBuiltin*}(data_ptr: felt*, length: felt) -> (result: felt) {
    if (length == 2) {
        let (result) = hash2(x=[data_ptr], y=[data_ptr + 1]);
        return (result=result);
    } else {
        // Fix here:
        let x_n: felt = data_ptr[length];
        result = hash2(hash_chain(data_ptr, length - 1), x_n);
        return (result=result);
    }
}
```

And I got revoked and I have no idea what's going on. Can anyone please explain? TIA 
```bash
Error: code:29:9: Reference 'result' was revoked.
        result = hash2(tmp, x_n);
        ^****^
```
Feel like start in the middle of the ocean.

## day 2
Cairo playground

- 05_variables
  - `let`, `tempvar` and `local`: `let` creates lot of temporary variables


- 06_revoke_references
