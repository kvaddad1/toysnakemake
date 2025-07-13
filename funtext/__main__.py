import argparse
import subprocess
import yaml
import os
import sys

def main():
    parser = argparse.ArgumentParser(
        description="funtext: run the funtext Snakemake workflow\n"
                    "Outputs:\n"
                    "  result/output.txt : Uppercased version of the input file\n"
                    "  result/final.txt  : Numbered and reversed lines of output.txt"
    )
    parser.add_argument("-i", "--input", required=True, help="Input text file")
    parser.add_argument("--cores", type=int, default=1, help="Number of cores to use")
    args, unknown = parser.parse_known_args()

    # Set default output files
    output_file = "result/output.txt"
    final_output_file = "result/final.txt"

    # Ensure result directory exists
    os.makedirs("result", exist_ok=True)

    # Write config file
    config = {
        "input_file": args.input,
        "output_file": output_file,
        "final_output_file": final_output_file
    }
    config_path = "funtext_tmp_config.yaml"
    with open(config_path, "w") as f:
        yaml.dump(config, f)

    # Build snakemake command
    snakemake_cmd = [
        "snakemake",
        "--use-conda",
        f"--cores={args.cores}",
        f"--configfile={config_path}"
    ] + unknown

    try:
        subprocess.run(snakemake_cmd, check=True)
        print("\nWorkflow completed successfully!")
        print("Output files:")
        print(f"  {output_file} : Uppercased version of the input file")
        print(f"  {final_output_file} : Numbered and reversed lines of output.txt")
    finally:
        if os.path.exists(config_path):
            os.remove(config_path)

if __name__ == "__main__":
    main() 