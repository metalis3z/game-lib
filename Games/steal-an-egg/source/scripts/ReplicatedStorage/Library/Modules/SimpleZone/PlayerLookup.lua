-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local t = {}
local t2 = {}

local function handleCharacterUpdate(p1, p2) --[[ handleCharacterUpdate | Line: 6 | Upvalues: t2 (copy), t (copy) ]]
	for v1, v2 in t2[p1] do
		v2:Disconnect()
	end

	for v3, v4 in t do
		if v4 == p1 then
			t[v3] = nil
		end
	end

	for v5, v6 in p2:GetDescendants() do
		if v6:IsA("BasePart") then
			t[v6] = p1
		end
	end

	local function f8(p12) --[[ Line: 26 | Upvalues: t (ref), p1 (copy) ]]
		if p12:IsA("BasePart") then
			t[p12] = p1
		end
	end

	table.insert(t2[p1], p2.DescendantAdded:Connect(f8))

	local function f10(p1) --[[ Line: 36 | Upvalues: t (ref) ]]
		if p1:IsA("BasePart") then
			t[p1] = nil
		end
	end

	table.insert(t2[p1], p2.DescendantRemoving:Connect(f10))
end

local function onPlayerAdded(p1) --[[ onPlayerAdded | Line: 45 | Upvalues: t2 (copy), handleCharacterUpdate (copy) ]]
	t2[p1] = {}
	p1.CharacterAdded:Connect(function(p12) --[[ Line: 48 | Upvalues: handleCharacterUpdate (ref), p1 (copy) ]]
		handleCharacterUpdate(p1, p12)
	end)

	if not p1.Character then
		return
	end

	handleCharacterUpdate(p1, p1.Character)
end

local function onPlayerRemoving(p1) --[[ onPlayerRemoving | Line: 57 | Upvalues: t2 (copy), t (copy) ]]
	for v1, v2 in t2[p1] do
		v2:Disconnect()
	end

	t2[p1] = nil

	for v3, v4 in t do
		if v4 == p1 then
			t[v3] = nil
		end
	end
end

return {
	characterObjects = t,
	start = function() --[[ start | Line: 72 | Upvalues: Players (copy), onPlayerAdded (copy), onPlayerRemoving (copy) ]]
		local v1 = Players.PlayerAdded:Connect(onPlayerAdded)
		local v2 = Players.PlayerRemoving:Connect(onPlayerRemoving)

		for v3, v4 in Players:GetPlayers() do
			onPlayerAdded(v4)
		end

		return v1, v2
	end,
	onPlayerAdded = onPlayerAdded,
	onPlayerRemoving = onPlayerRemoving
}