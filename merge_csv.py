import pandas as pd 

def merge_csv(file_1, file_2):
    data_1 = pd.read_csv(file_1)
    data_2 = pd.read_csv(file_2)
    merged_data = pd.concat([data_1,data_2])
    merged_data.to_csv("merged.csv", index=False)

merge_csv('2019-Oct.csv', '2019-Nov.csv')
