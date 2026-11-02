-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")

local function benchmarkCpu() --[[ benchmarkCpu | Line: 3 ]]
	local v1 = os.clock()
	local v2 = v1

	for i = 1, 1000000 do
		v2 = v2 + v2 - i
	end

	local v3 = os.clock()

	if v2 == -1 then
		return -1
	end

	return v3 - v1
end

local function measureCpu() --[[ measureCpu | Line: 13 ]]
	local v2 = os.clock()

	for i = 1, 1000000 do
		v2 = v2 + v2 - i
	end

	os.clock()
	task.wait()

	local v4 = os.clock()

	for j = 1, 1000000 do
		v4 = v4 + v4 - j
	end

	os.clock()
	task.wait()

	local v5 = os.clock()
	local v6 = v5

	for k = 1, 1000000 do
		v6 = v6 + v6 - k
	end

	local v8 = if v6 == -1 then -1 else os.clock() - v5
	local v9 = os.clock()
	local v10 = v9

	for n = 1, 1000000 do
		v10 = v10 + v10 - n
	end

	local v13 = v8 + (if v10 == -1 then -1 else os.clock() - v9)
	local v14 = os.clock()
	local v15 = v14

	for m = 1, 1000000 do
		v15 = v15 + v15 - m
	end

	local v18 = v13 + (if v15 == -1 then -1 else os.clock() - v14)
	local v19 = os.clock()
	local v20 = v19

	for i = 1, 1000000 do
		v20 = v20 + v20 - i
	end

	return 0.01798125 / (v18 + (if v20 == -1 then -1 else os.clock() - v19)) / 4
end

local function isLoaded() --[[ isLoaded | Line: 21 | Upvalues: Players (copy) ]]
	if not game:IsLoaded() then
		return false
	end

	local LocalPlayer = Players.LocalPlayer

	if LocalPlayer and (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")) then
		return LocalPlayer:GetAttribute("__LOADED") and true or false
	end

	return false
end

local v1 = nil
local v2 = nil

return function() --[[ Line: 37 | Upvalues: v1 (ref), v2 (ref), Players (copy), measureCpu (copy) ]]
	if v1 then
		return v1
	end

	if v2 then
		if os.clock() - v2 < 10 then
			return nil
		end

		local v12 = measureCpu()

		v1 = v12

		return v12
	end

	local v22

	if game:IsLoaded() then
		local LocalPlayer = Players.LocalPlayer

		v22 = if LocalPlayer and (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")) then LocalPlayer:GetAttribute("__LOADED") and true or false else false
	else
		v22 = false
	end

	if not v22 then
		return nil
	end

	v2 = os.clock()

	return nil
end