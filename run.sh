conda activate snakemake
conda install -y -c conda-forge singularity
snakemake -s rules/getFastq2 --cores 8 --use-singularity
snakemake -s rules/getGenomes --cores 8
snakemake -s rules/indexGenome --cores 8 --use-singularity --singularity-args "--bind ~/Repro_Hackaton"
snakemake -s rules/mapping --cores 8 --use-singularity
