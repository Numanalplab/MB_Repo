# Mini-Bioinformatics Pipeline: Long-Read Sequencing QC

## 📝 Project Summary
This project provides an end-to-end automated pipeline for the Quality Control (QC) and statistical evaluation of long-read sequencing data. Developed as a case study for **Professor Kılıç**, the pipeline ensures reproducibility and high-fidelity reporting of sequencing metrics.

## 🛠️ Tools & Libraries
- **Language:** Python 3.9 & R 4.5.2
- **Data Processing:** `Biopython`, `Pandas`, `NumPy`
- **Visualization:** `ggplot2`, `dplyr`, `patchwork` (R)
- **Environment Management:** `Conda` & `Docker`

## 📂 Folder Structure
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
## 🚀 Setup & Execution

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

## 📊 Analysis & Interpretation
The following metrics were derived from the analysis of the ```barcode77.fastq``` dataset:

| Metric | Result | 
|:---| :---|
|Total Reads| 81011|
|Means Read Length| 1,038.2 bp|
|Mean GC Content| 53.0%|
|Mean Quality Content (Phred)| 17.89|
||

## Interpretation
-Read Length: The distribution exhibits a significant "long tail" characteristic reaching over 600 kb, confirming successful ultra-long read sequencing. Logarithmic scaling was applied to the visualization to accurately represent the wide range of lengths.

-Quality Score: An average Phred score of $17.89$ was observed. This corresponds to a base-calling accuracy of approximately 98.4%. While sufficient for long-read data, a Q10 or Q12 filter is recommended for high-precision downstream assembly.

-GC Content: The stable distribution around 53% aligns with expected biological profiles, suggesting a clean run without major systematic biases.

## Communication
Dear Professor Kılıç,