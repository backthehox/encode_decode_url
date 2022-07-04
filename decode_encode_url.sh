#!/bin/bash
decode () {
	if [[ $1 != "" && $2 != "" ]]; then
		sed -i "s/$1/$2/g" "$NOMFICH"
		#tr '$1' '$2' < fichier.txt > output.txt
	fi
}

encode () {
	if [[ $1 != "" && $2 != "" ]]; then
		sed -i "s/$2/$1/g" "$NOMFICH"
		#tr '$1' '$2' < fichier.txt > output.txt
	fi
}

walk_fich () {
cat fichier.txt
	while read -r Line; 
	do # reading each line
		COUNTCOM=${Line//[^,]} # stock toutes les virgules
		#echo "${#COUNTCOM}"
		if [ "${#COUNTCOM}" -gt 2 ]; then
			echo "error line: $Line" ;
		else
			#echo $Line ;
			Code=$(echo $Line | awk -F, '{print $1}')
			Lettre=$(echo $Line | awk -F, '{print $2}')
			echo "remplacement: $Code $Lettre"
			if [ $2 == 1 ]; then
				encode "$Code" "$Lettre"
			else
				decode "$Code" "$Lettre"
			fi
		fi
	done < "$1"
echo " %26 & et %2c \ ne marchent pas "
}

#init encode
if [ $# != 2 ]; then
    echo -e "Entrez le nom du fichier suivi de 1 pour encode ou 2 pour decode"
    exit 1
fi

export NOMFICH=$1
CONFIG=config.csv
walk_fich "$CONFIG" "$2"
