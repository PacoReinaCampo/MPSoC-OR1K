rm -f *.tex
rm -f *.pdf

pandoc ../README.md -s -o MPSoC-OR1K.tex
pandoc ../README.md -s -o MPSoC-OR1K.pdf
