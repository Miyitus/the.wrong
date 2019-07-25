# the.wrong Router v1

SOFTWARE INTRODUCTION

- Firmware: package and library compilation
- Software: files uploads, fix layout, system, router name config, access point
- Interface : CSS, typo and layout
- Template: files organization
- Software testing && debugging

Reboot
]


 About the project

*The.Wrong software load the locally-hosted website http://the.wrong/router
(.jpg, .gif, .mp4, .pdf, .mp3 // html, php, js, css) images and data files will be charger from the USB drive. The project is based on Piratebox. Developed by Matthias Strubel & Miyö Van Stenis.

*The.Wrong router  is a device designed and engineered to display digital art to everyone nearby with a smart phone or tablet, via WiFi.

Hardware Highlights

The Wrong Router v1:
- Powered by MTK 7628NN 580Mhz SoC
- 300Mbps high speed
- Small, light, easy to use
- The.Wrong Router software pre-installed
- Increased RAM from 64MB to 128 MB
- Better Wi-Fi signal with MTK driver
#
download a text editor for code in your computer
sublime text will do. you can use your computer notepad app but we recommend an advance tool.

edit the pages
index.html and nothing.html, this pages will contain the presentation of your project

index.html it’s a page that only hold an image preview for each artist, this images are link to each artist html, that you will find in the directory: content >

art pages organized by number 01.html, 02.html, 03.html, and so on...

keep in mind that you’ve 11 images, #1 will be in this case your “about” that links to “nothing.html”

edit nothing.html, when you open this file you’ll see that the website layout is inside <div class=”dsc”> keep it like that and only edit the content inside.
<img> will hold your image preview, you can deleted if you don’t need a top image.

<small> place here your title or headline.
<p> will be the place to write you description, every new <p> it’s a new paragraph.
<br> it’s a line break, you can used for phrasing content.
easy, right?!

edit your artists pages
01.html, 02.html, 03.html and 04.html are our exemple pages, the rest are just blank waiting for your content!
01.html, it’s our video preview, you’ll have the same layout everytime, inside you have:
<div class="tw"> this is your button to go back to the index page
<div class="dsc"> the place for your content
<img> your artwork preview image
<small> title
<p> your description
<strong> a second title with a different style

#artwork

video
add a video .pm4; our default file is called video01.mp4 you can rename your file to to video01.mp4 if not you may have to change the name of the file.
<div class="embed-video"> will allow to recominzed your content as a video
<h2>  add here artwork information or title
<iframe width="560" height="315" You need to put here the real dimension of the video.
src="img/01/video01.mp4" frameborder="0" allowfullscreen>
you can change here the name of your video file replacing the directory and file name.

edit 02.html, it’s our image preview, it has the same layout as 01.html (see above)

images
add an image: .jpg.tiff.png.gif; our default file is called 01.jpg you can rename your file to 01 or you can the name of the file.
<h2>  add here artwork information or title:<img src="img/02/02.jpg" border="0" change here the name of your image replacing 02.jpg see in the exemple code that you can use files as .jpg, .png or .gif.

03.html, it’s our exemple for net.art pieces
preview image with link for work
<a href="img/03/index.html"> This link the image to the artist net.art piece to have a full screen experience, just replace the url
<img> image preview of the artwork


net.art
add a Net.art work: add the art files in the artist directory, for this template is img/03/
<div class="embed-netart"> will allow to recognize your content as a net.art
<h2>  add here artwork information or title
<iframe width="800" height="700" frameborder="0" please keep it like this.
src="img/03/index.html"> you can add an iframe preview here, changing the src directory of your preference, keep in mind that you have a link on the image on the top of the page for full experience.


audio
add an Audio .mp3 format; our default file is called audio04.pm3 you can rename your file to audio04 or you can modify the name of the file. 
<div style="float: center"><audio controls> will allow to recominzed your content as a Audio
<source src="img/04/audio04.mp3" type="audio/mpeg"> change the directory of the file here. keep it simple, export your audio always as mp3 05.html,  06.html, 07.html, 08.html, 09.html, 10.html, are blank pages with our default layout, they’re waiting for your artist content, keep in mind that we create a folder directory for each artist, if you have more than 10 artist just create a new folder add their content link it to their html page, and make sure you add in the index page the link to their work page.

#almost ready

check all your website!! links, content, and so on, before you copy all this content in your USB key. remember do no mistakes, you need that everything works perfect.

copy and paste your edited content folder to your USB Key, and share with the world.

#please note

the css folder contains the style of our layout and the fonts we choose for you, if you have any doubt, just read it! coding it is indeed easy, and we leave you some description to make it even more easy.

always keep a fresh and untouched copy of the content folder, it will help you to replace the code if you make a mistake.

you want to change something but you’re not sure how, google it! or ask us. the solution is there, you just need to dare to ask.

auto_login.html, open_browser.html, are just pages to make sure the user experience on all devices works perfect, just do not touch.

favicon.ico, it is an icon that will appear next to you URL. we have a default one but you can generate a personalize one on photoshop or online, you just need to replace that file and keep the name.

#extras

config folder - you will see this folder only after the installation of the software. it includes:

hostname - changes the URL of your router. by default it will be “the.wrong” but you can add the name of your pavilion or whatever you want.

ssid.txt - changes the name of the Wi-Fi. 

txpower.txt - this is also and advance setting if you don’t know what is for, we strongly recommend you to leave it like that.

channel.txt - change the channel of connection in case you need it, this is also and advance setting if you don’t know what is for, leave it like that.
