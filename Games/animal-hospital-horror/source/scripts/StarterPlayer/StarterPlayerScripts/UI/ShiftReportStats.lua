local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))
local Info = Lib.UI.Get("RoundStatsDetailed"):WaitForChild("Frame"):WaitForChild("Info")
local paper = Lib.UI.Get("RoundStatsDetailed"):WaitForChild("Photo"):WaitForChild("paper")

local function ResetStats() --[[ ResetStats | Line: 6 | Upvalues: Info (copy) ]]
	Info.score.text.Text = ""
	Info.cash.Text = ""
	Info.localcash.Text = ""
	Info.Parent.AnchorPoint = Vector2.new(1, 0.5)
	Info.Parent.Visible = false
	Info.coins.Visible = false
	Info.Parent.bonus.Visible = false

	for i, v in ipairs(Info.inv:GetChildren()) do
		if v:IsA("Frame") then
			v.value.text.Text = ""
		end
	end
end

local function showBestDoctor(p1) --[[ showBestDoctor | Line: 22 | Upvalues: paper (copy), Lib (copy) ]]
	local v2 = game.Players:FindFirstChild(if p1 then p1 else game.Players.LocalPlayer.Name) or game.Players.LocalPlayer
	local ok, result = pcall(game.Players.GetUserThumbnailAsync, game.Players, v2.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)

	if not ok then
		result = ""
	end

	task.wait(2)
	paper.photo.Player.Image = result
	paper.Info.score.text.Text = v2.DisplayName
	paper.Rotation = 90
	paper.Parent.AnchorPoint = Vector2.new(0, 0.5)
	paper.Parent.Visible = true
	Lib.MusicService.Get("woosh"):Play()
	Lib.TS:Create(paper.Parent, TweenInfo.new(0.5), {
		AnchorPoint = Vector2.new(1, 0.5)
	}):Play()
	Lib.TS:Create(paper, TweenInfo.new(0.8), {
		Rotation = 0
	}):Play()
	task.wait(6)
	Lib.TS:Create(paper.Parent, TweenInfo.new(0.5), {
		AnchorPoint = Vector2.new(0, 0.5)
	}):Play()
end

local function DisplayStats(p1) --[[ DisplayStats | Line: 46 | Upvalues: Lib (copy), ResetStats (copy), Info (copy), showBestDoctor (copy), paper (copy) ]]
	Lib.MusicService.Get("attention"):Play()
	task.wait(0.5)
	ResetStats()
	Info.Parent.Visible = true
	Lib.TS:Create(Info.Parent, TweenInfo.new(0.5), {
		AnchorPoint = Vector2.new(0, 0.5)
	}):Play()
	Lib.MusicService.Get("woosh"):Play()

	local v1 = Info.inv:GetChildren()

	table.sort(v1, function(p1, p2) --[[ Line: 57 ]]
		if not (p1:IsA("Frame") and p2:IsA("Frame")) then
			return false
		end

		return p1.LayoutOrder < p2.LayoutOrder
	end)
	task.wait(2.5)

	for i, v in ipairs(v1) do
		if p1[v.Name] and v:IsA("Frame") then
			local Size = v.value.text.Size

			v.value.text.Text = tostring(p1[v.Name])
			Lib.MusicService.Get("click"):Play()
			task.wait(0.7)
		end
	end

	task.wait(0.5)
	Lib.MusicService.Get("Ding").sound.PlaybackSpeed = p1.Performance.Value or 1
	Lib.MusicService.Get("Ding"):Play()
	Info.score.text.Text = p1.Performance.Name or "-"
	Info.score.text.TextColor3 = p1.Performance.Color or Color3.fromRGB(253, 117, 243)
	task.wait(2)
	Info.cash.Text = "" .. (p1.Cash or 0)
	Info.coins.Visible = true
	Info.localcash.Text = "$" .. (p1.LocalCash or 0)
	Lib.MusicService.Get("money_pickup"):Play()

	if p1.Bonus and p1.Bonus > 0 then
		task.wait(1)
		Info.Parent.bonus.cash.Text = "+$" .. p1.Bonus
		Info.Parent.bonus.Visible = true
		Lib.MusicService.Get("bonus_award"):Play()
		task.wait(1)
	end

	showBestDoctor(p1.BestDoctor)
	Lib.TS:Create(Info.Parent, TweenInfo.new(0.5), {
		AnchorPoint = Vector2.new(1, 0.5)
	}):Play()
	Lib.MusicService.Get("woosh"):Play()
	task.wait(1)
	Info.Parent.Visible = false
	paper.Parent.Visible = false
	Lib.UpdateShiftTracker()
end

Lib.Network:BindEvents({
	DisplayRoundStats = DisplayStats
})
ResetStats()

return {}