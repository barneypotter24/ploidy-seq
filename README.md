# Ploidy-seq data analysis

### _**DISCLAIMER**: Don't do any of this yet, I haven't debugged everything yet so it probably won't work._

First, we will need to create an instance on Jetstream Atmosphere and connect to iRODS. An explanation for how to do both of these things is available on [Mick Song's](https://github.com/michaelsongagradstudent) blog: https://michaelsongagradstudent.github.io/blog/2017/04/12/Cheat_Sheet_Atmosphere

Once we are in our Atmosphere web shell, we first want to install the package manager [conda](https://conda.io/docs/intro.html):
```
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```
We will need to re-initialize our web shell:
```
source ~/.bashrc
```
Next, clone the repository and cd into it:
```
git clone https://github.com/barneypotter24/ploidy-seq.git
cd ploidy-seq
```
From there, we can install all the software that we will need for the analysis and migrate our data from the CyVerse data store. All of this can be done by running the command:
```
bash setup.sh
```
At several points during the installation, we will be prompted to accept the installation of programs that we will use. Just hit the return key to accept the installation. Once the command is done running we will have a few things:
- populated directories for all of our raw and reference data
- a new environment built inside which all of our programs are installed called `ploidy-seq`
- empty directories that will store temporary files used during the pipeline as well as our pipeline output
We will activate our new environment by running:
```
source activate ploidy-seq
```
This gives us access to all the programs that we need to continue.

Now, we can test that everything is correctly installed and all of our data is living in the correct place:
```
snakemake -n
```
If no errors come up, we can start our analysis. Note that analysis will run on every file that is listed in `config.json`, and it may take a long time.
```
snakemake
```
All the output should end up in the folders `htseq` and `fastqc` and no intermediary files will be stored, to keep space use to a minimum.
