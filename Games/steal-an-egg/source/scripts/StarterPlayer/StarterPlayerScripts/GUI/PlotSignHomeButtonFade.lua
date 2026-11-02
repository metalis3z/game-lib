-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local t = {}

t.__index = t

local v1 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

function t.new(p1) --[[ new | Line: 33 | Upvalues: t (copy), Trove (copy) ]]
	local Home = p1:FindFirstChild("Home")

	assert(Home ~= nil, "YourBase.Home must exist")
	assert(Home:IsA("ImageButton"), "YourBase.Home must be an ImageButton")

	local v4 = setmetatable({}, t)

	v4._activeTween = nil
	v4._home = Home
	v4._revision = 0
	v4._trove = Trove.new()
	v4._visible = nil
	v4._yourBase = p1

	return v4
end
function t.SetVisible(p1, p2) --[[ SetVisible | Line: 53 | Upvalues: TweenService (copy), v1 (copy) ]]
	if p1._visible == p2 then
		return
	end

	p1._visible = p2
	p1._revision = p1._revision + 1

	local _revision = p1._revision

	p1._trove:Clean()

	if p2 then
		p1._yourBase.Enabled = true
	end

	local t = {}

	t.ImageTransparency = if p2 then 0 else 1

	local v4 = TweenService:Create(p1._home, v1, t)

	p1._activeTween = v4
	p1._trove:Add(function() --[[ Line: 71 | Upvalues: p1 (copy), v4 (copy) ]]
		if p1._activeTween ~= v4 then
			return
		end

		v4:Cancel()
		p1._activeTween = nil
	end)
	p1._trove:Add(v4.Completed:Connect(function(p12) --[[ Line: 77 | Upvalues: p1 (copy), _revision (copy), v4 (copy), p2 (copy) ]]
		if p1._revision ~= _revision or p1._activeTween ~= v4 then
			return
		end

		p1._activeTween = nil

		if p12 ~= Enum.PlaybackState.Completed or p2 then
			return
		end

		p1._yourBase.Enabled = false
	end))
	v4:Play()
end
function t.Destroy(p1) --[[ Destroy | Line: 90 ]]
	p1._revision = p1._revision + 1
	p1._trove:Destroy()
end

return t