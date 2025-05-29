import os
import random

def split_file(file_path, n_fragments):
    with open(file_path, 'rb') as f:
        data = f.read()
    
    fragment_size = len(data) // n_fragments
    fragments = []
    for i in range(n_fragments - 1):
        fragments.append(data[i*fragment_size:(i+1)*fragment_size])
    fragments.append(data[(n_fragments-1)*fragment_size:])
    
    os.makedirs("fragments", exist_ok=True)
    
    fragment_paths = []
    for i, frag in enumerate(fragments):
        name = f"{random.getrandbits(24):06x}"
        path = os.path.join("fragments", name)
        with open(path, 'wb') as f:
            f.write(frag)
        fragment_paths.append(path)
    
    return fragment_paths

if __name__ == "__main__":
    fragments = split_file("flag.png", 11)
    print(f"Created {len(fragments)} fragments")