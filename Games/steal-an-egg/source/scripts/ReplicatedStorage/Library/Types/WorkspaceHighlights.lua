-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local Highlights = workspace:WaitForChild("__OBJECTS"):WaitForChild("Highlights")
local t2 = {
	ByColor = table.freeze({
		White = Highlights:WaitForChild("White"),
		Black = Highlights:WaitForChild("Black"),
		Rainbow = Highlights:WaitForChild("Rainbow")
	})
}
local t3 = {}

t2.SchemaValidation = t3
t3.AllHighlightColors = t.union(t.literal("White"), t.literal("Black"), t.literal("Rainbow"))

return t2