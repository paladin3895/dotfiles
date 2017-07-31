#!/bin/zsh

content_file="/tmp/.semicolon.content";
echo "" > $content_file;

error_file="/tmp/.semicolon.error";
echo "" > $error_file;

## Handling user input ##
input=$(zenity --entry --title "Enter command" --text "");
prefix=$(echo "$input" | cut -c1-1 | grep "[\<\:\>\;]");
if [ "" != "$prefix" ]
then
    input=$(echo "$input" | cut -c 2-);
else
    prefix=";";
fi

command=$(echo "$input" | tr -s ' ' | cut -d ' ' -f 1);
args=$(echo "$input" | tr -s ' ' | cut -d ' ' -f 2-);

## Utility functions ##
source ~/.utilities;
zenity_info() {
	content="$1";
	zenity --text-info \
		   --title="Information" \
		   --filename="$content" \
		   --font=monospace;
}

## Command switch ##
## Command template
## "{key}") {command} $args 2>$error_file | tee 1>$content_file | read content

case "$command" in
    "c0") copyq_clipboard_read 0 $args 2>$error_file | tee 1>$content_file;;
    "c1") copyq_clipboard_read 1 $args 2>$error_file | tee 1>$content_file;;
    "c2") copyq_clipboard_read 2 $args 2>$error_file | tee 1>$content_file;;
    "c3") copyq_clipboard_read 3 $args 2>$error_file | tee 1>$content_file;;
    "c4") copyq_clipboard_read 4 $args 2>$error_file | tee 1>$content_file;;
    "c5") copyq_clipboard_read 5 $args 2>$error_file | tee 1>$content_file;;
    "c6") copyq_clipboard_read 6 $args 2>$error_file | tee 1>$content_file;;
    "c7") copyq_clipboard_read 7 $args 2>$error_file | tee 1>$content_file;;
    "c8") copyq_clipboard_read 8 $args 2>$error_file | tee 1>$content_file;;
    "c9") copyq_clipboard_read 9 $args 2>$error_file | tee 1>$content_file;;

    "n1") copyq_note_read 0 $args 2>$error_file | tee 1>$content_file;;
    "n2") copyq_note_read 1 $args 2>$error_file | tee 1>$content_file;;
    "n3") copyq_note_read 2 $args 2>$error_file | tee 1>$content_file;;
    "n4") copyq_note_read 3 $args 2>$error_file | tee 1>$content_file;;
    "n5") copyq_note_read 4 $args 2>$error_file | tee 1>$content_file;;
    "n6") copyq_note_read 5 $args 2>$error_file | tee 1>$content_file;;
    "n7") copyq_note_read 6 $args 2>$error_file | tee 1>$content_file;;
    "n8") copyq_note_read 7 $args 2>$error_file | tee 1>$content_file;;
    "n9") copyq_note_read 8 $args 2>$error_file | tee 1>$content_file;;

    "u1") copyq_note_update 0 $args 2>$error_file | tee 1>$content_file;;
    "u2") copyq_note_update 1 $args 2>$error_file | tee 1>$content_file;;
    "u3") copyq_note_update 2 $args 2>$error_file | tee 1>$content_file;;
    "u4") copyq_note_update 3 $args 2>$error_file | tee 1>$content_file;;
    "u5") copyq_note_update 4 $args 2>$error_file | tee 1>$content_file;;
    "u6") copyq_note_update 5 $args 2>$error_file | tee 1>$content_file;;
    "u7") copyq_note_update 6 $args 2>$error_file | tee 1>$content_file;;
    "u8") copyq_note_update 7 $args 2>$error_file | tee 1>$content_file;;
    "u9") copyq_note_update 8 $args 2>$error_file | tee 1>$content_file;;

    "n") copyq_notes $args 2>$error_file | tee 1>$content_file;;
    "c") copyq_clipboard $args 2>$error_file | tee 1>$content_file;;

    "lp") lastpass_show_password $args 2>$error_file | tee 1>$content_file;;
    "lpu") lastpass_show_username $args 2>$error_file | tee 1>$content_file;;
    "lpn") lastpass_show_note $args 2>$error_file | tee 1>$content_file;;

    "nvim") gnome-terminal -e nvim $args 2>$error_file | tee 1>$content_file;;
    "htop") gnome-terminal -e htop $args 2>$error_file | tee 1>$content_file;;
    "ranger") gnome-terminal -e ranger $args 2>$error_file | tee 1>$content_file;;
    "url") sensible-browser $args 2>$error_file | tee 1>$content_file;;
    "homestead") cd ~/Projects/Vagrant/homestead && vagrant $args 2>$error_file | tee 1>$content_file;;
    "mysql") gnome-terminal -e "mycli -uhomestead -psecret -h192.168.10.10" 2>$error_file | tee 1>$content_file;;
    "sp") spotify-cli "--$args" 2>$error_file | tee 1>$content_file;;

    "bc") bc_calculator $args 2>$error_file | tee 1>$content_file;;

    *) /bin/zsh -c "$input" 2>$error_file | tee 1>$content_file;;
esac

if [ "" = "$(cat $error_file)" ]
then
    case "$prefix" in
        "<") zenity_info "$content_file";;
        ">") copyq_clipboard_copy "$(cat $content_file)";;
        ":") zenity_info "$content_file";
             copyq_clipboard_copy "$(cat $content_file)";;
        ";") ;;
     esac
else
    zenity --error --text="$(cat $error_file)";
fi
