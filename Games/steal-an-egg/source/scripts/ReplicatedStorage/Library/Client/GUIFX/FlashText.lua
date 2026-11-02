-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Library = game:GetService("ReplicatedStorage"):WaitForChild("Library")
local Client = Library:WaitForChild("Client")
local Settings = require(Client.Settings)
local Functions = require(Library.Functions)
local CacheProperty = require(script.Parent.CacheProperty)
local UIEasingStyle = Settings.UIEasingStyle

return function(p1, p2) --[[ FlashText | Line: 16 | Upvalues: CacheProperty (copy), Functions (copy), UIEasingStyle (copy) ]]
	local v2 = CacheProperty(p1, "TextColor3")

	if v2 == Color3.new(255/255, 255/255, 255/255) then
		p1.TextColor3 = Color3.new(v2.r / 2, v2.g / 2, v2.b / 2)
	else
		p1.TextColor3 = Color3.new(v2.r * 2, v2.g * 2, v2.b * 2)
	end

	Functions.Tween(p1, {
		TextColor3 = v2
	}, { p2 or 1, UIEasingStyle })
end