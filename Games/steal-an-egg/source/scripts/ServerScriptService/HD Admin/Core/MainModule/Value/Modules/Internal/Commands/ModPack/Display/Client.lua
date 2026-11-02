--!strict
-- LOCAL
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)
local Players = game:GetService("Players")
local getHead = CommandAPI.getHead


-- CLIENT COMMANDS
local clientCommands: CommandAPI.ClientCommands = {

	--------------------
	{
		name = "Ping",
		run = function(task: CommandAPI.Task, hello)
			local startTime = tick()
			local randomValue = math.random(1,1000)
			task.server:replicate(startTime, randomValue)
		end,
		replication = function(startTime: number, returnValue: number)
			local DEPTH = 1000
			local round = CommandAPI.round
			local timeTaken = tick() - startTime
			local ping = timeTaken/2
			local pingMs = ping*DEPTH
			local pingMsRounded = round(pingMs, 2)
			CommandAPI.prompt("info", `Your ping is {pingMsRounded} ms`)
		end
	},

	--------------------
	{
		name = "HideGuis",
		run = function(task: CommandAPI.Task, hello)
			local localPlayer = Players.LocalPlayer
			local playerGui = localPlayer:WaitForChild("PlayerGui", 3)
			if not playerGui then
				return
			end
			for _, instance in playerGui:GetChildren() do
				if not instance:IsA("ScreenGui") then
					continue
				end
				if not instance.Enabled then
					continue
				end
				if instance.Name == "HDAdmin" then
					continue
				end
				instance.Enabled = false
				task:onEnded(function()
					instance.Enabled = true
				end)
			end
		end,
	},

	--------------------
	{
		name = "NightVision",
		run = function(task: CommandAPI.Task)
			local localPlayer = game:GetService("Players").LocalPlayer
			local janitor = task.janitor
			for _, player in Players:GetPlayers() do
				local head = getHead(player)
				local char = player.Character
				if not char or not head or player.Name == localPlayer.Name then
					continue
				end
				for _, instance in char:GetChildren() do
					if not instance:IsA("BasePart") or not instance:FindFirstChild("HDNightVision") == nil then
						continue
					end
					for faceIndex: any = 1,6 do
						local nv = janitor:add(script.NightVision:Clone())
						nv.Parent = instance
						nv.Face = faceIndex-1
						nv.Name = "HDAdminNightVision"
					end
				end
				local nv = janitor:add(script.Nickname:Clone())
				nv.TextLabel.Text = player.Name
				nv.Parent = head
				nv.Name = "HDAdminNightVision"
			end
		end,
	},

	--------------------
	{
		name = "Blur",
		run = function(task: CommandAPI.Task, number: number)
			-- A re-fired run (the slider changing) just resizes the existing blur
			if task.extra.blur then
				task.extra.blur.Size = number
				return
			end
			local janitor = task.janitor
			local camera = workspace.CurrentCamera
			local blur = janitor:add(Instance.new("BlurEffect", camera))
			blur.Size = number
			task.extra.blur = blur
		end,
	},

	--------------------
	{
		name = "View",
		run = function(task: CommandAPI.Task, playerToView: Player)
			if not playerToView then return end
			local localPlayer = game:GetService("Players").LocalPlayer
			local janitor = task.janitor
			local setCameraSubject = CommandAPI.setCameraSubject
			setCameraSubject(playerToView)
			janitor:add(playerToView.CharacterAdded:Connect(function()
				local char = playerToView.Character or playerToView.CharacterAdded:Wait()
				task.wait()
				setCameraSubject(playerToView)
			end))
			janitor:add(playerToView:GetPropertyChangedSignal("Parent"):Once(function()
				setCameraSubject(localPlayer)
			end))
			task:onEnded(function()
				setCameraSubject(localPlayer)
			end)
		end,
	},

	--------------------
}


return clientCommands
