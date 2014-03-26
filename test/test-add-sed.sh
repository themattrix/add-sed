#!/usr/bin/env bash


#
# Tests
#

function test_roll_over_once() {
    diff_output <(add_sed <<< "9 + 1") <(echo "10")
}

function test_roll_over_twice() {
    diff_output <(add_sed <<< "99 + 01") <(echo "100")
}

function test_roll_over_thrice() {
    diff_output <(add_sed <<< "999 + 001") <(echo "1000")
}

function test_smaller_left_works() {
    diff_output <(add_sed <<< "1 + 999") <(echo "1000")
}

function test_smaller_right_works() {
    diff_output <(add_sed <<< "999 + 1") <(echo "1000")
}

function test_range() {
    local range_x=111
    local range_y=11

    diff_output <(
        for ((x = 0; x <= "${range_x}"; x++)); do
            for ((y = 0; y <= "${range_y}"; y++)); do
                echo "${x} + ${y}"
                echo "${y} + ${x}"
            done
        done | add_sed
    ) <(
        for ((x = 0; x <= "${range_x}"; x++)); do
            for ((y = 0; y <= "${range_y}"; y++)); do
                echo "$((x + y))"
                echo "$((x + y))"
            done
        done
    )
}


#
# Test helpers
#

readonly THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function add_sed() {
    "${THIS_DIR}/../src/add.sed"
}

function diff_output() {
    diff -y --width=20 --suppress-common-lines "$@"
}

function run() {
    test_fn="$1"

    output=$("${test_fn}" 2>&1)
    status=$?

    ((test_count++))

    if [ ${status} -eq 0 ]
    then
        echo "[pass] ${test_fn}"
    else
        ((fail_count++))

        echo "[FAIL] ${test_fn}:"
        sed 's/^/    /' <<< "${output}"
        echo
    fi
}

function test_summary() {
    echo
    if [ ${fail_count} -eq 0 ]
    then
        echo ">>> success (${test_count} tests)"
    else
        echo ">>> FAILURE (${fail_count}/${test_count} tests failed)"
        exit 1
    fi
}


#
# Test runner
#

test_count=0
fail_count=0

run test_roll_over_once
run test_roll_over_twice
run test_roll_over_thrice
run test_smaller_left_works
run test_smaller_right_works
run test_range

test_summary
