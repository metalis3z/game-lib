-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(ReplicatedStorage.Library.Types.AssetSizeClassification)

local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local v1 = table.freeze({
	{
		MinimumScale = 45,
		Prefix = "GARGANTUAN",
		RichText = "<font color=\"#FFD700\">GARGANTUAN</font>",
		Color = Color3.fromRGB(255, 215, 0)
	},
	{
		MinimumScale = 25,
		Prefix = "TITANIC",
		RichText = "<font color=\"#9B51E0\">TITANIC</font>",
		Color = Color3.fromRGB(155, 81, 224)
	},
	{
		MinimumScale = 10,
		Prefix = "HUGE",
		RichText = "<font color=\"#2F80ED\">HUGE</font>",
		Color = Color3.fromRGB(47, 128, 237)
	},
	{
		MinimumScale = 5,
		Prefix = "BIG",
		RichText = "<font color=\"#34C759\">BIG</font>",
		Color = Color3.fromRGB(52, 199, 89)
	}
})
local v2 = Log.new()

return {
	Resolve = function(p1) --[[ Resolve | Line: 52 | Upvalues: Asserts (copy), v1 (copy) ]]
		Asserts.number(p1)

		for i, v in ipairs(v1) do
			if v.MinimumScale <= p1 then
				return v
			end
		end

		return nil
	end,
	GetTiers = function() --[[ GetTiers | Line: 63 | Upvalues: v2 (copy), v1 (copy) ]]
		v2:AtTrace():Log("Read shared asset size classification tiers")

		return v1
	end
}