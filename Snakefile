configfile: "config.yaml"

rule all:
    input:
        config["final_output_file"]

rule process_data:
    input:
        config["input_file"]
    output:
        config["output_file"]
    log:    
        "logs/process_data.log"
    conda:
        "envs/bash.yaml"
    shell:
        "bash scripts/process_data.sh {input} {output}"

rule process_more:
    input:
        config["output_file"]
    output:
        config["final_output_file"]
    log:    
        "logs/process_more.log"
    conda:
        "envs/bash.yaml"
    shell:
        "bash scripts/process_more.sh {input} {output}"

