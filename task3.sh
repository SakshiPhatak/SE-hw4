#!/bin/bash

# Step 1: Preprocess the CSV to replace commas inside quotes in the Name field
sed -E 's/(\"[^\"]*),(.*\")/\1;\2/' titanic.csv > titanic_preprocessed.csv

# Step 2: Process the preprocessed file with awk
awk -F, '
BEGIN {
    OFS = ",";  # Set output field separator to comma
}

NR == 1 {
    print;  # Print header line
    next;   # Skip to the next record
}

{
    # Task 1: Filter for passengers in 2nd class and Embarked at Southampton
    if ($3 == 2 && $12 == "S") {
        # Print debug info to see which records are being processed

        # Task 2: Replace male/female with M/F
        if ($5 == "male") {
            $5 = "M";
        } else if ($5 == "female") {
            $5 = "F";
        }

        # Task 3: Calculate the average age
        if ($6 != "") {
            total_age += $6;  # Sum the ages
            count++;          # Increment count of valid ages
        }

        # Print the filtered and modified passenger data
        print;  # Print the entire modified line
    }
}
END {
    if (count > 0) {
        average_age = total_age / count;
        printf "The average age of 2nd class passengers who embarked at Southampton is: %.2f\n", average_age;
    } else {
        print "No valid ages found.";
    }
}
' titanic_preprocessed.csv > task3_filtered_passengers.csv

echo "Filtered passengers with replaced gender labels have been saved to task3_filtered_passengers.csv."