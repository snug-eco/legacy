(variable (iden) @variable) 
(string) @string
(number) @number


(param_name (iden) @parameter)
(rout_name  (iden) @function)
(label      (iden) @label)

(seq_name)         @type
(seq_entry  (iden) @constant)

(char_literal) @string

"iter"    @keyword
"count"   @keyword
"enum"    @keyword


"rout"    @keyword
"seq"     @keyword
"put"     @keyword
"sub"     @keyword
"lab"     @keyword
"jump"    @keyword
"trans"   @keyword
"pers"    @keyword
"debug"   @keyword
"write"   @keyword
"void"    @keyword
"defer"   @keyword

"use"     @include


"+"   @operator
"-"   @operator
"="   @operator
"."   @operator
"*"   @operator
"&"   @operator
"&&"  @operator
"|"   @operator
"||"  @operator
"+="  @operator
"-="  @operator
"=+"  @operator
"=-"  @operator

">"   @conditional
"<"   @conditional
"<="  @conditional
">="  @conditional
"=="  @conditional
"!="  @conditional


(key_in) @keyword
(key_out) @keyword

(eos)  @punctuation
","    @punctuation 
"@"    @punctuation 
".."   @punctuation 
(bind) @punctuation
(comment) @comment @spell
