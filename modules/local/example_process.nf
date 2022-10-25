process EXAMPLE_PROCESS {

    publishDir "${params.outpath}",
        mode: "${params.publish_dir_mode}",
        pattern: "*.txt"
    publishDir "${params.process_log_dir}",
        mode: "${params.publish_dir_mode}",
        pattern: ".command.*",
        saveAs: { filename -> "${base}.${task.process}${filename}"}

    label "process_low"
    
    // Example of adding a docker container
    // container "snads/bbtools@sha256:9f2a9b08563839cec87d856f0fc7607c235f464296fd71e15906ea1d15254695"
    
    input:
        path input
        val base

    output:
        path "test.txt"
        path ".command.out"
        path ".command.err"
        path "versions.yml", emit: versions

    shell:
        '''
        source bash_functions.sh

        echo "Testing nextflow" > test.txt

        # Get process version if bbtools docker container is used
        # cat <<-END_VERSIONS > versions.yml
        # "!{task.process}":
            # bbduk: $(bbduk.sh --version 2>&1 | head -n 2 | tail -1 | awk 'NF>1{print $NF}')
        # END_VERSIONS
        '''
}
