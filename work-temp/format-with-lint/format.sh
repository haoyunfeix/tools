function fix_trailing_whitespace(){
    sed -i 's/[ \t]*$//g' $1
}

function fix_cr_at_eol(){
    dos2unix $1
}

function fix_indent_tabs(){
    sed -i 's/\t/    /g' $1
}

function fix_unnecessary_executable_permission(){
    chmod 644 $1
}

time=`date +%s`
r_result=/tmp/format_$time
$1 > $r_result
cat $r_result | while read line
do
    error_type=`echo $line | awk -F ':' '{print $1}'`
    error_file=`echo $line | awk -F ':' '{print $2}'`
    case $error_type in
    "TRAILING WHITESPACE") fix_trailing_whitespace $error_file ;;
    "CR AT EOL") fix_cr_at_eol $error_file ;;
    "INDENT TABS") fix_indent_tabs $error_file ;;
    "UNNECESSARY EXECUTABLE PERMISSION") fix_unnecessary_executable_permission $error_file ;;
    *) echo "error";;
    esac
done

