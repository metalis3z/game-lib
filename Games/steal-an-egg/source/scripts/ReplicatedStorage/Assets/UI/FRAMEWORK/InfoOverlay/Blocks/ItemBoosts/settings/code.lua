-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	Scale = "rbxassetid://101135911625338",
	Mutations = "rbxassetid://134360845365275",
	Luck = "rbxassetid://95919886597863",
	Strength = "rbxassetid://126374550699444"
}
local t2 = {
	Scale = Color3.fromRGB(255, 0, 0),
	Mutations = Color3.fromRGB(0, 255, 255),
	Luck = Color3.fromRGB(0, 255, 0),
	Strength = Color3.fromRGB(255, 255, 0)
}
local t3 = {
	Scale = "Size Luck",
	Mutations = "Mutations Luck",
	Luck = "Poop Luck",
	Strength = "Push Strength"
}

return function(p1, p2, p3, p4) --[[ Line: 23 | Upvalues: t (copy), t2 (copy), t3 (copy) ]]
	local v3 = assert(t[p3], "Invalid statsType: " .. tostring(p3))
	local v6 = assert(t2[p3], "Invalid statsType: " .. tostring(p3))
	local v7 = if type(p4) == "number" and p4 < 0 then "" else "+"

	p1.boost.TextColor3 = v6
	p1.boost.Text = if type(p4) == "string" and p4 then p4 else string.format(("%*%%d%%%% %%s"):format(v7), p4, t3[p3] or p3)
	p1.icon.Image = v3
end