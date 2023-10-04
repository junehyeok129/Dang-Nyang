import random
import pandas as pd


num_data_points = 100
heart_rate_data = [random.randint(60, 100) for _ in range(num_data_points)]
time_data = pd.date_range(start="2023-01-01", periods=num_data_points, freq="H")
# 데이터 프레임 생성
df = pd.DataFrame({'Time': time_data, 'HeartRate': heart_rate_data})

df.to_excel('./example.xlsx')

print(df)