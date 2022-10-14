# 100 days Cairo

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
**Cairo playground**

- 05_variables
  - `let`, `tempvar` and `local`: `let` creates lot of temporary variables


## day 3
**Cairo playground**

### 06_revoke_references
To be honest have little idea what happend
- this will not give error

```rust
func main{output_ptr: felt*}() {
    let (x) = foo(10);
    let (y) = foo(5);
    return ();
}
```

- But adding `serialize_word(x + y);` will give error

```rust
func main{output_ptr: felt*}() {
    let (x) = foo(10);
    let (y) = foo(5);
    serialize_word(x + y);
    return ();
}
```

- 2 ways to fix error:
  - `alloc_locals;`
  - `ap += SIZEOF_LOCALS; let (local x) = foo(10); let (local y) = foo(5);`

- **Local variables are not revoked when functions are called**

- Read more about local variables [here](https://www.cairo-lang.org/docs/how_cairo_works/consts.html#local-vars)


### 07_dynamic_allocation

- [segments](https://www.cairo-lang.org/docs/how_cairo_works/segments.html) mechanism
- Thanks to this mechanism, `alloc` allocates an array of an arbitrary size, which does not need to be specified in the call.

```rust
func sqr_array(array: felt*, length: felt) -> (new_array: felt*) {
    alloc_locals;

    // allocate new memory slot for new_array
    let (local new_array) = alloc();

    // calculate the new_array by the helper function _inner_sqr_array
    // this function does return anything
    _inner_sqr_array(array=array, new_array=new_array, length=length);
    return (new_array=new_array);
}
```

## day 4
**Cairo playground**

### 08_recursion

### 09_field_elements

### 10_field_elements_02

Just totally random thought, play with `output_ptr` by `serialize_word`

### 11_bitwise_operations

## day 5
**Cairo playground**

### 12_address_of_locals

```rust
let (__fp__, _) = get_fp_and_pc(); // need this to work
local x: felt;

local y: felt* = &x; // y is a pointer at position of felt x
assert [y] = 1234;
```

### 13_struct

- Implementation of a stack using a linked list.
  - Remind of CS50 C lession, linked list element contains  (next: pointer*, value, size)

- To turn memory address into a pointer we have to use the & operator. 
- By default the compiler wouldn’t know what type of pointer this is so to inform it of the type we have to use the function `cast` and provide the type as the second argument

- `new_node.next = cast(0, Node*);`: pointer to the 1st Node struct

### 14_pedersen_hash
- implements a Pedersen hash chain.

### 15_hints
