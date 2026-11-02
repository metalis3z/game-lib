-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local SoundService = game:GetService("SoundService")
local IDSReupload = require(script.Parent.IDSReupload)
local t = {}
local t2 = {}
local t3 = {}
local t4 = {}
local __ProbeController = Instance.new("AnimationController")

__ProbeController.Name = "__ProbeController"
__ProbeController.Parent = workspace

local Animator = Instance.new("Animator")

Animator.Parent = __ProbeController

local function assetIdFromUrl(p1) --[[ assetIdFromUrl | Line: 16 ]]
	if not p1 or p1 == "" then
		return nil
	end

	local v1 = string.match(p1, "(%d+)%s*$")
	local v2 = if v1 then v1 else string.match(p1, "(%d+)")

	if v2 then
		return tonumber(v2)
	end

	return nil
end

local function tryPlaySoundById(p1) --[[ tryPlaySoundById | Line: 31 | Upvalues: SoundService (copy), t (copy), t2 (copy) ]]
	local Sound = Instance.new("Sound")

	Sound.Name = "__ProbeSound_" .. tostring(p1)
	Sound.SoundId = "rbxassetid://" .. p1
	Sound.Volume = 0
	Sound.Parent = SoundService

	if pcall(function() --[[ Line: 38 | Upvalues: Sound (copy) ]]
		Sound:Play()
	end) then
		table.insert(t, p1)
	else
		table.insert(t2, p1)
	end

	pcall(function() --[[ Line: 47 | Upvalues: Sound (copy) ]]
		Sound:Stop()
	end)
	Sound:Destroy()
end

local function tryPlayAnimationById(p1) --[[ tryPlayAnimationById | Line: 53 | Upvalues: Animator (copy), t3 (copy), t4 (copy) ]]
	local Animation = Instance.new("Animation")

	Animation.Name = "__ProbeAnim_" .. tostring(p1)
	Animation.AnimationId = "rbxassetid://" .. p1

	local ok, result = pcall(function() --[[ Line: 58 | Upvalues: Animator (ref), Animation (copy) ]]
		return Animator:LoadAnimation(Animation)
	end)

	if ok and result then
		pcall(function() --[[ Line: 64 | Upvalues: result (copy) ]]
			result:Play(0, 1, 1)
		end)
		table.insert(t3, p1)
		pcall(function() --[[ Line: 68 | Upvalues: result (copy) ]]
			result:Stop(0)
		end)
		result:Destroy()
	else
		table.insert(t4, p1)
	end

	Animation:Destroy()
end

for i, v in ipairs(IDSReupload) do
	if typeof(v) == "number" then
		tryPlaySoundById(v)
		tryPlayAnimationById(v)
	end
end

for i, v in ipairs(game:GetDescendants()) do
	local v1, v2

	if v and (v.Parent and v:IsA("Sound")) then
		local SoundId = v.SoundId

		if SoundId and SoundId ~= "" then
			local v3 = string.match(SoundId, "(%d+)%s*$")
			local v4 = if v3 then v3 else string.match(SoundId, "(%d+)")

			v1 = if v4 then tonumber(v4) else nil
		else
			v1 = nil
		end

		local v6 = v:Clone()

		v6.Name = "__ProbeClone:" .. v.Name
		v6.Volume = 0
		v6.Parent = SoundService

		if pcall(function() --[[ Line: 97 | Upvalues: v6 (copy) ]]
			v6:Play()
		end) and v1 then
			table.insert(t, v1)
		elseif v1 then
			table.insert(t2, v1)
		end

		pcall(function() --[[ Line: 105 | Upvalues: v6 (copy) ]]
			v6:Stop()
		end)
		v6:Destroy()

		continue
	end

	if v:IsA("Animation") then
		local AnimationId = v.AnimationId

		if AnimationId and AnimationId ~= "" then
			local v7 = string.match(AnimationId, "(%d+)%s*$")
			local v8 = if v7 then v7 else string.match(AnimationId, "(%d+)")

			v2 = if v8 then tonumber(v8) else nil
		else
			v2 = nil
		end

		if v2 then
			local ok, result = pcall(function() --[[ Line: 112 | Upvalues: Animator (copy), v (copy) ]]
				return Animator:LoadAnimation(v)
			end)

			if ok and result then
				pcall(function() --[[ Line: 116 | Upvalues: result (copy) ]]
					result:Play(0, 1, 1)
				end)
				table.insert(t3, v2)
				pcall(function() --[[ Line: 120 | Upvalues: result (copy) ]]
					result:Stop(0)
				end)
				result:Destroy()

				continue
			end

			table.insert(t4, v2)
		end
	end
end

__ProbeController:Destroy()
print("SOUND_OK (" .. #t .. "): " .. table.concat(t, ","))
print("SOUND_ERR (" .. #t2 .. "): " .. table.concat(t2, ","))
print("ANIM_OK (" .. #t3 .. "): " .. table.concat(t3, ","))
print("ANIM_ERR (" .. #t4 .. "): " .. table.concat(t4, ","))

return nil