$pdf_mode = 1;
$pdflatex = 'pdflatex -interaction=nonstopmode -8bit -etex -file-line-error -halt-on-error -synctex=1 %O %S';
$pdf_previewer = "open -a /Applications/Skim.app";
$pdf_update_method = 0;
$clean_ext = "synctex.gz";
$out_dir = 'build';

@default_files = ('main.tex');

