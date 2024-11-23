local uiLoaded, uiOpen = false, false

RegisterNUICallback('purchase', function(data, cb)
	triggerServerCallback('gfx-marketplace:purchase', data, cb)
end)
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
RegisterNUICallback('sell', function(data, cb)
	triggerServerCallback('gfx-marketplace:sell', data, cb)
end)

RegisterNUICallback('remove', function(data, cb)
	triggerServerCallback('gfx-marketplace:remove', data, cb)
end)

function openUI()
	if uiLoaded and not uiOpen then
		local saleItems = getSaleItems()

		SendNUIMessage({
			type = "LOAD_DATA",
			data = {
				user = getPlayerData(),
				saleItems = saleItems
			}
		})

		SendNUIMessage({
			type = "OPEN_UI"
		})

		SetNuiFocus(true, true)

		uiOpen = true
	end
end

RegisterNUICallback('loaded', function()
	print("Marketplace Loaded!")

	SendNUIMessage({
		type = "LOAD_DATA",
		data = {
			config = Config
		}
	})

	uiLoaded = true
end)

RegisterNUICallback('close', function()
	SetNuiFocus(false, false)

	uiOpen = false
end)

RegisterCommand(Config.OpenCommand, function()
	print("Opening Marketplace")
	openUI()
end)
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
CreateThread(function()
	TriggerServerEvent('gfx-marketplace:registerMyInfo')
end)