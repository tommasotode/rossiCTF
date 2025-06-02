import os

def main():
    art = None
    with open("art.txt", "r") as f:
        art = f.read()

    print("====================================")
    print("  STAMPANTE SUPER IPER MEGA VELOCE  ")
    print("====================================")
    print("\nBenvenuto!\n")
    print("'help' aiuto")
    print("'ascii' ascii art")
    print("'exit' esci")
    print("")

    while True:
        stampa = input("Cosa vuoi stampare? ")
        
        if stampa.lower() == 'exit':
            print("ciaoooooo")
            break

        elif stampa.lower() == 'help':
                print("--------------------------")
                print("'help' questo messaggio")
                print("'ascii' ascii art")
                print("'exit' esci")
                print("--------------------------")

        elif stampa.lower() == 'ascii':
            print(f"\n{art}\n")
        
        else:
            cmd = f'echo "Ecco qui: {stampa}"'
            os.system(cmd)
            print("")

if __name__ == "__main__":
    main()