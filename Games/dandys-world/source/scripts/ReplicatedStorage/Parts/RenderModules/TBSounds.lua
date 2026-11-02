--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- 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

-- https://lua.expert/
local t = {}
local TweenService = game:GetService("TweenService")
local t2 = { "Idle_Circling_Loop", "Attack2_Gnawing_Loop", "FloppingOnFloor_Loop" }
local v1 = setmetatable({}, {
	__mode = "k"
})

local function findSound(p1, p2) --[[ findSound | Line: 42 | Upvalues: v1 (copy) ]]
	if not p1 then
		return nil
	end

	local v12 = p1:FindFirstChild(p2, true)

	if v12 and v12:IsA("Sound") then
		return v12
	end

	local v2 = v1[p1]

	if not v2 then
		v2 = {}
		v1[p1] = v2
	end

	if v2[p2] then
		return nil
	end

	v2[p2] = true
	warn(("[TBSounds] Sound %q not found under %s"):format(p2, (tostring(p1))))

	return nil
end

t.findSound = findSound
function t.playOneShot(p1, p2) --[[ playOneShot | Line: 59 | Upvalues: findSound (copy) ]]
	local v1 = findSound(p1, p2)

	if v1 then
		v1.Looped = false
		v1:Play()
	end
end
function t.stop(p1, p2) --[[ stop | Line: 67 | Upvalues: findSound (copy) ]]
	local v1 = findSound(p1, p2)

	if not (v1 and v1.IsPlaying) then
		return
	end

	v1:Stop()
end
function t.setLoop(p1, p2) --[[ setLoop | Line: 75 | Upvalues: t2 (copy), findSound (copy) ]]
	if not p1 then
		return
	end

	for i, v in ipairs(t2) do
		if v == p2 then
			local v1 = findSound(p1, v)

			if v1 then
				v1.Looped = true

				if not v1.IsPlaying then
					v1:Play()
				end
			end

			continue
		end

		local v2 = findSound(p1, v)

		if v2 and v2.IsPlaying then
			v2:Stop()
		end
	end

	local v3 = findSound(p1, "PassiveOverlay_Loop")

	if not v3 then
		return
	end

	if p2 == nil then
		v3.Looped = true

		if not v3.IsPlaying then
			v3:Play()
		end
	else
		if not v3.IsPlaying then
			return
		end

		v3:Stop()
	end
end
function t.fadeLoop(p1, p2, p3, p4) --[[ fadeLoop | Line: 105 | Upvalues: findSound (copy), TweenService (copy) ]]
	local v1 = findSound(p1, p2)

	if v1 then
		local v2 = TweenService:Create(v1, TweenInfo.new(p3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Volume = p4
		})

		v2:Play()

		return v2
	end

	return nil
end

return t