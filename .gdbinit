# TUI mode (layout asm shows assembly, layout split shows both)
layout src
# Make the command window 5 lines more
winheight cmd +5
# Specify the file to save gdb history
set history filename ~/.gdb_history
# Set history saving on
set history save on
# Allow us to use ! to use history expansion
set history expansion on
# Set the input radix to be decimal, and output to hex
set input-radix 10
set output-radix 16

#show radix
#p (print)
# use display to permantly show a variable
# $ display var
# $ delete display var
