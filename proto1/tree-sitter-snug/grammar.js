/**
 * @file Parser for the Snug programming language
 * @author S1monr3dst0ne07
 * @license MIT
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-nocheck

module.exports = grammar({
  name: "snug",

  rules: {
    source_file: $ => repeat($.unit),
    unit: $ => choice(
      $.import,
      $.sequence,
      $.routine,
      $.comment
    ),


    comment: $ => /".+?\n/,

    import: $ => seq('use', $.string, $.eos),

    sequence: $ => seq(
      'seq', 
      $.seq_name, 
      $.open_scope, 
      repeat(seq(
        $.seq_entry, 
        optional(','),
        optional($.comment),
      )),
      $.close_scope,
    ),

    routine: $ => seq(
      'rout',
      $.rout_name,
      optional($.param_interface),
      $.tree
    ),

    tree: $ => seq(
      $.open_scope,
      repeat($.statement),
      $.close_scope,
    ),

    param_interface: $ => seq(
      '(', repeat($.param_def), ')',
    ),

    param_def: $ => seq(
      choice($.key_in, $.key_out),
      $.param_name,
      $.eos,
    ),

    param_name: $ => $.iden,
    rout_name:  $ => $.iden,
    seq_name:   $ => /[A-Z][A-Za-z:]*/,
    seq_entry:  $ => $.iden,



    statement: $ => choice(seq(
      choice( //eos terminated
        $.put,
        $.debug,
        $.trans,
        $.pers,
        $.sub,
        $.lab,
        $.jump,
        $.write,
        $.void,
      ), $.eos, ),
      choice( //non terminated
        $.iter,
        $.enum,
        $.count,
        $.defer,
      ),
      $.comment
    ),

    put:   $ => seq('put', $.expr, '=', $.expr),
    debug: $ => seq('debug', $.expr),
    trans: $ => seq('trans', $.expr, $.bind, $.expr),
    pers:  $ => seq('pers', $.expr, $.bind, $.expr),
    sub:   $ => seq(
      'sub', 
      $.rout_name, 
      '(',
      repeat(seq(
        $.param_name, 
        optional(seq(
          $.bind, 
          $.expr, 
        )),
        optional(',')
      )),
      ')'
    ),
    lab:  $ => seq('lab',  optional($.label)),
    jump: $ => seq('jump', optional($.label), 
      optional(seq($.bind, $.expr))
    ),
    write: $ => seq('write', $.expr),
    void: $ => seq('void', $.expr),

    //loops
    iter:  $ => seq('iter',  $.expr,              $.bind,               $.expr, $.tree),
    enum:  $ => seq('enum',  $.expr, '@', $.expr, $.bind,               $.expr, $.tree),
    count: $ => seq('count', $.expr,              $.bind, $.expr, '..', $.expr, $.tree),

    defer: $ => seq('defer', $.statement),

    expr: $ => choice(
      field("content", $.number),
      field("content", $.variable),
      field("content", $.string),
      field("content", $.char_literal),
      field("content", $.seq_name),
      $.binary,
      $.paran,
    ),
    binary: $ => prec.left(seq(
      field("left", $.expr),
      field("op", $.op),
      field("right", $.expr)
    )),
    paran: $ => seq('(', $.expr, ')'),

    op: $ => choice('+', '-', '*', '>', '<', '.', '||', '&&', '|', '&', '>=', '<=', '==', '!=', '+=', '-=', '=+', '=-'),

    label: $ => $.iden,
    variable: $ => $.iden,

    string: $ => seq('\'', $.string_content, '\''),
    string_content: $ => repeat1(choice(
        $.string_literal,
        $.string_format,
    )),
    string_literal: $ => /[^'{}]+/,
    string_format : $ => seq('{', optional('`'), $.string_format_content, '}'),
    string_format_content: $ => seq($.variable, optional(seq('.', $.variable))),

    char_literal: $ => /`./,

    key_in:  $ => 'in',
    key_out: $ => 'out',
    eos: $ => ';',
    bind: $ => '~',
    open_scope:  $ => "{",
    close_scope: $ => "}",
    iden: $ => /[A-Za-z:_]+/,
    number: $ => /\d+/,
  }
});
