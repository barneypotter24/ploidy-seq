import sys
ath_file = "../data/networks/arabidopsis_thaliana.tsv"
o_file = "../data/networks/parsed_networks.tsv"

with open(ath_file, 'r') as f:
    with open(o_file, 'w') as o:
        header = "complex\tgene"
        f.readline()
        for line in f.readlines():
            line = line.split('\t')
            complex = line[0]
            print(complex)
            for gene in line[4].split('|'):
                i = gene.index('(')
                gene = gene[:i]
                print(gene)
                line = "{}\t{}\n".format(complex, gene)
                o.write(line)
