```bash
python -m venv py-rl-server 

# windows poweshell
py-rl-server\Scripts\Activate.ps1

# linux / mac
source py-rl-server/bin/activate

# install packages
python -m pip install https://github.com/edbeeching/godot_rl_agents/archive/refs/heads/main.zip
python -m pip install stable_baselines3
# or (not working)
python -m pip install stable_baselines3 godot_rl
# or (not working)
python -m pip install -r requirements.txt


```
