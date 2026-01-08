# The 1st Snug prototype
The (prototype) Snug Programming Language

## Overview
Snug compiles down to a stack-based IR.
Transient objects may also be allocated on the stack,
which will be treated identically to heap-allocated persistent objects.
Data on the stack is packed without align, being the namesake of the language,
as the objects are packed 'snuggly'.
Variable are untyped and inferred at compile-time, without declaration.
When calling routines, parameters may be provided, through binding to their names.

## Directory Structure

- **compiler**: prototype compiler implementation in python
- **docs**: compiler internal documentation
- **lib**: snug library files
- **mockup**: mockup test programs for iterating language design
- **prg**: snug program files
- **vm.py**: virtual machine for executing snug IR

