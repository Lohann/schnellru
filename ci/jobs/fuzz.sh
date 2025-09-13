#!/bin/bash

set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
cd ../..

# https://llvm.org/docs/LibFuzzer.html#options
LIBFUZZ_RUN_ARGS="--verbose --jobs=$(nproc) -- -runs=10000000 -timeout=5 -print_final_stats=1 -print_pcs=1"

cd fuzz
echo ">> hfuzz fuzz-behavior-matches-lru"
cargo +nightly-2025-06-27 fuzz run fuzz-behavior-matches-lru $LIBFUZZ_RUN_ARGS

echo ">> fuzz-internal-invariants"
cargo +nightly-2025-06-27 fuzz run fuzz-internal-invariants $LIBFUZZ_RUN_ARGS

echo ">> fuzz-by-memory-usage-works"
cargo +nightly-2025-06-27 fuzz run fuzz-by-memory-usage-works $LIBFUZZ_RUN_ARGS

echo "All OK!"
