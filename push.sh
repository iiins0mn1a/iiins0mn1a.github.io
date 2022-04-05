#!/bin/bash

git status
read -p "[ ] Add all? (yes/no) \n> " ANS
case "$ANS" in
    [yY] | [yY][eE][sS])
        echo "[+] Got it! Adding..."
		git add --all
		read -p "[*] commits:\n> " COM
		git commit -m $COM
		git status
		read -p "[ ] final check: (yes/no) \n> " FINAL
		
		case "$FINAL" in
			[yY] | [yY][eE][sS])
				git push origin
				;;
			[nN] | [nN][oO])
				echo "quiting..."
				;;
			*)
				echo "invalid!!!"
				;;
		esac
        
		;;
    [nN] | [nN][oO])
        echo "it's no!!!"
        ;;
    *)
        echo "invalid!"
        ;;
esac 
