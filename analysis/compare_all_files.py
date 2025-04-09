import pandas as pd

csv_path_1 = "/mnt/experimento1.csv"
csv_path_2 = "/mnt/experimento2.csv"
csv_path_3 = "/mnt/experimento3.csv"

df_experimento1 = pd.read_csv(csv_path_1)
df_experimento2 = pd.read_csv(csv_path_2)
df_experimento3 = pd.read_csv(csv_path_3)

metrics = [
    'train/loss',
    'train/value_loss',
    'train/entropy_loss',
    'train/explained_variance',
    'train/policy_gradient_loss',
    'train/approx_kl',
    'train/clip_fraction',
    'train/std',
    'time/fps'
]

def get_last_valid(df, metrics):
    return {metric: df[metric].dropna().iloc[-1] if not df[metric].dropna().empty else None for metric in metrics}

summary = {
    "Experimento 1": get_last_valid(df_experimento1, metrics),
    "Experimento 2": get_last_valid(df_experimento2, metrics),
    "Experimento 3": get_last_valid(df_experimento3, metrics),
}

df_summary = pd.DataFrame(summary)