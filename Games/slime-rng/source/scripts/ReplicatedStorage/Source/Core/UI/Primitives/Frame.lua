-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Frame, time of decompilation: Sun May  3 10:11:00 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Vide = require(ReplicatedStorage.Packages.Vide)

require(ReplicatedStorage.Source.Core.UI.UITypes)

return function(p1) -- line: 6
	-- upvalues: Vide (copy)
	p1.BackgroundTransparency = p1.BackgroundTransparency or 1

	return Vide.create("Frame")(p1)
end
