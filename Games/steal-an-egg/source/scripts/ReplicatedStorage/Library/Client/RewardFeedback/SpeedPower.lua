-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Library = ReplicatedStorage:WaitForChild("Library")
local Client = Library:WaitForChild("Client")

local Asserts = require(Library:WaitForChild("Asserts"))
local ItemRain = require(Client:WaitForChild("RewardFeedback"):WaitForChild("ItemRain"))
local Item = require(Client:WaitForChild("NotificationCmds"):WaitForChild("Item"))
local SpeedPowerItem = require(Library:WaitForChild("Items"):WaitForChild("SpeedPowerItem"))

return {
	Show = function(p1) --[[ Show | Line: 22 | Upvalues: Asserts (copy), SpeedPowerItem (copy), ItemRain (copy), Item (copy) ]]
		Asserts.number(p1)
		assert(p1 > 0, "Expected positive speed reward amount")

		local v2 = SpeedPowerItem():SetAmount((math.round(p1)))

		ItemRain.Play("rbxassetid://99458650446228")
		Item.Bottom({
			Item = v2
		})
	end
}