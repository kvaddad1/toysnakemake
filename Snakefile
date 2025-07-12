configfile: "config.yaml"

rule all:
    input:
        config["output_file"]

rule process_data:
    input:
        config["input_file"]
    output:
        output_file=config["output_file"],
        plot_file="results/plot.pdf"
    params:
        plot_type=config["plot_type"]
    conda:
        "envs/myenv.yaml"
    log: 
        "logs/process_data.log"
    benchmark:
        "benchmarks/process_data.txt"
    shell:
        "python script.py {input} {output.output_file} {output.plot_file} {params.plot_type}"

