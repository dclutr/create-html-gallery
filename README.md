# create-html-gallery
A tool to create a gallery that can be opened in browser. The files in the repository other than `create.sh` are not required

A sample gallery created from the script is available at https://dclutr.github.io/create-html-gallery/

## An alias of choice
Before running the script, one can create a short alias of choice in their .bashrc file. My choice was hg short for html gallery
```bash
# ~/.bashrc
alias hg="bash /path-to/create.sh"
```

## Creating the gallery
Once the alias is active (a way to do that is to reopen the terminal)
```bash
cd gallery-folder-of-choice
hg
```
The expectations of the script and the files created by the script are shown below
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
The bash script creates html pages with embedded audio / video and no javascript
1. jpg, jpeg, png, svg, apng, gif, ico, cur, jfif, pjpeg, pjp are embedded as images using the img tag
2. webm, ogg, mp4 are embedded as videos using the video and source tags
3. mpg, mpe, avi, wmv, mov, rm, ram, swf, flv are embedded as links using the a / anchor tag

Thanks to w3schools.com,
have used the information on web formats from `https://www.w3schools.com/html/html_media.asp` and `https://www.w3schools.com/html/html_images.asp`
