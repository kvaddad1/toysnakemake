#!/bin/bash
set -e

# Create package directory structure
mkdir -p $PREFIX/share/snakemake-toyworkflow
mkdir -p $PREFIX/bin

# Copy workflow files
cp Snakefile script.py config.yaml $PREFIX/share/snakemake-toyworkflow/

# Copy environment files if they exist
if [ -d "envs" ]; then
    cp -r envs $PREFIX/share/snakemake-toyworkflow/
fi

# Create launcher script with help
cat << 'EOF' > $PREFIX/bin/run-toyworkflow
#!/bin/bash
set -e

# Show help if requested
if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]]; then
    cat << 'HELP'
Snakemake Toy Workflow - A simple data processing workflow

USAGE:
    run-toyworkflow [snakemake-options]

EXAMPLES:
    run-toyworkflow --cores 1                    # Run with 1 core
    run-toyworkflow --cores 4 --dry-run         # Dry run with 4 cores
    run-toyworkflow --dag                       # Show workflow DAG
    run-toyworkflow --report report.html        # Generate HTML report

WORKFLOW:
    - Reads data from: data/input.txt (CSV format)
    - Processes data and generates statistics
    - Creates plots in: results/plot.pdf
    - Outputs results to: results/output.txt

REQUIREMENTS:
    - Input file: data/input.txt (CSV with 'time' and 'value' columns)
    - Creates: results/ directory for outputs

For more Snakemake options, see: snakemake --help
HELP
    exit 0
fi

# Get the workflow directory
WORKFLOW_DIR="$CONDA_PREFIX/share/snakemake-toyworkflow"

# Check if workflow directory exists
if [ ! -d "$WORKFLOW_DIR" ]; then
    echo "Error: Workflow directory not found: $WORKFLOW_DIR"
    exit 1
fi

# Change to workflow directory and run snakemake
cd "$WORKFLOW_DIR"
exec snakemake "$@"
EOF

chmod +x $PREFIX/bin/run-toyworkflow

echo "Package built successfully!" 