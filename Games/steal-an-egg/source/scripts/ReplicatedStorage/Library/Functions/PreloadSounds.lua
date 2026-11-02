-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ContentProvider = game:GetService("ContentProvider")

local function v1(p1, p2) --[[ insertAsset | Line: 5 | Upvalues: v1 (copy) ]]
	local v12 = type(p2)

	if v12 == "string" then
		table.insert(p1, p2)

		return nil
	end

	if v12 == "number" then
		table.insert(p1, "rbxassetid://" .. tostring(p2))

		return nil
	end

	if v12 ~= "table" then
		error(("Unknown type: %s"):format(v12))
	end

	for k, v in pairs(p2) do
		v1(p1, v)
	end

	return nil
end

return function(...) --[[ Line: 23 | Upvalues: v1 (copy), ContentProvider (copy) ]]
	local v12 = table.pack(...)
	local list = {}

	for i = 1, v12.n do
		v1(list, v12[i])
	end

	local t = {}

	for i, v in ipairs(list) do
		local Sound = Instance.new("Sound")

		Sound.SoundId = v
		table.insert(t, Sound)
	end

	ContentProvider:PreloadAsync(t)

	return nil
end