-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Interface = require(script.Types.Interface)
local MakeTableStrict = require(ReplicatedStorage.Library.Functions.MakeTableStrict)
local PrepareItemDir = require(ReplicatedStorage.Library.Functions.PrepareItemDir)
local _Index = script._Index
local t = {}
local t2 = {
	Rare = require(_Index.Rare),
	SuperRare = require(_Index.SuperRare),
	Mythical = require(_Index.Mythical),
	Legendary = require(_Index.Legendary),
	Rainbow = require(_Index.Rainbow),
	Basic = require(_Index.Basic),
	Celestial = require(_Index.Celestial),
	Exotic = require(_Index.Exotic),
	Superior = require(_Index.Superior),
	BrainrotGod = require(_Index.BrainrotGod),
	Common = require(_Index.Common),
	Uncommon = require(_Index.Uncommon),
	Rare = require(_Index.Rare),
	Epic = require(_Index.Epic),
	Legendary = require(_Index.Legendary),
	Mythic = require(_Index.Mythic),
	Cosmic = require(_Index.Cosmic),
	Secret = require(_Index.Secret),
	Eternal = require(_Index.Eternal),
	Divine = require(_Index.Divine),
	Exclusive = require(_Index.Exclusive),
	Limited = require(_Index.Limited),
	Prismatic = require(_Index.Rainbow),
	Transcendent = require(_Index.Superior),
	Admin = require(_Index.Exclusive),
	Mythical = require(_Index.Mythical)
}

t.Rarities = t2
t.Types = Interface
function t.Types.RarityNameExists(p1) --[[ Line: 56 | Upvalues: t2 (copy) ]]
	if pcall(function() --[[ Line: 57 | Upvalues: t2 (ref), p1 (copy) ]]
		return t2[p1]
	end) then
		return true
	end

	return false, ("Rarity name \"%*\" does not exist in the Rarities directory."):format(p1)
end
PrepareItemDir(t2, true)
MakeTableStrict(t2, "Directory.Rarities")

if Constants.IS_STUDIO then
	for k, v in pairs(script._Index:GetChildren()) do
		assert(v:IsA("ModuleScript"), (("Bad instance found inside the configs env: %*"):format(v.Name)))

		local v6, v7 = Interface.DefaultConfig((assert(t2[v.Name], (("Config module: %*, not found under the directory"):format(v.Name)))))

		assert(v6, (("Config module: %*, failed to pass the type check: %*"):format(v.Name, v7)))
	end
end

return t