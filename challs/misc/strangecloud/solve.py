import os
from itertools import permutations
from PIL import Image
from io import BytesIO
from tqdm import tqdm

def solve():
    fragments_dir = "challs/misc/strangecloud/fragments"
    output_file = "challs/misc/strangecloud/fragments/reconstructed.png"
    first_name = "first.png"

    fragments = []
    for filename in os.listdir(fragments_dir):
        filepath = os.path.join(fragments_dir, filename)
        if os.path.isfile(filepath):
            with open(filepath, 'rb') as f:
                data = f.read()
                fragments.append((filename, data))
    if not fragments:
        return
    
    first = None
    for i, (fname, data) in enumerate(fragments):
        if fname == first_name:
            first = data
            del fragments[i]
            break
    if first is None:
        return
        
    for perm in tqdm(permutations(fragments)):
        raw = first + b''.join(data for (_, data) in perm)
                    
        try:
            img = Image.open(BytesIO(raw))
            img.verify()
            
            with open(output_file, 'wb') as f:
                f.write(raw)
            
            print(f"Fatto! salvata flag in {output_file}")
            return
        except Exception as e:
            continue
    
    print("\nNessuna immagine valida")

solve()