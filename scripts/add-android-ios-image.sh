#!/bin/bash

Shellout (){
    [ "$1" = "" ] || echo "ERROR : $1"
    exit 1
}

Usage (){
    echo
    echo "Usage :"
    echo "  `basename \"$0\"` -i <source image> -s <max size>"
    echo "  `basename \"$0\"` -i 'toto.png' -s 192 => Will generate file named toto.png, toto@2x.png, toto@3x.png"
    echo "  `basename \"$0\"` -i 'toto.png' -s 192 -n=> Will generate file named toto_48pt.png, toto_48pt@2x.png, toto_48pt@3x.png (48 = 192 / 4, because xxhdpi for Android is 4x)"
    echo
    echo '  find /Users/ommalago/Desktop/ -name "*.png" | xargs -I{} bash ./scripts/add-android-ios-image.sh -i "{}" -s 192 -n'
    echo "ERROR $1"
    echo
    exit 1
}

DATE=`date +%Y%m%d%H%M%S`

while getopts "h:i:s:n" arg; do
    case $arg in
        h)
            Usage ;
            ;;
        i)
            SRCFILE=$OPTARG
            ;;
        n)
            SUFFIX="1"
            ;;
        s)
            SIZE=$OPTARG
            ;;
        *)
            Usage "Illegal option $OPTARG"
            ;;
    esac
done

[ -f "$SRCFILE" ] || Usage "Source file -i $SRCFILE not found"
BNSRCFILE=`basename "${SRCFILE}" .png`

if [ "$SUFFIX" = "1" ]
then
    SUFFIX=`echo "${SIZE}/4" | bc`
    SUFFIX="_${SUFFIX}pt"
    BNSRCFILE="${BNSRCFILE}${SUFFIX}"
fi

RESIZEDFILE="/tmp/$$-${BNSRCFILE}"
convert -resize "${SIZE}x${SIZE}" "${SRCFILE}" "${RESIZEDFILE}"

WORKDIR="work-dir"
mkdir -p "${WORKDIR}/drawable-xxxhdpi" "${WORKDIR}/drawable-xxhdpi" "${WORKDIR}/drawable-xhdpi" "${WORKDIR}/drawable-hdpi" "${WORKDIR}/drawable-mdpi" 

convert -resize 100% "${RESIZEDFILE}" "${WORKDIR}/drawable-xxxhdpi/${BNSRCFILE}.png"
convert -resize 75% "${WORKDIR}/drawable-xxxhdpi/${BNSRCFILE}.png" "${WORKDIR}/drawable-xxhdpi/${BNSRCFILE}.png"
convert -resize 50% "${WORKDIR}/drawable-xxxhdpi/${BNSRCFILE}.png" "${WORKDIR}/drawable-xhdpi/${BNSRCFILE}.png"
convert -resize 37.5% "${WORKDIR}/drawable-xxxhdpi/${BNSRCFILE}.png" "${WORKDIR}/drawable-hdpi/${BNSRCFILE}.png"
convert -resize 25% "${WORKDIR}/drawable-xxxhdpi/${BNSRCFILE}.png" "${WORKDIR}/drawable-mdpi/${BNSRCFILE}.png"
#convert -resize 25% "${WORKDIR}/drawable-xxxhdpi/${BNSRCFILE}" "${WORKDIR}/drawable-nodpi/${BNSRCFILE}.png"
#convert -resize 25% "${WORKDIR}/drawable-xxxhdpi/${BNSRCFILE}" "${WORKDIR}/drawable-ldpi/${BNSRCFILE}.png"

BNSRCFILE2=`basename "${SRCFILE}" .png`
convert -resize 75% "${RESIZEDFILE}" "${WORKDIR}/${BNSRCFILE}@3x.png"
convert -resize 50% "${RESIZEDFILE}" "${WORKDIR}/${BNSRCFILE}@2x.png"
convert -resize 25% "${RESIZEDFILE}" "${WORKDIR}/${BNSRCFILE}.png"

rm -f "${RESIZEDFILE}"

echo
echo "All done, in work-dir"
echo
find "work-dir" -type f
