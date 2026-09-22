import pandas as pd

# Load original dataset
data = pd.read_csv("data/StudentPerformanceFactors.csv")

# Select 100 random students
data_100 = data.sample(n=100, random_state=123)

# Save the 100-student dataset
data_100.to_csv("data/StudentPerformance_100.csv", index=False)

print("Original dataset:", data.shape)
print("100-student dataset:", data_100.shape)
print("100-student dataset created successfully.")