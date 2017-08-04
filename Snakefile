configfile: "config.json"
LIBRARIES = config['libraries']

rule all:
    input:
        expand("fastqc/{library}_fastqc.html",library=LIBRARIES),
        expand("htseq/{library}_At.txt",library=LIBRARIES),
        expand("htseq/{library}_ERCC.txt",library=LIBRARIES)

rule quality_filter:
    input:
        "fastq/{library}.fastq.gz"
    output:
        temp ("trimmo/{library}.fastq.gz")
    shell:
        "trimmomatic SE -phred33 {input} {output} ILLUMINACLIP:~/miniconda3/envs/ploidy-seq/share/trimmomatic-0.36-4/adapters/TruSeq3.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36"

rule fatqc_trimmed_filtered:
    input:
        "trimmo/{library}.fastq.gz"
    output:
        "fastqc/{library}_fastqc.zip"
    shell:
        "fastqc {input}"

rule gunzip:
    input:
        "trimmo/{library}.fastq.gz"
    output:
        temp ("gztmp/{library}.fastq")
    shell:
        "gunzip -c {input} > {output}"

def _get_index_name_from_reference(wildcards, input):
    return input['ref'].split(".")[0]

rule map_reads:
    input:
        ref="reference/Athaliana_167_TAIR9.fa.gz",
        reads="gztmp/{library}.fastq",
        spliceSites="reference/Athaliana_167_TAIR10_spliceSites.txt"
    output:
        temp ("hisat2/{library}_At.sam")
    params:
        index=_get_index_name_from_reference
    shell:
        "hisat2 -p 8 -k 10 -x {params.index} -U {input.reads} -known-splicesite-infile {input.spliceSites} --no-unal -t -S {output}"

rule map_ercc:
    input:
        ref="reference/ERCC92.fa.gz",
        reads="gztmp/{library}.fastq"
    output:
        temp ("hisat2/{library}_ERCC.sam")
    params:
        index=_get_index_name_from_reference
    shell:
        "hisat2 -p 8 -k 10 -x {params.index} -U {input.reads} --no-unal -t -S {output}"

rule count_reads_At:
    input:
        sam="hisat2/{library}_At.sam",
        gff3="reference/Athaliana_167_TAIR10.gene_exons.gff3",
    output:
        "htseq/{library}_At.txt"
    shell:
        "python -m HTSeq.scripts.count -m intersecton-nonempty -s no -t gene -i ID {input.sam} {input.gff3} > {output}"

rule count_reads_ERCC:
    input:
        sam="hisat2/{library}_ERCC.sam",
        gff3="reference/ERCC92.gtf"
    output:
        "htseq/{library}_ERCC.txt"
    shell:
        "python -m HTSeq.scripts.count -m intersecton-nonempty -s no -t gene -i ID {input.sam} {input.gff3} > {output}"
