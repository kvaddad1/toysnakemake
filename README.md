# funtext

A simple, user-friendly text processing workflow powered by Snakemake, packaged for easy command-line use and installation with pip (and optionally conda).

## What does it do?
- Takes a plain text input file.
- Produces two outputs:
  - `result/output.txt`: Uppercased version of the input file.
  - `result/final.txt`: Numbered and reversed lines of `output.txt`.

## Directory and File Overview

| File/Directory         | Purpose                                                        |
|-----------------------|----------------------------------------------------------------|
| `Snakefile`           | Defines the workflow steps using Snakemake rules.               |
| `config.yaml`         | Example config file (not needed for CLI usage, for reference).  |
| `envs/bash.yaml`      | Conda environment for workflow steps.                           |
| `scripts/`            | Contains Bash scripts used in the workflow.                    |
| `scripts/process_data.sh` | Converts input to uppercase.                              |
| `scripts/process_more.sh` | Numbers and reverses lines of output.txt.                 |
| `data/input.txt`      | Example input file.                                             |
| `funtext/`            | Python package for the CLI entry point.                        |
| `funtext/__main__.py` | CLI logic: parses args, writes config, runs Snakemake.          |
| `setup.py`            | Makes the package pip-installable and registers the CLI.        |

## How was the pip command created?
1. **Python package structure:**
   - Created a `funtext/` directory with a `__main__.py` file.
2. **CLI logic:**
   - `__main__.py` uses `argparse` to parse `-i/--input` and `--cores`.
   - It writes a temporary config file and calls Snakemake with the right options.
   - Any extra arguments are passed through to Snakemake (so you can use `--dag`, etc.).
3. **setup.py:**
   - Registers the `funtext` command as a console script pointing to `funtext.__main__:main`.
   - Lists dependencies (e.g., `pyyaml`).
4. **Install locally:**
   - Run `pip install -e .` in the project root to install the CLI for development.

## Usage

```bash
funtext -i data/input.txt --cores 1
```
- This will create:
  - `result/output.txt` (uppercased input)
  - `result/final.txt` (numbered, reversed lines of output.txt)

## Advanced Usage
- Any extra arguments are passed to Snakemake. For example:
  - Dry run: `funtext -i data/input.txt --cores 1 -n`
  - Show DAG: `funtext -i data/input.txt --cores 1 --dag | dot -Tpdf > dag.pdf`

## How to build a conda package (optional)
- See `conda-recipe/meta.yaml` (if present) for instructions on building and installing with conda.

---

**This project demonstrates how to turn a Snakemake workflow into a user-friendly, pip-installable command-line tool!** 