// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE
// TIP: To test this file alone, run:
// TIP:   bazel test //toolchain/testing:file_test --test_arg=--file_tests=toolchain/lex/testdata/string_literals.carbon
// TIP: To dump output, run:
// TIP:   bazel run //toolchain/testing:file_test -- --dump_output --file_tests=toolchain/lex/testdata/string_literals.carbon

// --- fail_decimal_escape.carbon
// CHECK:STDOUT: - filename: fail_decimal_escape.carbon
// CHECK:STDOUT:   tokens:

// CHECK:STDERR: fail_decimal_escape.carbon:[[@LINE+4]]:4: error: decimal digit follows `\0` escape sequence. Use `\x00` instead of `\0` if the next character is a digit [DecimalEscapeSequence]
// CHECK:STDERR: "\01"
// CHECK:STDERR:    ^
// CHECK:STDERR:
"\01"
// CHECK:STDOUT:   - { index: 1, kind: 'StringLiteral', line: {{ *}}[[@LINE-1]], column: 1, indent: 1, spelling: '"\01"', value: ` 1`, has_leading_space: true }

// --- fail_unterminated.carbon
// CHECK:STDOUT: - filename: fail_unterminated.carbon
// CHECK:STDOUT:   tokens:

// CHECK:STDERR: fail_unterminated.carbon:[[@LINE+4]]:1: error: string is missing a terminator [UnterminatedString]
// CHECK:STDERR: "s
// CHECK:STDERR: ^
// CHECK:STDERR:
"s
// CHECK:STDOUT:   - { index: 1, kind:     'Error', line: {{ *}}[[@LINE-1]], column: 1, indent: 1, spelling: '"s', has_leading_space: true }


// --- fail_unknown_escape.carbon
// CHECK:STDOUT: - filename: fail_unknown_escape.carbon
// CHECK:STDOUT:   tokens:

// CHECK:STDERR: fail_unknown_escape.carbon:[[@LINE+4]]:3: error: unrecognized escape sequence `w` [UnknownEscapeSequence]
// CHECK:STDERR: "\w"
// CHECK:STDERR:   ^
// CHECK:STDERR:
"\w"
// CHECK:STDOUT:   - { index: 1, kind: 'StringLiteral', line: {{ *}}[[@LINE-1]], column: 1, indent: 1, spelling: '"\w"', value: `w`, has_leading_space: true }

// --- fail_unicode_escape_missing_braced_digits.carbon
// CHECK:STDOUT: - filename: fail_unicode_escape_missing_braced_digits.carbon
// CHECK:STDOUT:   tokens:

// CHECK:STDERR: fail_unicode_escape_missing_braced_digits.carbon:[[@LINE+3]]:4: error: escape sequence `\u` must be followed by a braced sequence of uppercase hexadecimal digits, for example `\u{70AD}}` [UnicodeEscapeMissingBracedDigits]
// CHECK:STDERR: "\u"
// CHECK:STDERR:    ^
"\u"
// CHECK:STDOUT:   - { index: 1, kind: 'StringLiteral', line: {{ *}}[[@LINE-1]], column:   1, indent: 1, spelling: '"\u"', value: `u`, has_leading_space: true }
