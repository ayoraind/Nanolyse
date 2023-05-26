params.reads = 'reads/*.fastq.gz'
params.reference_fasta = 'reference.fasta'
params.output_dir = 'test'

process NANOLYSE {
    publishDir "${params.output_dir}", mode:'copy'
    tag "$meta"
    
    input:
    tuple val(meta), path(fastq), path(fasta)

    output:
    tuple val(meta), path("*.fastq.gz"), emit: fastq_ch
    path "*.log"                       , emit: log
    path "versions.yml"                , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta}"
    """
    gunzip -c $fastq | NanoLyse -r $fasta | gzip > ${prefix}_extracted.fastq.gz
   # gunzip -c $fastq | NanoLyse -r $fasta > ${prefix}_extracted.fastq
    
   # gzip ${prefix}_extracted.fastq
    
    mv NanoLyse.log ${prefix}.nanolyse.log

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        nanolyse: \$(NanoLyse --version 2>&1 | sed -e "s/NanoLyse //g")
    END_VERSIONS
    """
}

workflow  {
         fasta_ch = channel
                          .fromPath( params.reference_fasta, checkIfExists: true )
                          
         reads_ch = channel
                          .fromPath( params.reads, checkIfExists: true )
                          .map { file -> tuple(file.simpleName, file) }
	fasta_ch.view()
	reads_ch.view()
	
	// combine method used instead of join method as both channels (reads_ch and ch_index) share no key
         combine_ch = reads_ch.combine(fasta_ch)
	 
	 NANOLYSE(combine_ch)
	 
	 NANOLYSE.out.fastq_ch.view()
			  
}
