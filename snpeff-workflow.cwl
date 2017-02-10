#!/usr/bin/env cwl-runner

class: Workflow

cwlVersion: v1.0

inputs:
  genome:
    type: string
  infile:
    type: File
    doc: gzip VCF file to annotate

steps:
  gunzip:
    run: gunzip.cwl
    in:
      gzipfile:
        source: infile
    out: [unzipped_vcf]

  snpeff:
    run: snpeff.cwl
    in:
      input_vcf: gunzip/unzipped_vcf
      genome: genome
    out: [output, stats, genes]

doc: |
  Annotate variants provided in a gziped VCF using SnpEff
