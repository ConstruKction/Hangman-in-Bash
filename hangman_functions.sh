#!/bin/bash

declare word
declare counter=0
declare error=0
declare correct=0
declare letters

welcome_word() {
cat << "EOF"
 _                                             
| |__   __ _ _ __   __ _ _ __ ___   __ _ _ __  
| '_ \ / _` | '_ \ / _` | '_ ` _ \ / _` | '_ \ 
| | | | (_| | | | | (_| | | | | | | (_| | | | |
|_| |_|\__,_|_| |_|\__, |_| |_| |_|\__,_|_| |_|
                   |___/                       
EOF

if [ `expr length $word` == 0 ]
then
	echo "Welcome to hangman! Start guessing!"
	guess_letter
else
	echo "Welcome to hangman! Please choose your word:"
	read input_word
	word=$input_word
	guess_letter
fi
}

welcome_words() {
cat << "EOF"
 _                                             
| |__   __ _ _ __   __ _ _ __ ___   __ _ _ __  
| '_ \ / _` | '_ \ / _` | '_ ` _ \ / _` | '_ \ 
| | | | (_| | | | | (_| | | | | | | (_| | | | |
|_| |_|\__,_|_| |_|\__, |_| |_| |_|\__,_|_| |_|
                   |___/                       

Welcome to hangman! Start guessing!
EOF
word=`shuf -n 1 /usr/share/dict/words`
guess_letter
}

show_bottom_support() {
cat << "EOF"
    _____
EOF
}

show_vertical_pole() {
cat << "EOF"
      
     |
     |      
     |     
     |     
     |     
     |
    _|___
EOF
}

show_hang_pole() {
cat << "EOF"
      _______
     |/      
     |     
     |    
     |    
     |    
     |
    _|___
EOF
}

show_rope() {
cat << "EOF"
      _______
     |/      |
     |      
     |      
     |      
     |      
     |
    _|___
EOF
}

show_head() {
cat << "EOF"
      _______
     |/      |
     |      (_)
     |      
     |      
     |     
     |
    _|___
EOF
}

show_torso() {
cat << "EOF"
      _______
     |/      |
     |      (_)
     |       |
     |       |
     |       
     |
    _|___
EOF
}

show_left_arm() {
cat << "EOF"
      _______
     |/      |
     |      (_)
     |      \|
     |       |
     |       
     |
    _|___
EOF
}

show_right_arm() {
cat << "EOF"
      _______
     |/      |
     |      (_)
     |      \|/
     |       |
     |       
     |
    _|___
EOF
}

show_left_leg() {
cat << "EOF"
      _______
     |/      |
     |      (_)
     |      \|/
     |       |
     |      / 
     |
    _|___
EOF
}

show_hangman() {
cat << "EOF"
      _______
     |/      |
     |      (_) <(*choking sounds*)
     |      \|/
     |       |
     |      / \
     |
    _|___
EOF
}

end() {
	echo "You lost!"
	echo "The word was: $word."
	unset word
	echo $word

	read -p "Play again? (y/N)?" choice
	case "$choice" in 
    	y|Y)
			read -p "Type your word or leave empty for random:" new_word
			if [ `echo -n $new_word | wc -c > /dev/null` ! 0 ]
			then
				word = $new_word
				welcome_word
			else
				welcome_words
			fi
		;;
  		n|N) 
			exit
			echo "Come back soon!"
			;;
  		*) 
			exit 
			echo "Come back soon!"
			;;
	esac
}

usage() {
	echo "hangman: usage: hangman -w your_word"
	echo "hangman: usage: hangman -d"
	exit 1
}

guess_letter() {
	echo $word
	read input_letter
	if [[ $word == *"$input_letter"* ]]
	then
		clear
		echo "It's there!"
		let "correct++"
	else
		clear
		echo "It's not there!"
		let "error++"
	fi

	letters="$letters$input_letter"

	case "$error" in
		"1")
			show_bottom_support
			;;
		"2")
			show_vertical_pole
			;;
		"3")
			show_hang_pole
			;;
		"4")
			show_rope
			;;
		"5")
			show_head
			;;
		"6")
			show_torso
			;;
		"7")
			show_left_arm
			;;
		"8")
			show_right_arm
			;;
		"9")
			show_left_leg
			;;
		"10")
			show_hangman
			end
			;;
		*)
	esac
	
	guess_letter
}