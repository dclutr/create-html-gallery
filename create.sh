#!/usr/bin/env bash

#
# Copyright 2022 Akshansh Manchanda
#
#
# This program is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public Licenses as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public
# License along with the program. If not, see
# <https://www.gnu.org/licenses>
#


CSS_TARGET="styles.css"
HTML_TARGET="index.html"

# for all directories
# in current directory
#   add a page
#
function main() {

    root_index="$HTML_TARGET"
    echo "$CSS"        > "$CSS_TARGET"
    echo "$ROOT_START" > "$root_index"
    for dir in */
    do 
        if [ -d "$dir" ]
        then
            add-dir-page
        fi
    done
    echo "$ROOT_END"   >> "$root_index"
    echo "html-gallery finished, visit ./index.html"
}

#  for all media files in directory
#    embed file to directory index
#  and link to it in root index
#
function add-dir-page()
{
    unset previous_name previous_format
    unset current_name  current_format
    unset next_name     next_format
    
    media_count=0
    
    
    for file in "$dir"*
    do
        if [ ! -f "$file"  ]
        then
        	continue
        fi
        
        get-file-format
        
        if [ "$format" == "unrecognized" ]
        then
        	continue
        fi
        
        # link to first media in directory
        if [[ "$media_count" == 0 ]]
        then
            link="$ROOT_LINK"
            link="${link/file/$file}"
            link="${link//dir/$dir}"
            echo "$link" >> "$HTML_TARGET"
            dir_index="$dir""$HTML_TARGET"
            add-to-dir "${DIR_START/dir/$dir}"
        fi
        
        cycle-previous-current-next-file
        
        # skip first time as
        # previous and current = empty
        # next = first media file
        if [ -n "$current_name" ]
        then
            embed-media
        fi
        (( media_count++ ))
    done

    # add last media file
    if [[ "$media_count" != 0 ]]
    then
        unset file format
        cycle-previous-current-next-file
        
        # last file
        embed-media
        add-to-dir "${DIR_END/dir/$dir}"
        echo "$dir - $media_count"
    fi
}

# non web format? or web format?
# if web format, image or video?
# if web video,	what format?
function get-file-format() {

    case "${file,,}" in

        *.jpg|*.jpeg|*.png|*.svg) 
            format="web image";;
        *.apng|*.gif|*.ico|*.cur|*.jfif|*.pjpeg|*.pjp) 
            format="web image";;

        *.webm) 
            format="webm";;
        *.ogg) 
            format="ogg";;
        *.mp4) 
            format="mp4";;

        *.mpg|*.mpeg|*.avi|*.wmv|*.mov|*.rm|*.ram|*.swf|*.flv) 
            format="non web format";;

        *)
            format="unrecognized";;
    esac
}

# previous <= current <= next <= file and format
function cycle-previous-current-next-file() {

    previous_name="$current_name"
    previous_format="$current_format"

    current_name="$next_name"
    current_format="$next_format"

    next_name="${file/$dir}"
    next_format="$format"
}

# embed web image, web video or non web format to directory page
function embed-media()
{
    add-to-dir "${MEDIA_SECTION_START/current/$current_name}"
    add-to-dir "${NAV_PARA_START/current/$current_name}"

    if [ -n "$next_name" ]
    then
        add-to-dir "${NEXT/next/$next_name}"
    fi
    if [ -n "$previous_name" ]
    then
        add-to-dir "${PREVIOUS/previous/$previous_name}"
    fi

    add-to-dir "${NAV_PARA_END/dir/$dir}"
    
    case "$current_format" in
    	"non web format")
                add-to-dir "${NONWEB//name/$current_name}";;
    	"web image")
    		add-to-dir "${IMAGE//name/$current_name}";;
    	*) # web video
    		video="$VIDEO"
    		video="${video/name/$current_name}"
    		video="${video/format/$current_format}"
                add-to-dir "$video";;
    esac
    add-to-dir "$MEDIA_SECTION_END"
}

function add-to-dir()
{
    echo "$1" >> "$dir_index"
}


# ./styles.css
CSS='

*       { color :                 #ddd; }
body    { background :            #000; }
a:focus { background :            #222; }
a:focus { border :    0.5em solid #222; }

h1             { font-size : 3.6em; }
body           { padding : 2em; }
nav section    { padding : 0.5em; }
.media-section { padding : 1em; }

.media-section {
    width :  96vw;
    height : 96vh; 
}

img {
    max-width :  100%;
    max-height :  90%;
}
'

# ./index.html

ROOT_START='
<html>
    <head>
        <title> gallery </title>
        <link rel="stylesheet" href="'"$CSS_TARGET"'">
    </head>
    <body>
    	<nav>
    	    <h1> gallery </h1>'
ROOT_LINK='     <section id="dir"> 
                    <a href="dir'"$HTML_TARGET"'#file">
                        dir
                    </a>
                </section>'
ROOT_END='
        </nav>
    </body>
</html>'

# ./<dir name>/index.html

DIR_START='
<html>
    <head>
        <title> dir </title>
        <link rel="stylesheet" href="../'"$CSS_TARGET"'">
    </head>
    <body>'
MEDIA_SECTION_START='
        <section class="media-section" id="current">'
NAV_PARA_START='
            <p> 
                current,'
NEXT='          <a href="#next">Next</a>,'
PREVIOUS='      <a href="#previous">Previous</a>,'
NAV_PARA_END='  <a href="../'"$HTML_TARGET"'#dir">
                    [ Index ]
                </a>
            </p>'
IMAGE='         <img src="name" alt="name"/>'
VIDEO='         <video> 
                    <source
                        src="name"
                        type="video/format"
                        controls> 
                </video>'
NONWEB=\
'			<a href="name"> name </a>'
MEDIA_SECTION_END=\
'		</section>'
DIR_END=\
'	</body>
</html>'


main
