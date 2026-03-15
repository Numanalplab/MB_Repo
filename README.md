# Mini-Bioinformatics Pipeline: Long-Read Sequencing QC

##  Project Summary
This project provides an end-to-end automated pipeline for the Quality Control (QC) and statistical evaluation of long-read sequencing data. Developed as a case study for **Professor Kılıç**, the pipeline ensures reproducibility and high-fidelity reporting of sequencing metrics.

##  Tools & Libraries
- **Language:** Python 3.9 & R 4.5.2
- **Data Processing:** `Biopython`, `Pandas`, `NumPy`
- **Visualization:** `ggplot2`, `dplyr`, `patchwork` (R)
- **Environment Management:** `Conda` & `Docker`

##  Folder Structure
```text
bioinformatics_project/
├── data/               # Raw FASTQ files (ignored by git)
├── scripts/
│   ├── Fastq.py        # Python parser for metric extraction
│   └── visualize_results.R  # R script for statistical plotting
├── results/            # Generated CSV metrics and PNG plots
├── Dockerfile          # Container configuration
├── .dockerignore       # Docker build exclusions
├── environment.yml     # Conda environment dependencies
└── README.md           # Project documentation
```
##  Setup & Execution

### 1. Local Pipeline (Conda)
To install dependencies and run the analysis locally:

```bash
# Create and activate environment
conda env create -f environment.yml
conda activate bioinfo_case

# Run the full pipeline
python scripts/Fastq.py
Rscript scripts/visualize_results.R
```

### 2. Docker Execution (Full Reproducibility)
To run the project in a completely isolated environment without local installations:

```Bash
# Build the image
docker build -t bioinfo_case_image .

# Run the container with data volume mapping
docker run -it -v ${PWD}/data:/app/data bioinfo_case_image
```

##  Analysis
The following metrics were derived from the analysis of the ```barcode77.fastq``` dataset:

| Metric | Result | 
|:---| :---|
|Total Reads| 81011|
|Mean Read Length| 1,038.2 bp|
|Mean GC Content| 53.0%|
|Mean Quality Content (Phred)| 17.89|
||

## Interpretation
- Read Length: The distribution exhibits a significant "long tail" characteristic reaching over 600 kb, confirming successful ultra-long read sequencing. Logarithmic scaling was applied to the visualization to accurately represent the wide range of lengths.

- Quality Score: An average Phred score of $17.89$ was observed. This corresponds to a base-calling accuracy of approximately 98.4%. While sufficient for long-read data, a Q10 or Q12 filter is recommended for high-precision downstream assembly.

- GC Content: The stable distribution around 53% aligns with expected biological profiles, suggesting a clean run without major systematic biases.

## Future Directions
In this case study, I utilized a custom Python/R pipeline managed via Docker. While industry-standard workflow managers like Nextflow and Snakemake exist, I deliberately chose not to use them for this particular project. Here are some reasons:

- In this project, I analyzed a single sample with a linear two-step process (Parse -> Visualize) But workflow manager tools are designed for high-throughput scaling. If I had 1000 FASTQ files to process in parallel on a cluster or cloud, Nextflow or Snakemake would be mandatory. For a single-sample case study, the overhead of writing a `Snakefile` or a Nextflow `.nf`script adds unnecessary complexity.

- Workflow managers excel at "resuming" failed pipelines. If a pipeline with 50 steps fails at step 49, Nextflow knows not to rerun the first 48. Since my pipeline is very fast and only has two steps, the "resume" feature provides negligible benefit compared to the effort of setting it up.

- If this project were to evolve, I would transition to a workflow manager under these conditions:

      1- Multi-sample processing: Adding 10+ samples simultaneously.
      2- Complex DAGs: If I added alignment, variant calling, and functional annotation steps.
      3- Cloud integration: If I needed to run this on AWS Batch or Azure.

To summarize, we didn't use a sledgehammer to crack a nut.

## Communication & Reporting

**Final Summary for Professor Kılıç:**

Dear Professor Kılıç,

The sequencing run for the `barcode77.fastq` dataset has been successfully validated through the automated pipeline. 

To address the extreme variation and inherent skewness in long-read data, I implemented a **logarithmic scale** in the R visualizations. This ensures that the entire distribution—from standard fragments to ultra-long reads reaching 600 kb—is clearly interpretable without losing visual detail.

The integration of Python for high-performance backend processing and R for professional statistical visualization provides a robust framework for our future biophysics datasets. Furthermore, the entire workflow is containerized via **Docker** to ensure 100% reproducibility, allowing the pipeline to yield identical results on any system.

**Recommendation:** Based on the QC metrics (Mean Phred: 17.89), the dataset is of sufficient quality to **proceed to the alignment stage**. However, I recommend applying a **Q10 filtering step** during the preprocessing to ensure maximum accuracy for downstream assembly and variant calling.

---
**Developed by:** Numan Alp İlhan  
**Date:** March 2026
