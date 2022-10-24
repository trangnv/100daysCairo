# from starkware.starknet.public.abi import get_storage_var_address

# my_key = get_storage_var_address("values_mapped_secret_storage", 12)
# print(f"My key: {my_key}")

from starkware.starknet.compiler.compile import get_selector_from_name

print(get_selector_from_name("handle_deposit"))
# => 1285101517810983806491589552491143496277809242732141897358598292095611420389


# DEPOSIT_HANDLER = 1285101517810983806491589552491143496277809242732141897358598292095611420389;
# The selector of the "handle_deposit" l1_handler on L2.

# INDEX_UPDATE_HANDLER = 309177621854413231845513563663819170511421561802461396722380275428414897390; //
# The selector of the "handle_index_update" l1_handler on L2.
