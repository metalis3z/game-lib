-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local Rarity = require(ReplicatedStorage.Directory.Rarity)
local t2 = {
	AreaNameExists = function(p1) --[[ Line: 13 ]]
		error("unimplemented")
	end,
	AssetDropTableEntry = t.array(t.union(t.string, t.number))
}

t2.AreaConfig = t.interface({
	_id = t.string,
	DisplayName = t.string,
	Emoji = t.string,
	Icon = t.string,
	DropTable = t.array(t2.AssetDropTableEntry),
	GuardId = t.string,
	IndexBatGearId = t.string,
	Rarity = Rarity.Types.DefaultConfig
})

return t2