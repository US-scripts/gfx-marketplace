if Config.Framework == "qb" then
	Core.Functions.CreateCallback('gfx-marketplace:getSaleItems', function(src, cb)
		cb(getSaleItems())
	end)

	Core.Functions.CreateCallback('gfx-marketplace:purchase', function(src, cb, data)
		cb(purchaseMarketItem(src, data.item, data.count), getSaleItems())
	end)

	Core.Functions.CreateCallback('gfx-marketplace:sell', function(src, cb, data)
		cb(sellMarketItem(src, data.item, data.price, data.count), getSaleItems())
	end)

	Core.Functions.CreateCallback('gfx-marketplace:remove', function(src, cb, data)
		cb(removeMarketItem(src, data.item), getSaleItems())
	end)

	Core.Functions.CreateCallback('gfx-marketplace:getInventoryItems', function(src, cb, data)
		cb(exports["gfx-inventory"]:GetInventory(src, "inventory"))
	end)
elseif Config.Framework == "esx" then
	Core.RegisterServerCallback('gfx-marketplace:getSaleItems', function(src, cb)
		cb(getSaleItems())
	end)

	Core.RegisterServerCallback('gfx-marketplace:purchase', function(src, cb, data)
		cb(purchaseMarketItem(src, data.item, data.count), getSaleItems())
	end)

	Core.RegisterServerCallback('gfx-marketplace:sell', function(src, cb, data)
		cb(sellMarketItem(src, data.item, data.price, data.count), getSaleItems())
	end)

	Core.RegisterServerCallback('gfx-marketplace:remove', function(src, cb, data)
		cb(removeMarketItem(src, data.item), getSaleItems())
	end)

	Core.RegisterServerCallback('gfx-marketplace:getInventoryItems', function(src, cb, data)
		cb(exports["gfx-inventory"]:GetInventory(src, "inventory"))
	end)
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