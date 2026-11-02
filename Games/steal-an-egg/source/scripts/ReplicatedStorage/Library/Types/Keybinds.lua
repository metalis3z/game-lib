-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	MAXIMUM_CONTROL_KEYS = 2,
	MAXIMUM_STANDARD_KEYS = 1
}

t.MAXIMUM_TOTAL_KEYS = t.MAXIMUM_CONTROL_KEYS + t.MAXIMUM_STANDARD_KEYS
t.MAXIMUM_KEYBINDS = 25
t.KEYBIND_NONE = -1
t.ControlKeys = {
	[Enum.KeyCode.LeftShift] = true,
	[Enum.KeyCode.RightShift] = true,
	[Enum.KeyCode.LeftControl] = true,
	[Enum.KeyCode.RightControl] = true,
	[Enum.KeyCode.LeftAlt] = true,
	[Enum.KeyCode.RightAlt] = true
}
t.StandardKeys = {
	[Enum.KeyCode.Zero] = true,
	[Enum.KeyCode.One] = true,
	[Enum.KeyCode.Two] = true,
	[Enum.KeyCode.Three] = true,
	[Enum.KeyCode.Four] = true,
	[Enum.KeyCode.Five] = true,
	[Enum.KeyCode.Six] = true,
	[Enum.KeyCode.Seven] = true,
	[Enum.KeyCode.Eight] = true,
	[Enum.KeyCode.Nine] = true,
	[Enum.KeyCode.B] = true,
	[Enum.KeyCode.C] = true,
	[Enum.KeyCode.G] = true,
	[Enum.KeyCode.H] = true,
	[Enum.KeyCode.J] = true,
	[Enum.KeyCode.K] = true,
	[Enum.KeyCode.L] = true,
	[Enum.KeyCode.M] = true,
	[Enum.KeyCode.N] = true,
	[Enum.KeyCode.P] = true,
	[Enum.KeyCode.R] = true,
	[Enum.KeyCode.T] = true,
	[Enum.KeyCode.U] = true,
	[Enum.KeyCode.V] = true,
	[Enum.KeyCode.X] = true,
	[Enum.KeyCode.Y] = true,
	[Enum.KeyCode.Z] = true
}
t.AllKeys = {}

for k, v in pairs(t.ControlKeys) do
	t.AllKeys[k] = v
end

for k, v in pairs(t.StandardKeys) do
	t.AllKeys[k] = v
end

t.NameOverrides = {
	[Enum.KeyCode.LeftShift] = "Shift",
	[Enum.KeyCode.RightShift] = "Shift",
	[Enum.KeyCode.LeftControl] = "Ctrl",
	[Enum.KeyCode.RightControl] = "Ctrl",
	[Enum.KeyCode.LeftAlt] = "Alt",
	[Enum.KeyCode.RightAlt] = "Alt",
	[Enum.KeyCode.Zero] = "0",
	[Enum.KeyCode.One] = "1",
	[Enum.KeyCode.Two] = "2",
	[Enum.KeyCode.Three] = "3",
	[Enum.KeyCode.Four] = "4",
	[Enum.KeyCode.Five] = "5",
	[Enum.KeyCode.Six] = "6",
	[Enum.KeyCode.Seven] = "7",
	[Enum.KeyCode.Eight] = "8",
	[Enum.KeyCode.Nine] = "9"
}
t.SupportedItems = {}
t.SupportedItemsMap = {}

for i, v in ipairs(t.SupportedItems) do
	local Item = v.Item
	local v1 = Item.Class.Name

	if not t.SupportedItemsMap[v1] then
		t.SupportedItemsMap[v1] = {}
	end

	t.SupportedItemsMap[v1][Item:StackKey()] = true
end

function t.GetKeysAsEnum(p1) --[[ GetKeysAsEnum | Line: 86 ]]
	local t = {}

	for i, v in ipairs(p1.Keys) do
		table.insert(t, Enum.KeyCode[v])
	end

	return t
end
function t.IsItemSupported(p1) --[[ IsItemSupported | Line: 94 | Upvalues: t (copy) ]]
	local v1 = p1.Class.Name

	if not t.SupportedItemsMap[v1] then
		return false
	end

	return t.SupportedItemsMap[v1][p1:StackKey()] == true
end
function t.IsKeySupported(p1) --[[ IsKeySupported | Line: 103 | Upvalues: t (copy) ]]
	return t.AllKeys[p1] ~= nil
end
function t.MakeNameFromKeys(p1) --[[ MakeNameFromKeys | Line: 107 | Upvalues: t (copy) ]]
	local v1 = table.clone(p1)

	table.sort(v1, function(p1, p2) --[[ Line: 109 | Upvalues: t (ref) ]]
		local v1 = if t.ControlKeys[p1] then 1 else 0
		local v2 = if t.ControlKeys[p2] then 1 else 0

		if v1 == v2 then
			return p1.Name < p2.Name
		end

		return v2 < v1
	end)

	local v2 = ""
	local v3 = #v1

	if v3 == 0 then
		return "<UNBOUND>"
	end

	for i = 1, v3 do
		local v4 = v1[i]

		v2 = v2 .. (t.NameOverrides[v4] or v4.Name)

		if i < v3 then
			v2 = v2 .. "+"
		end
	end

	return v2
end

return t