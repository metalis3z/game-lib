
local t = {}
local LocalPlayer = game:GetService("Players").LocalPlayer
local t2 = {}

function t.EffectiveCooldown(p1) --[[ EffectiveCooldown | Line: 31 | Upvalues: LocalPlayer (copy) ]]
	local v1 = LocalPlayer:GetAttribute("AdminCooldownEffective")

	if typeof(v1) == "number" then
		return v1
	end

	return 240
end
function t.Check(p1, p2) --[[ Check | Line: 42 | Upvalues: t2 (copy) ]]
	local v1 = p1:EffectiveCooldown()

	if v1 <= 0 then
		return true, 0
	end

	local v2 = t2[p2 or "default"]

	if v2 == nil then
		return true, 0
	end

	local v3 = os.clock() - v2

	if v1 <= v3 then
		return true, 0
	end

	return false, math.ceil(v1 - v3)
end
function t.Mark(p1, p2) --[[ Mark | Line: 56 | Upvalues: t2 (copy) ]]
	t2[p2 or "default"] = os.clock()
end

local v1 = nil

local function showNotif(p1, p2) --[[ showNotif | Line: 64 | Upvalues: v1 (ref) ]]
	if not v1 then
		local AdminPanel = script:FindFirstAncestor("AdminPanel")
		local v12 = if AdminPanel then AdminPanel:FindFirstChild("NotifModule") else AdminPanel

		if v12 then
			local ok, result = pcall(require, v12)

			if ok then
				v1 = result
			end
		end
	end

	if not v1 then
		return
	end

	v1(p1, p2 ~= false)
end

function t.Try(p1, p2) --[[ Try | Line: 82 | Upvalues: showNotif (copy) ]]
	local v1, v2 = p1:Check(p2)

	if v1 then
		p1:Mark(p2)

		return true
	end

	showNotif(if v2 >= 60 then string.format("Admin cooldown: %d:%02d left", math.floor(v2 / 60), v2 % 60) else string.format("Admin cooldown: %ds left", v2), false)

	return false
end

return t