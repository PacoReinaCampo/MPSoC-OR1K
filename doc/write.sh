rm -f *.tex
rm -f *.pdf

pandoc BOOK.md -s -o MPSoC-OR1K.tex
pandoc BOOK.md -s -o MPSoC-OR1K.pdf
