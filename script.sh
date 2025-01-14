#!/bin/sh

# Original image
INPUT_IMAGE="terminal.png"

# Step 1
echo " ==== Creating icons for $INPUT_IMAGE " 
sips -s format png --resampleHeightWidth 16 16 "${INPUT_IMAGE}" --out "icon_16x16.png"
sips -s format png --resampleHeightWidth 32 32 "${INPUT_IMAGE}" --out "icon_16x16@2x.png"
sips -s format png --resampleHeightWidth 32 32 "${INPUT_IMAGE}" --out "icon_32x32.png"
sips -s format png --resampleHeightWidth 64 64 "${INPUT_IMAGE}" --out "icon_64x64.png"
sips -s format png --resampleHeightWidth 128 128 "${INPUT_IMAGE}" --out "icon_128x128.png"
sips -s format png --resampleHeightWidth 256 256 "${INPUT_IMAGE}" --out "icon_128x128@2x.png"
sips -s format png --resampleHeightWidth 256 256 "${INPUT_IMAGE}" --out "icon_256x256.png"
sips -s format png --resampleHeightWidth 512 512 "${INPUT_IMAGE}" --out "icon_256x256@2x.png"
sips -s format png --resampleHeightWidth 512 512 "${INPUT_IMAGE}" --out "icon_512x512.png"
sips -s format png --resampleHeightWidth 1024 1024 "${INPUT_IMAGE}" --out "icon_512x512@2x.png"

# Step 2
ICONSET_FOLDER="terminal.iconset"
echo " ==== Moving images to iconset folder"
mkdir $ICONSET_FOLDER
find . -type f \
       -maxdepth 1 \
       -name "*.png" \
       -not -name "${INPUT_IMAGE}" \
       -exec mv {} $ICONSET_FOLDER \;

# Step 3
echo " ==== Converting .iconset folder to icns "
iconutil -c icns $ICONSET_FOLDER

# Step 4
# Move the terminal.icns file to /Applications/WezTerm.app/Contents/Resources/terminal.icns
echo " ==== Moving terminal.icns to ~/WezTerm.app/Contents/Resources/terminal.icns"
mv terminal.icns /Applications/WezTerm.app/Contents/Resources/terminal.icns

# Setep 5
# 
echo " ==== Delete iconcache ===="
rm /var/folders/*/*/*/com.apple.dock.iconcache
rm -r /var/folders/*/*/*/com.apple.iconservices*
killall Dock
