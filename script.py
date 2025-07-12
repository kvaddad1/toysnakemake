import pandas as pd
import matplotlib.pyplot as plt

def process_data(input_file, output_file):
    # Read the dataset
    data = pd.read_csv(input_file)
    
    # Perform some basic processing (e.g., calculate mean of a column)
    mean_value = data['value'].mean()
    
    # Save the processed data
    with open(output_file, 'w') as f:
        f.write(f"Mean value: {mean_value}\n")

def plot_data(input_file, plot_file, plot_type="png"):
    # Read the dataset
    data = pd.read_csv(input_file)
    
    # Create a simple plot
    plt.figure(figsize=(10, 6))
    plt.plot(data['time'], data['value'], label='Value over Time')
    plt.xlabel('Time')
    plt.ylabel('Value')
    plt.title('Data Plot')
    plt.legend()
    plt.savefig(plot_file, format=plot_type, dpi=300, bbox_inches='tight')
    plt.close()

if __name__ == "__main__":
    import sys
    process_data(sys.argv[1], sys.argv[2])
    plot_data(sys.argv[1], sys.argv[3], sys.argv[4] if len(sys.argv) > 4 else "png")
