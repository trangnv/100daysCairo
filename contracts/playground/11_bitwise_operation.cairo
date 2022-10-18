// The bitwise builtin allows you to perform bitwise operations
// (and, or, xor) on integers up to 251 bits.
//
// The following code implements the function xor_last_hex_digits,
// which takes the two last hexadecimal digits and "xor"s them.
// For example, in 0x1234 the last two digits are 3 and 4,
// and their xor is 3^4=7.
//
// Fix the missing code and make sure it works.

%builtins output bitwise

from starkware.cairo.common.bitwise import bitwise_and, bitwise_xor
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin
from starkware.cairo.common.serialize import serialize_word


// Returns the xor of the last two hexadecimal digits.
func xor_last_hex_digits{output_ptr: felt*, bitwise_ptr: BitwiseBuiltin*}(x: felt) -> (res: felt) {
    // Fix and uncomment the line below.
    let (digit0) = bitwise_and(x, 0xF); // with x = 0x1234, return 4
    serialize_word(digit0);

    let (shifted_digit1) = bitwise_and(x, 0xF0);
    serialize_word(shifted_digit1); //48 integer => 30 hex

    tempvar digit1 = shifted_digit1 / 0x10;
    serialize_word(digit1);

    let (res) = bitwise_xor(digit0, digit1);
    return (res=res);
}

func main{output_ptr: felt*, bitwise_ptr: BitwiseBuiltin*}() {
    let (res) = xor_last_hex_digits(0x1234);
    assert res = 7;

    return ();
}
