=begin
Ruby has two ways of adding comments to source code, one of which you’ll use, 
and the other you’ll almost certainly not use. The common one is the # symbol—anything after 
that symbol until the end of the line is a comment and is ignored by the interpreter. 
If the next line continues the comment, it needs its own # symbol.

Ruby also has a rarely used multiline comment, 
where the first line starts with =begin and everything is a comment until the code 
reaches =end. Both the =begin and =end must be at the very beginning of the line, 
they cannot be indented.
=end