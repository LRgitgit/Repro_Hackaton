cd ../rules \
&& snakemake -s getGenomes --cores 1 \
&& ../workflow/subsetting \
&& snakemake -s indexGenome --cores 1 \

