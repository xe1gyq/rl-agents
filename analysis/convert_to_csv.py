from tensorboard.backend.event_processing.event_accumulator import EventAccumulator
import pandas as pd

log_path = "ruta/a/tu/archivo/events.out.tfevents.*"

event_acc = EventAccumulator(log_path)
event_acc.Reload()

scalar_frames = []

for tag in event_acc.Tags()["scalars"]:
    events = event_acc.Scalars(tag)
    df = pd.DataFrame({
        "step": [e.step for e in events],
        tag: [e.value for e in events]
    })
    scalar_frames.append(df)

from functools import reduce
merged_df = reduce(lambda left, right: pd.merge(left, right, on="step", how="outer"), scalar_frames)

merged_df.to_csv("experimento1.csv", index=False)
print("Archivo exportado como experimento1.csv")