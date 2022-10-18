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

- tried this simple recursion but got `revoked`

```bash
Error: code:28:9: Reference 'result' was revoked.
        result = hash2(hash_chain(data_ptr, length - 1), x_n);
        ^****^
```

```rust
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

## day 6
### 15_hints
- The idea is that the verifier only needs to be convinced that res * res = n, it doesn't really care how res was computed.
- In such cases, we don't have to compute res in pure Cairo - we can write a piece of Python code inside the Cairo program, which is called a "hint".
- From the verifier's point of view, the hint is completely transparent.


### 16_SHARP
wtf

### 17_StarkNet_contract

### 18_Cairo_games_example


prover, verifier, sharp, where it goes

## day 7
The `utils.py` is useful for type conversion

```python
MAX_LEN_FELT = 31


def str_to_felt(text):
    if len(text) > MAX_LEN_FELT:
        raise Exception("Text length too long to convert to felt.")

    return int.from_bytes(text.encode(), "big")


def felt_to_str(felt):
    length = (felt.bit_length() + 7) // 8
    return felt.to_bytes(length, byteorder="big").decode("utf-8")


def str_to_felt_array(text):
    return [str_to_felt(text[i:i+MAX_LEN_FELT]) for i in range(0, len(text), MAX_LEN_FELT)]


def uint256_to_int(uint256):
    return uint256[0] + uint256[1]*2**128


def uint256(val):
    return (val & 2**128-1, (val & (2**256-2**128)) >> 128)


def hex_to_felt(val):
    return int(val, 16)

```

```bash
>>> uint256(5)
(5, 0)

>>> uint256_to_int((5,1))
340282366920938463463374607431768211461

>>> uint256(340282366920938463463374607431768211461)
(5, 1)

>>> 2**128
340282366920938463463374607431768211456

>>> uint256(340282366920938463463374607431768211456)
(0, 1) 
```

## day 8
- Dictionary
  - A dictionary is created using the `default_dict_new()` module from the Common Library
  - https://perama-v.github.io/cairo/examples/default_dict/
- Something with a graph that might be well related, [PAKHET Cairo game](https://www.cairo-lang.org/the-cairo-games/puzzles/vol-2-solutions/#pakhet)

## day 9
- `default_dict.cairo`
