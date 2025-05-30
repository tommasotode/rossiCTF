import os
from itertools import permutations
from PIL import Image
from io import BytesIO

def main():
    fragments_dir = "challs/misc/strangecloud/fragments"
    output_file = "reconstructed.png"
    
    fragments = []
    filenames = []
    
    for filename in os.listdir(fragments_dir):
        filepath = os.path.join(fragments_dir, filename)
        if os.path.isfile(filepath):
            with open(filepath, 'rb') as f:
                fragments.append(f.read())
                filenames.append(filename)
    
    if not fragments:
        print("Error: No files found in directory")
        return
    
    print(f"Loaded {len(fragments)} fragments")
    print("Files:", ", ".join(filenames))
    
    total_perms = 1
    for i in range(1, len(fragments) + 1):
        total_perms *= i
    
    print(f"Testing {total_perms} possible permutations...")
    PNG_HEADER = b'\x89PNG\r\n\x1a\n'
    
    for i, perm in enumerate(permutations(fragments)):
        if i % 100 == 0 and i > 0:
            print(f"  Tested {i} permutations so far...")
        
        candidate = b''.join(perm)
        
        if len(candidate) < 8:
            continue
            
        if candidate[:8] != PNG_HEADER:
            continue
        
        try:
            img = Image.open(BytesIO(candidate))
            img.verify()
            
            with open(output_file, 'wb') as f:
                f.write(candidate)
            
            print(f"\nSuccess! Valid image found at permutation #{i+1}")
            print(f"Image saved to {output_file}")
            
            print("\nFragment order:")
            for idx, data in enumerate(perm):
                orig_idx = fragments.index(data)
                print(f"  {idx+1}. {filenames[orig_idx]} (size: {len(data)} bytes)")
            
            return
        except:
            continue
    
    print("\nFailed to find valid image from all permutations")

if __name__ == "__main__":
    main()