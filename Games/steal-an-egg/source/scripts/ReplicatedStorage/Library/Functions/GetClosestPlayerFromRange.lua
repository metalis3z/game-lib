-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

return function(p1, p2, p3) --[[ Line: 17 | Upvalues: Asserts (copy), Players (copy) ]]
	Asserts.Player(p1)
	Asserts.number(p2)

	local Character = p1.Character
	local v1 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

	if not v1 then
		return nil, Vector3.new(1, 0, 0)
	end

	local t = {}

	for i, v in ipairs(Players:GetPlayers()) do
		if v ~= p1 then
			local Character2 = v.Character
			local v2 = if Character2 then Character2:FindFirstChild("HumanoidRootPart") else Character2

			if v2 then
				local Magnitude = (v2.Position - v1.Position).Magnitude

				if Magnitude <= p2 then
					table.insert(t, {
						player = v,
						delta = v2.Position - v1.Position,
						distance = Magnitude
					})
				end
			end
		end
	end

	table.sort(t, function(p1, p2) --[[ Line: 46 ]]
		return p1.distance < p2.distance
	end)

	local v3 = if p3 then math.max(0, (math.floor(p3))) else 1

	if v3 <= 1 then
		local v5 = t[1]

		if v5 then
			return v5.player, v5.delta
		end

		return nil, Vector3.new(1, 0, 0)
	end

	local t2 = {}

	for i = 1, math.min(v3, #t) do
		t2[i] = t[i]
	end

	return t2
end