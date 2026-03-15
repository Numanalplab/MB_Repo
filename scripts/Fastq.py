import pandas as pd
from Bio import SeqIO
import numpy as np
import os
import sys

def fastq_to_metrics(input_file, output_file):
    
    if not os.path.exists(input_file):
        print(f"Hata: {input_file} dosyası bulunamadı")
        return
    analysis_results = []

    for record in SeqIO.parse(input_file, "fastq"):
        read_length = len(record.seq)
        
        sequence = str(record.seq).upper()
        gc_count = sequence.count('G') + sequence.count('C')
        gc_content = (gc_count / read_length) * 100 if read_length > 0 else 0

        quality_scores = record.letter_annotations["phred_quality"]
        mean_quality = np.mean(quality_scores) if quality_scores else 0
        
        analysis_results.append({
            "read_id": record.id,
            "read_length": read_length,
            "gc_content": round(gc_content, 2),
            "mean_quality": round(mean_quality, 2)
        })

    df = pd.DataFrame(analysis_results)
    df.to_csv(output_file, index=False)
    

if __name__ == "__main__":
    INPUT_PATH = "data/barcode77.fastq" 
    OUTPUT_PATH = "results/read_metrics.csv"

    fastq_to_metrics(INPUT_PATH, OUTPUT_PATH)
    