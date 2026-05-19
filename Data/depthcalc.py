import os
import glob
import pandas as pd

# Calculate float depth from pressure. Generated with Gemini.

def calculate_depth(pressure_dbar):
    """
    Converts pressure in decibars (dbar) to depth in meters (m)
    using standard seawater density (1025 kg/m^3) and gravity (9.81 m/s^2).
    """
    # 1 dbar = 10,000 Pascals
    pressure_pa = pressure_dbar * 10000
    density = 1025
    gravity = 9.81

    depth = - pressure_pa / (density * gravity)
    return round(depth, 2)


def process_float_data():
    # Define the expected headers based on your sample data
    expected_headers = {
        'Date (yyyy-MMM-dd hh:mm)',
        'Latitude (N)',
        'Longitude (W)',
        'Temperature (C)',
        'Pressure (dbar)',
        'Speed (cm/s)',
        'Bottom Depth (m)'
    }

    # Target all CSV files in the current working directory
    csv_files = glob.glob("*.csv")

    if not csv_files:
        print("No .csv files found in the current directory.")
        return

    print("--- Starting Oceanographic Float Data Processing ---")

    for file_path in csv_files:
        filename = os.path.basename(file_path)

        # Rule 6: Skip files that already end in '_depth.csv'
        if filename.endswith("_depth.csv"):
            continue

        try:
            # Read the CSV file
            df = pd.read_csv(file_path)

            # Rule 5: Format check - verify all expected headers exist
            file_headers = set(df.columns)
            if not expected_headers.issubset(file_headers):
                print(f"[SKIPPED] {filename} - Missing required headers.")
                continue

            # Rule 4: Print the filename of the file being processed
            print(f"[PROCESSING] {filename}...")

            # Rule 2: Calculate and add the Depth (m) column
            df['Depth (m)'] = df['Pressure (dbar)'].apply(calculate_depth)

            # Rule 3: Construct new filename and save
            base_name = os.path.splitext(filename)[0]
            output_filename = f"{base_name}_depth.csv"

            df.to_csv(output_filename, index=False)
            print(f"    -> Saved successfully as: {output_filename}")

        except Exception as e:
            print(f"[ERROR] Could not process {filename}. Reason: {e}")

    print("--- Processing Complete ---")


if __name__ == "__main__":
    process_float_data()