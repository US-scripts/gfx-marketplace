Config = {
	MySQL = "oxmysql",
	Framework = "qb",
	ImagePath = "gfx-inventory/nui/assets",
	UseGFXInventory = true,
	OpenCommand = "market",
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
	SellableItems = {
		{
			item = "armor",
			label = "Armor",
			minPrice = 500,
			maxPrice = 2000
		},
		{
			item = "heavyarmor",
			label = "Heavy Armor",
			minPrice = 1000,
			maxPrice = 5000
		},
		{
			item = "weapon_combatmg",
			label = "Combat MG",
			minPrice = 5000,
			maxPrice = 10000
		},
		{
			item = "weapon_heavysniper",
			label = "Heavy Sniper",
			minPrice = 5000,
			maxPrice = 10000
		},
		{
			item = "bandage",
			label = "Bandage",
			minPrice = 100,
			maxPrice = 500
		}
	}
}

if IsDuplicityVersion() then
	Config.SellerLevel = function(license)
		return 1
	end
end
