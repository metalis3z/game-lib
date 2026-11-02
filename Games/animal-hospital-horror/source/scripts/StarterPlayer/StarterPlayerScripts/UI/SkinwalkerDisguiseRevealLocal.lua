local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))
local CS = Lib.CS

local function ApplyDisguiseReveal(p1, p2, ...) --[[ ApplyDisguiseReveal | Line: 5 ]]
	local v1 = p1:GetAttribute(p2)
	local module = v1 and game.ReplicatedStorage:WaitForChild("AnomalyEvents"):WaitForChild("DisguiseReveals"):FindFirstChild(v1)
	local v2 = module and require(module)

	if not v2 then
		return
	end

	v2.Apply(p1, ...)
	p1:SetAttribute(p2 .. "Applied", true)
end

local function UnDoDisguiseReveal(p1, p2, ...) --[[ UnDoDisguiseReveal | Line: 15 ]]
	local v1 = p1:GetAttribute(p2)
	local module = v1 and game.ReplicatedStorage:WaitForChild("AnomalyEvents"):WaitForChild("DisguiseReveals"):FindFirstChild(v1)
	local v2 = module and require(module)

	if not (v2 and p1:GetAttribute(p2 .. "Applied")) then
		return
	end

	v2.UnDo(p1, ...)
	p1:SetAttribute(p2 .. "Applied", nil)
end

Lib.Inject("ApplySkinwalkerDisguiseReveal", function(p1, p2, ...) --[[ Line: 25 | Upvalues: ApplyDisguiseReveal (copy) ]]
	ApplyDisguiseReveal(p1, p2, ...)
	ApplyDisguiseReveal(p1, p2 .. "2", ...)
end)
Lib.Inject("UnDoSkinwalkerDisguiseReveal", function(p1, p2, ...) --[[ Line: 30 | Upvalues: UnDoDisguiseReveal (copy) ]]
	UnDoDisguiseReveal(p1, p2, ...)
	UnDoDisguiseReveal(p1, p2 .. "2", ...)
end)

return {}