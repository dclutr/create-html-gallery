# create-html-gallery
A script to create web pages with pictures and videos embedded

A sample gallery created from the script is available at https://dclutr.github.io/create-html-gallery/

## Creating the gallery
Running the script `create.sh`, embeds images and videos present in each subdirectory of the current directory in the `index.html` of that subdirectory
```bash
cd folder-of-choice
alias hg="bash /path-to/create.sh"
hg
```
The script looks for files and creates files as shown below. This can also be seen in `example gallery.png`
```
[<=] used by script
[=>] created by script

   current directory
=> |__index.html
=> |__styles.css
<= |__<each folder with media files>
<=    |__media files
=>    |__index.html
```

## Gotchas
1. Too many media files in one directory can cause the `index.html` of that directory to be slow. Putting a limit on number of files can help, for example 64
2. The html pages rely on the browser's audio / video capabilities

Note: Kodi can be used instead of this script as long as your device is compatible.
Kodi is a software available on desktops and mobile phones which handles media browsing and playback pretty well

## Browsing the gallery
On desktops, often a browser is enough to browse local html files by using file:/// or clicking on a file
But if the files are on a mobile phone, they might have to be served. 
On Android I use 
the web server available at `https://f-droid.org/en/packages/net.basov.lws.fdroid/` with 
the file manager available at `https://f-droid.org/en/packages/org.openintents.filemanager/`
to browse on localhost (same device) or the local network (same device or devices on same network)

## Technicalities
The bash script creates html pages with embedded media and no javascript
1. jpg, jpeg, png, svg, apng, gif, ico, cur, jfif, pjpeg, pjp are embedded as images using the img tag
2. webm, ogg, mp4 are embedded as videos using the video and source tags
3. mpg, mpe, avi, wmv, mov, rm, ram, swf, flv are embedded as links using the a / anchor tag

Thanks to w3schools.com,
have used the information on web formats from `https://www.w3schools.com/html/html_media.asp` and `https://www.w3schools.com/html/html_images.asp`

Navigation from media to media and page to page is done using fragment urls pointing to sections using their id
