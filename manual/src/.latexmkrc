@default_files = ('main.tex');

$pdf_mode = 1;

# %O = options, %S = source
# Here, shellescape is mandatory for minted, for syntax highlighting
$pdflatex = 'pdflatex %O -synctex=1 -interaction=nonstopmode -shell-escape %S';



# Handle Bibliography
$biber = 'biber %O %S';

# Continuous Preview settings
# This makes the previewer (Okular/TeXstudio) update smoothly
$preview_mode = 1;
$pvc_view_setup_done = 1;

# Tell latexmk which extra files to nukes when running 'latexmk -c'
push @generated_exts, 'bcf', 'run.xml', 'fdb_latexmk', 'fls', 'snm', 'nav';