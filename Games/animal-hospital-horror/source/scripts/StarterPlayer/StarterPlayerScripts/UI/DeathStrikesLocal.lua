local Lib = require(game.ReplicatedStorage.Lib)
local Frame = Lib.UI.Get("Strikes"):WaitForChild("Frame")
local v1 = game.Players:GetAttribute("DeathCount") or 0
local v2 = 0

local function ChangeGroupTransparency(p1, p2, p3) --[[ ChangeGroupTransparency | Line: 9 | Upvalues: Lib (copy) ]]
	Lib.UI.ChangeGroupTransparency(p1, p2, p3)
end

local function UpdateStrikes() --[[ UpdateStrikes | Line: 13 | Upvalues: Frame (copy), Lib (copy), v1 (ref), v2 (ref) ]]
	local _ = game.Players:GetAttribute("DeathCount") or 0

	Lib.UI.ChangeGroupTransparency(Frame, 0, 0.48)
	task.wait(0.5)

	local v22 = game.Players:GetAttribute("DeathCount") or 0
	local v3 = Frame.strikes:FindFirstChild((tostring(v22)))

	if v22 ~= v1 then
		v1 = v22

		if v3 then
			v3.dead.Visible = true
			v3.strikes.Visible = true
			v3:SetAttribute("OriginalImageTransparency", v3.ImageTransparency)
			v3.ImageTransparency = 1
			task.spawn(Lib.ShakeImage, v3.dead, 1.2, 0.05)
		end

		Lib.MusicService.Get("basebreak"):Play()
		Lib.MusicService.Get("Door Break 1"):Play()
	end

	if v2 > 0 then
		v2 = 6

		return
	end

	v2 = 6

	while v2 > 0 do
		v2 = v2 - 0.1
		task.wait(0.1)
	end

	if v1 ~= game.Players:GetAttribute("MAX_DeathCount") then
		Lib.UI.ChangeGroupTransparency(Frame, 1, 0.5)
	end
end

game.Players:GetAttributeChangedSignal("DeathCount"):Connect(UpdateStrikes)
Lib.Network:BindEvents({
	ShowDeathStrikesUI = function() --[[ ShowDeathStrikesUI | Line: 55 | Upvalues: UpdateStrikes (copy) ]]
		UpdateStrikes()
	end,
	ResetDeathStrikes = function() --[[ ResetDeathStrikes | Line: 58 | Upvalues: v1 (ref), Frame (copy), UpdateStrikes (copy) ]]
		v1 = 0

		for i = 1, game.Players:GetAttribute("MAX_DeathCount") or 3 do
			local v12 = Frame.strikes:FindFirstChild((tostring(i)))

			if v12 then
				v12.dead.Visible = false
				v12.strikes.Visible = false
				v12.ImageTransparency = v12:GetAttribute("OriginalImageTransparency") or 0
			end
		end

		UpdateStrikes()
	end
})

return {}