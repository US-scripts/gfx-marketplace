local Core = Config.Framework == "qb" and exports["qb-core"]:GetCoreObject() or exports["es_extended"]:getSharedObject()
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
function getPlayerData()
	local playerData = (Config.Framework == "qb" and Core.Functions.GetPlayerData() or Core.GetPlayerData())
	if Config.UseGFXInventory then
		local p = promise:new()
		if Config.Framework == "qb" then
			Core.Functions.TriggerCallback('gfx-marketplace:getInventoryItems', function(saleItems)
				playerData.items = saleItems
				p:resolve(playerData)
			end)
		elseif Config.Framework == "esx" then
			Core.TriggerServerCallback('gfx-marketplace:getInventoryItems', function(saleItems)
				playerData.inventory = saleItems
				p:resolve(playerData)
			end)
		end
		local pdata =Citizen.Await(p)
		print(json.encode(pdata))
		return pdata
	end
	return playerData
end

function getSaleItems()
	local items

	if Config.Framework == "qb" then
		Core.Functions.TriggerCallback('gfx-marketplace:getSaleItems', function(saleItems)
			items = saleItems
		end)
	elseif Config.Framework == "esx" then
		Core.TriggerServerCallback('gfx-marketplace:getSaleItems', function(saleItems)
			items = saleItems
		end)
	end

	while not items do
		Wait(50)
	end

	return items
end

function triggerServerCallback(name, data, cb)
	if Config.Framework == "qb" then
		Core.Functions.TriggerCallback(name, function(response, saleItems)
			if response.status then
				SendNUIMessage({
					type = "LOAD_DATA",
					data = {
						user = getPlayerData(),
						saleItems = saleItems
					}
				})
			end

			cb(response)
		end, data)
	elseif Config.Framework == "esx" then
		Core.TriggerServerCallback(name, function(response, saleItems)
			if response.status then
				SendNUIMessage({
					type = "LOAD_DATA",
					data = {
						user = getPlayerData(),
						saleItems = saleItems
					}
				})
			end

			cb(response)
		end, data)
	end
end
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