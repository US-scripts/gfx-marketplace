shared_scripts {
	'config.lua'
}
--[[   /$$    /$$$$$$   /$$$$$$   /$$$$$$        /$$       /$$$$$$$$  /$$$$$$  /$$   /$$  /$$$$$$ 
     /$$$$   /$$__  $$ /$$$_  $$ /$$__  $$      | $$      | $$_____/ /$$__  $$| $$  /$$/ /$$__  $$
    |_  $$  | $$  \ $$| $$$$\ $$| $$  \ $$      | $$      | $$      | $$  \ $$| $$ /$$/ | $$  \__/
      | $$  |  $$$$$$$| $$ $$ $$|  $$$$$$$      | $$      | $$$$$   | $$$$$$$$| $$$$$/  |  $$$$$$     
      | $$   \____  $$| $$\ $$$$ \____  $$      | $$      | $$__/   | $$__  $$| $$  $$   \____  $$
      | $$   /$$  \ $$| $$ \ $$$ /$$  \ $$      | $$      | $$      | $$  | $$| $$\  $$  /$$  \ $$
     /$$$$$$|  $$$$$$/|  $$$$$$/|  $$$$$$/      | $$$$$$$$| $$$$$$$$| $$  | $$| $$ \  $$|  $$$$$$/
     |______/ \______/  \______/  \______/       |________/|________/|__/  |__/|__/  \__/ \______/ 
																							 
 https://discord.gg/aq7wjNZWkX  & https://discord.gg/1909leak 
   https://www.youtube.com/watch?v=bSN7Hhfk2QU    ]]
server_scripts {
	'server/mysql.lua',
	'server/functions.lua',
	'server/main.lua'
}

client_scripts {
	'client/utils.lua',
	'client/main.lua'
}

ui_page 'ui/index.html'

files {
	"ui/fonts/*.ttf",
	"ui/assets/*.png",
	"ui/assets/*.css",
	"ui/assets/*.js",
	"ui/index.html"
}

escrow_ignore {
    "config.lua"
}

game 'gta5'
author 'atiysu & frosty'
fx_version 'cerulean'
