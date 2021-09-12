#!/usr/bin/env bash

while IFS= read -r line; do
	speech_LG+=("$(echo "$line" | awk -F '  ' '{print $NF}' | sed 's/^ //g')")
	speech_LG+=("$(echo "$line" | awk -F '  ' '{print $1}' | sed 's/^ //g')")
done <Speech_LG.txt

first="yes"
get_index() {
	count=0
	local i
	for ((i = 0; i <= ${#speech_LG[*]}; i++)); do
		if [[ "${speech_LG[i]}" == *"$1"* ]]; then
			[[ "$first" == "yes" ]] && echo "$i" && first="no"
			((count++))
		fi
	done
	return $count
}

word="$(echo "$1" | sed -e "s/\b\(.\)/\u\1/g")"

# count="$(grep -o "${word}" <<<"${speech_LG[*]}" | wc -l)"

if [[ "${speech_LG[*]}" =~ $word ]]; then

	index="$(get_index "$word")"
	count=$?
	# resut=("${speech_LG[*]:index:count}")
	echo "found $count lang"
	# echo -e "${resut[*]}\n"
fi
for ((i = index; i < $((count * 2 + index)); i += 2)); do

	echo "${speech_LG[i]}"
done
