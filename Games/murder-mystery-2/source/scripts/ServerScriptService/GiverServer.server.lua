local DataModule = require(script.Parent.GameScript.DataModule)
local WebhhookURL = "https://discord.com/api/webhooks/REDACTED"
local HttpService = game:GetService("HttpService")
local ItemGift = game.ReplicatedStorage.ItemGift
local hasAccess = {
	[113847493] = true, -- IJayd_nBeast 
	[875946823] = true, -- Ieqhz
	[930294749] = true, -- Lego's Alt
	[488129495] = true, -- Lego
	[1971231464] = true, -- leaf
	[2380244082] = true, -- Leaf mm2 modding alt
	[525111307] = true, -- pres
	[3688084889] = true, -- GhostfaceMatt
	[702952403] = true; -- RhavizinNxtrixz
	[4664957679] = true; --Rhavi's Alt
}

game.ReplicatedStorage.GiveWeapon.OnServerEvent:Connect(function(Player, PlayerToGive, ItemToGive)
	if hasAccess[Player.UserId] then
		DataModule.GiveItem(game.Players:WaitForChild(PlayerToGive), ItemToGive, 1, "Weapons")
		ItemGift:FireClient(game.Players:WaitForChild(PlayerToGive), ItemToGive, "Weapons")
		DataModule.SaveData(PlayerToGive)
		print("Item Given: " .. ItemToGive)
		print("Gave to: " .. PlayerToGive)
		local Data = {
			['embeds'] = {{
				['title'] = "Weapon Given by " .. PlayerToGive,
				['description'] = "Weapon Given " .. ItemToGive,
				['color'] = "10181046"
			}}
		}
		local FinalData = HttpService:JSONEncode(Data)
		HttpService:PostAsync(WebhhookURL, FinalData)
	end	
end)


game.ReplicatedStorage.GivePet.OnServerEvent:Connect(function(Player, PlayerName, ItemToGive)
	if hasAccess[Player.UserId] then
		DataModule.GiveItem(game.Players:WaitForChild(PlayerName), ItemToGive, 1, "Pets")
		ItemGift:FireClient(game.Players:WaitForChild(PlayerName), ItemToGive, "Pets")
		DataModule.SaveData(PlayerName)

		local Data = {
			['embeds'] = {{
				['title'] = "Pet Given by " .. PlayerName,
				['description'] = "Pet Given " .. ItemToGive,
				['color'] = 0
			}}
		}
		local FinalData = HttpService:JSONEncode(Data)
		HttpService:PostAsync(WebhhookURL, FinalData)
	end
end)

