local nukesInQueue = 0
local currentlyNuking = false
local rs = game:GetService("ReplicatedStorage")
local Players = game.Players

local function nuke()
	currentlyNuking = true
	local tweenInf = TweenInfo.new(7.5)
	local tweenInf2 = TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tweenInf3 = TweenInfo.new(6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tweenInf4 = TweenInfo.new(.5)
	rs.Sounds.TacticalNuke:Play()
	wait(2.5)
	game:GetService("TweenService"):Create(game.Lighting.Red, tweenInf4, {TintColor = Color3.new(1, 0.32549, 0.337255)}):Play()
	wait(.5)
	game:GetService("TweenService"):Create(game.Lighting.Red, tweenInf4, {TintColor = Color3.new(1, 1, 1)}):Play()
	wait(.5)
	game:GetService("TweenService"):Create(game.Lighting.Red, tweenInf4, {TintColor = Color3.new(1, 0.32549, 0.337255)}):Play()
	wait(.5)
	game:GetService("TweenService"):Create(game.Lighting.Red, tweenInf4, {TintColor = Color3.new(1, 1, 1)}):Play()
	wait(.5)
	game:GetService("TweenService"):Create(game.Lighting.Red, tweenInf4, {TintColor = Color3.new(1, 0.32549, 0.337255)}):Play()
	wait(.5)
	game:GetService("TweenService"):Create(game.Lighting.Red, tweenInf4, {TintColor = Color3.new(1, 1, 1)}):Play()
	wait(.25)
	game.Lighting.Red.TintColor = Color3.new(1, 0.666667, 0)
	game.Lighting.NukeBloom.Threshold = 0
	game.Lighting.Red.Brightness = 0.5
	rs.Sounds.TacticalNuke:Stop()
	rs.Sounds.Explosion:Play()
	for i, plrv in pairs(Players:GetChildren()) do
		local stageObjects = {}

		local CollectionService = game:GetService("CollectionService")

		for _, cp in pairs(CollectionService:GetTagged("Checkpoint")) do
			local stage = cp:GetAttribute("Stage")

			if not stageObjects[stage] then
				stageObjects[stage] = {}
			end

			table.insert(stageObjects[stage], cp)
		end
		game.Players:FindFirstChild(plrv.Name):SetAttribute("Safe", true)
		game.Players:FindFirstChild(plrv.Name):SetAttribute("Safe2", .5)
		rs.RemoteEvents.clientTP:FireClient(plrv, stageObjects[plrv.leaderstats.Stage.Value])
	end

	task.wait(1)
	game:GetService("TweenService"):Create(game.Lighting.Red, tweenInf, {Brightness = 0}):Play()
	game:GetService("TweenService"):Create(game.Lighting.Red, tweenInf, {TintColor = Color3.new(1,1,1)}):Play()
	game:GetService("TweenService"):Create(game.Lighting.NukeBloom, tweenInf, {Threshold = 4}):Play()

	task.wait(3)
	if nukesInQueue >= 1 then
		nukesInQueue -= 1
		nuke()
	else
		currentlyNuking = false
	end
end

script.AddToQueue.Event:Connect(function()
	if currentlyNuking == false then
		nuke()
	else
		nukesInQueue += 1
	end
end)