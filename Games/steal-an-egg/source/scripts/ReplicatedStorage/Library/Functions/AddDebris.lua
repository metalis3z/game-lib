-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Modules = ReplicatedStorage:WaitForChild("Library"):WaitForChild("Modules")
local v1 = require(Modules.LeftistHeap).new(function(p1, p2) --[[ Line: 6 ]]
	return p1 - p2
end)
local t = {}
local v2 = 0

local function onStepped(p1, p2) --[[ onStepped | Line: 13 | Upvalues: v2 (ref), v1 (copy), t (copy), Debris (copy) ]]
	v2 = v2 + p2

	while true do
		local v12, v22 = v1.tryMin()

		if not v12 or v2 < v22 then
			break
		end

		v1.popFast()

		local v3 = t[v22]

		if not v3 then
			continue
		end

		t[v22] = nil

		for i, v in ipairs(v3) do
			if v then
				pcall(function() --[[ Line: 29 | Upvalues: Debris (ref), v (copy) ]]
					Debris:AddItem(v, 0)
				end)
			end
		end
	end
end

RunService.Stepped:Connect(onStepped)

return function(p1, p2) --[[ AddDebris | Line: 40 | Upvalues: v2 (ref), t (copy), v1 (copy) ]]
	assert(if typeof(p1) == "Instance" then true else false, "Instance must be an instance")

	local v22

	if p2 == nil then
		v22 = 0
	else
		assert(type(p2) == "number", "Lifetime must be a number")
		assert(if p2 == p2 then true else false, "Lifetime cannot be NaN")

		local v5 = math.max(0, p2)

		if v5 == (1 / 0) then
			return function() --[[ Line: 52 ]] end
		end

		v22 = v5
	end

	local v6 = v2 + v22
	local v7 = t[v6]

	if v7 then
		table.insert(v7, p1)
	else
		t[v6] = { p1 }
		v1.insert(v6)
	end

	local v8 = false

	return function() --[[ Line: 67 | Upvalues: v8 (ref), t (ref), v6 (copy), p1 (copy) ]]
		if v8 then
			return
		end

		v8 = true

		local v1 = t[v6]

		if not v1 then
			return
		end

		for i = #v1, 1, -1 do
			if v1[i] == p1 then
				table.remove(v1, i)

				break
			end
		end

		if #v1 ~= 0 then
			return
		end

		t[v6] = nil
	end
end