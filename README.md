## Workflow to remove unwanted reads.
### Usage

```

=======================================================================
         REMOVE UNWANTED READS TAPIR Pipeline version 1.0dev
=======================================================================
 The typical command for running the pipeline is as follows:
        nextflow run main.nf --reads "PathToReadFile(s)" --output_dir "PathToOutputDir" --reference_fasta "PathToRefFasta" 

        Mandatory arguments:
         --reads                        Query fastqz file of sequences you wish to supply as input (e.g., "/MIGE/01_DATA/01_FASTQ/T055-8-*.fastq.gz")
         --reference_fasta              genome to filter out (e.g., human genome, /path/to/GRCh38.primary_assembly.genome.fa)
         --output_dir                   Output directory to place output (e.g., "/MIGE/01_DATA/03_ASSEMBLY")
         
        Optional arguments:
         --help                         This usage statement.
         --version                      Version statement

```


## Introduction
This pipeline filters out named genome from reads. This pipeline was completely adapted from the NF Core's [Nanolyse module](https://github.com/nf-core/nanoseq/blob/master/modules/nf-core/nanolyse/main.nf) with minor modifications.  


## Sample command
An example of a command to run this task is:

```
nextflow run main.nf --reads "Sample_files/*.fastq.gz" --output_dir "test2" --reference_fasta "PathToRefFasta"
```

## Word of Note
This is an ongoing project at the Microbial Genome Analysis Group, Institute for Infection Prevention and Hospital Epidemiology, Üniversitätsklinikum, Freiburg. The project is funded by BMBF, Germany, and is led by [Dr. Sandra Reuter](https://www.uniklinik-freiburg.de/iuk-en/infection-prevention-and-hospital-epidemiology/research-group-reuter.html).


## Authors and acknowledgment
The TAPIR (Track Acquisition of Pathogens In Real-time) team.
