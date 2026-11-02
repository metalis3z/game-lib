-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local Styles = script:WaitForChild("Styles")

t.atlases = { "rbxassetid://90796024556603", "rbxassetid://81203551816672", "rbxassetid://127088239430032" }
t.font = {
	information = {
		family = "Super Mario 64",
		useEnums = true,
		styles = { "Regular" },
		sizes = {
			96,
			60,
			48,
			42,
			36,
			32,
			28,
			24,
			18,
			14,
			12,
			11,
			10,
			9,
			8
		}
	},
	styles = {}
}

for v1, v2 in t.font.information.styles do
	t.font.styles[v2] = require(Styles:WaitForChild(v2))
end

return t