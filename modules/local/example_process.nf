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
    container "ubuntu:focal"
    
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

        # Get process version of container used
        cat <<-END_VERSIONS > versions.yml
        "!{task.process}":
            ubuntu: $(cat /etc/issue)
        END_VERSIONS
        '''
}
