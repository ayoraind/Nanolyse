process NANOLYSE {
    publishDir "${params.output_dir}", mode:'copy'
    tag "$meta"
    memory { 4.GB * task.attempt }
    errorStrategy { task.attempt <= 5 ? "retry" : "finish" }
    maxRetries 5
    
    input:
    tuple val(meta), path(fastq), path(fasta)

    output:
    tuple val(meta), path("*.fastq.gz"), emit: fastq_ch
    path "*.log"                       , emit: log_ch
    path "versions.yml"                , emit: versions_ch

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta}"
    """
    gunzip -c $fastq | NanoLyse -r $fasta | gzip > ${prefix}.extracted.fastq.gz
    
    mv NanoLyse.log ${prefix}.nanolyse.log

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        nanolyse: \$(NanoLyse --version 2>&1 | sed -e "s/NanoLyse //g")
    END_VERSIONS
    """
}

