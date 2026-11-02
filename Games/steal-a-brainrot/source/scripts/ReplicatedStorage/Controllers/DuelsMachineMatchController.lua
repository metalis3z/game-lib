local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local ReplicatorClient = require(ReplicatedStorage.Packages.ReplicatorClient)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local Observers = require(ReplicatedStorage.Packages.Observers)
local UsersAPI = require(ReplicatedStorage.Shared.UsersAPI)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local Spr = require(ReplicatedStorage.Packages.Spr)

local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)

local ServerData = require(ReplicatedStorage.Datas.ServerData)
local AnimalsData = require(ReplicatedStorage.Datas.Animals)
local TraitsData = require(ReplicatedStorage.Datas.Traits)

local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local TimeUtils = require(ReplicatedStorage.Utils.TimeUtils)
local SharedAnimals = require(ReplicatedStorage.Shared.Animals)
local Updates = require(ReplicatedStorage.Shared.Updates)

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local DuelsMachineSessionUI = PlayerGui:WaitForChild("DuelsMachineSession").DuelsMachineSession
local DuelsMachineTopFrameUI = PlayerGui:WaitForChild("DuelsMachineTopFrame").DuelsMachineTopFrame
local DuelsMachineAnimationUI = PlayerGui:WaitForChild("DuelsMachineAnimation").DuelsMachineAnimation
local TipLabel = PlayerGui:WaitForChild("DuelsMachineTopFrame").Tip

local IsAnimating = false

local DuelsMachineMatchController = {}

function DuelsMachineMatchController:Start()
	if ServerData.IsDuelsServer then
		Net:Connect("DuelsMachineMatchService/SelectBrainrot/WinnerScreen", function(_) end)

		local DuelsRoundsReplion = ReplicatorClient.get("DuelsRounds")
		ReplicatorClient.get("SelectBrainrots")

		local RegisteredUI = InterfaceController:Register("DuelsMachineSession", DuelsMachineSessionUI, "TopQuint")
		RegisteredUI:AttachCloseButton(DuelsMachineSessionUI.Header.Close)
		RegisteredUI:Close()

		local PlayerData = Synchronizer:Wait(LocalPlayer)
		ReplicatorClient.init()

		local MainTrove = Trove.new()

		local function UpdateSelectBrainrot()
			if workspace:GetAttribute("DuelsSelectBrainrotActive") then
				InterfaceController:SetState("DuelsMachineSession", true)
				local SelectBrainrotsData = ReplicatorClient.get("SelectBrainrots")
				SelectBrainrotsData:WaitForLoaded()

				local SelectTrove = MainTrove:Extend()

				local function UpdateReadyButton()
					local lastChange = SelectBrainrotsData:TryIndex({ "lastChange" }) or 0
					local currentPlayers = SelectBrainrotsData:TryIndex({ "players" }) or {}
					local allHaveBrainrots = true

					for _, pData in pairs(currentPlayers) do
						if not pData.brainrot then
							allHaveBrainrots = false
							break
						end
					end

					local myData = currentPlayers[tostring(LocalPlayer.UserId)]
					local timeLeft = lastChange + 5 - workspace:GetServerTimeNow()
					local targetColor

					if timeLeft <= 0 and (allHaveBrainrots and (next(currentPlayers) and not (myData and myData.accepted))) then
						targetColor = Color3.fromRGB(81, 158, 86)
					else
						targetColor = Color3.fromRGB(112, 112, 112)
					end

					Spr.target(DuelsMachineSessionUI.Other.Ready, 1, 5, { BackgroundColor3 = targetColor })
				end

				MainTrove:Add(SelectBrainrotsData:Observe({ "lastChange" }, function(lastChangeTS)
					SelectTrove:Clean()
					if lastChangeTS ~= nil then
						SelectTrove:Add(Timer.Simple(0.1, function()
							local timeLeft = lastChangeTS + 5 - workspace:GetServerTimeNow()
							local timerStr = ""

							if timeLeft > 0 then
								timerStr = ("⏰%s Left"):format(math.floor(timeLeft * 10) / 10)
							end

							DuelsMachineSessionUI.Other.Timer.Text = timerStr
							UpdateReadyButton()
						end, true))
					end
				end))

				local CachedIds = {}
				local CacheTroves = {}

				MainTrove:Add(SelectBrainrotsData:Observe({ "players" }, function(playersData)
					local allReady = true
					for _, pData in pairs(playersData) do
						if not (pData.ready and pData.brainrot) then
							allReady = false
							break
						end
					end

					DuelsMachineSessionUI.Other.Ready.Txt.Text = allReady and "ACCEPT" or "READY"

					local function UpdatePlayerCard(userId, pData, uiFrame)
						local itemUI = uiFrame.Item
						uiFrame.Frame.Ready.Text = pData.accepted and "ACCEPTED" or "READY"
						uiFrame.Frame.Ready.Visible = pData.ready

						local strokeColor = pData.ready and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 0, 0)
						Spr.target(itemUI.UIStroke, 1, 5, { Color = strokeColor })

						local brainrotId = pData.brainrot and pData.brainrot.UUID or "none"
						local cacheKey = ("%s_%s"):format(pData.indexOnPlot, brainrotId)

						if CachedIds[userId] == cacheKey then return end

						CachedIds[userId] = cacheKey
						CacheTroves[userId]:Clean()

						if pData.brainrot then
							local animalInfo = AnimalsData[pData.brainrot.Index]
							itemUI.Title.Text = animalInfo and animalInfo.DisplayName or pData.brainrot.Index
							itemUI.Cash.Text = ("$%s/s"):format(NumberUtils:ToString(SharedAnimals:GetGeneration(pData.brainrot.Index, pData.brainrot.Mutation, pData.brainrot.Traits)))

							local viewportModel = SharedAnimals:AttachOnViewportWithOptimizations(pData.brainrot.Index, itemUI.ViewportFrame, nil, pData.brainrot.Mutation)
							if viewportModel then CacheTroves[userId]:Add(viewportModel) end

							for _, trait in ipairs(pData.brainrot.Traits or {}) do
								local traitData = TraitsData[trait]
								if traitData then
									local traitIcon = CacheTroves[userId]:Clone(itemUI.Traits.Template)
									traitIcon.Name = trait
									traitIcon.Visible = true
									traitIcon.Image = traitData.Icon
									traitIcon.Parent = itemUI.Traits
								end
							end
						else
							itemUI.Title.Text = "Waiting for player to select..."
							itemUI.Cash.Text = ""
						end
					end

					for userId, pData in pairs(playersData) do
						if not CacheTroves[userId] then CacheTroves[userId] = MainTrove:Extend() end

						if userId == tostring(LocalPlayer.UserId) then
							DuelsMachineSessionUI.Your.Frame.Ready.Text = pData.accepted and "ACCEPTED" or "READY"
							DuelsMachineSessionUI.Your.Frame.Ready.Visible = pData.ready
							DuelsMachineSessionUI.Main.Visible = allReady
							DuelsMachineSessionUI.ScrollingFrame.Visible = not allReady

							if allReady then UpdatePlayerCard(userId, pData, DuelsMachineSessionUI.Main) end
						else
							local otherPlayer = Players:GetPlayerByUserId(tonumber(userId))
							DuelsMachineSessionUI.Other.Frame.Username.Text = ("@%s's Offer"):format(otherPlayer and otherPlayer.Name or "???")
							DuelsMachineSessionUI.Other.PlayerImage.Headshot.Image = ("rbxthumb://type=AvatarHeadShot&id=%s&w=100&h=100"):format(userId)
							UpdatePlayerCard(userId, pData, DuelsMachineSessionUI.Other)
						end
					end
				end))

				local PodiumsTrove = MainTrove:Extend()
				MainTrove:Add(PlayerData:OnChanged("AnimalPodiums", function(podiumsData)
					PodiumsTrove:Clean()
					for podiumIndex, animalData in pairs(podiumsData) do
						if typeof(animalData) == "table" and not animalData.Machine then
							local cloneUI = PodiumsTrove:Clone(DuelsMachineSessionUI.ScrollingFrame.Template)
							cloneUI.Visible = true

							local animalInfo = AnimalsData[animalData.Index]
							cloneUI.Spacer.Title.Text = animalInfo and animalInfo.DisplayName or animalData.Index
							cloneUI.Spacer.Cash.Text = ("$%s/s"):format(NumberUtils:ToString(SharedAnimals:GetGeneration(animalData.Index, animalData.Mutation, animalData.Traits)))

							local viewportModel = SharedAnimals:AttachOnViewportWithOptimizations(animalData.Index, cloneUI.Spacer.ViewportFrame, nil, animalData.Mutation)
							if viewportModel then PodiumsTrove:Add(viewportModel) end

							for _, trait in ipairs(animalData.Traits or {}) do
								local traitData = TraitsData[trait]
								if traitData then
									local traitIcon = PodiumsTrove:Clone(cloneUI.Spacer.Traits.Template)
									traitIcon.Name = trait
									traitIcon.Visible = true
									traitIcon.Image = traitData.Icon
									traitIcon.Parent = cloneUI.Spacer.Traits
								end
							end
							cloneUI.Parent = DuelsMachineSessionUI.ScrollingFrame

							PodiumsTrove:Add(cloneUI.Spacer.Activated:Connect(function()
								SoundController:PlaySound("Sounds.Sfx.Activated")
								Net:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/Select"):FireServer(podiumIndex, animalData)
							end))

							local expectedCacheKey = ("%s_%s"):format(podiumIndex, animalData.UUID)
							local isInitialSetup = true

							PodiumsTrove:Add(SelectBrainrotsData:Observe({ "players", tostring(LocalPlayer.UserId) }, function(myPlayerData)
								local brainrotId = myPlayerData.brainrot and myPlayerData.brainrot.UUID or "none"
								local currentCacheKey = ("%s_%s"):format(myPlayerData.indexOnPlot, brainrotId)
								local isSelected = expectedCacheKey == currentCacheKey

								local bgColor = isSelected and Color3.fromRGB(15, 50, 15) or Color3.fromRGB(35, 45, 50)
								local strokeColor = isSelected and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 0, 0)

								if isInitialSetup then
									isInitialSetup = false
									cloneUI.Spacer.BackgroundColor3 = bgColor
									cloneUI.Spacer.UIStroke.Color = strokeColor
								else
									Spr.target(cloneUI.Spacer, 1, 5, { BackgroundColor3 = bgColor })
									Spr.target(cloneUI.Spacer.UIStroke, 1, 5, { Color = strokeColor })
								end
							end))
						end
					end
				end, true))
			else
				InterfaceController:SetState("DuelsMachineSession", false)
				MainTrove:Clean()
			end
		end

		workspace:GetAttributeChangedSignal("DuelsSelectBrainrotActive"):Connect(function()
			MainTrove:Add(task.spawn(UpdateSelectBrainrot))
		end)
		MainTrove:Add(task.spawn(UpdateSelectBrainrot))

		DuelsMachineSessionUI.Your.PlayerImage.Headshot.Image = ("rbxthumb://type=AvatarHeadShot&id=%s&w=100&h=100"):format(LocalPlayer.UserId)

		DuelsMachineSessionUI.Other.Ready.Activated:Connect(function()
			local SelectBrainrotsData = ReplicatorClient.get("SelectBrainrots")
			if not (SelectBrainrotsData.Data and workspace:GetAttribute("DuelsSelectBrainrotActive")) then return end

			SoundController:PlaySound("Sounds.Sfx.Activated")
			local allReady = true
			for _, pData in pairs(SelectBrainrotsData.Data.players) do
				if not (pData.ready and pData.brainrot) then
					allReady = false
					break
				end
			end

			if allReady then
				Net:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/Accept"):FireServer()
			else
				Net:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/Ready"):FireServer()
			end
		end)

		DuelsMachineSessionUI.Other.Cancel.Activated:Connect(function()
			if ReplicatorClient.get("SelectBrainrots").Data and workspace:GetAttribute("DuelsSelectBrainrotActive") then
				SoundController:PlaySound("Sounds.Sfx.Activated")
				Net:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/Cancel"):FireServer()
			end
		end)

		RegisteredUI.OnClose:Connect(function()
			if ReplicatorClient.get("SelectBrainrots").Data and workspace:GetAttribute("DuelsSelectBrainrotActive") then
				Net:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/Cancel"):FireServer()
			end
		end)

		Net:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/SetDevice"):FireServer(UserInputService.PreferredInput == Enum.PreferredInput.Gamepad and "Console" or (UserInputService.PreferredInput == Enum.PreferredInput.Touch and "Mobile" or "PC"))

		local AnimationRE = Net:RemoteEvent("DuelsMachineMatchService/SelectBrainrot/Animation")
		local BlurFX = Instance.new("BlurEffect")
		BlurFX.Size = 0
		BlurFX.Parent = workspace.CurrentCamera

		AnimationRE.OnClientEvent:Connect(function(countdownTime)
			while IsAnimating do task.wait() end
			IsAnimating = true
			DuelsMachineAnimationUI.Visible = true

			SoundController:PlaySound("Sounds.Sfx.Duels.Countdown", nil, false)
			CreateTween(DuelsMachineAnimationUI, TweenInfo.new(0.25), { BackgroundTransparency = 0.25 })
			CreateTween(BlurFX, TweenInfo.new(0.5), { Size = 20 })

			DuelsMachineAnimationUI.Label1.Visible = true
			DuelsMachineAnimationUI.Label2.Visible = true

			for i = math.floor(countdownTime), 1, -1 do
				local activeLabel = (i % 2 == 0) and DuelsMachineAnimationUI.Label1 or DuelsMachineAnimationUI.Label2
				activeLabel.ZIndex = 2
				activeLabel.TextTransparency = 1
				activeLabel.Size = UDim2.fromScale(0.5, 0.5)
				activeLabel.Text = tostring(i)

				CreateTween(activeLabel, TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.fromScale(0.2, 0.2) }).Completed:Once(function()
					activeLabel.ZIndex = 1
					CreateTween(activeLabel, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), { Size = UDim2.fromScale(0, 0) })
				end)

				CreateTween(activeLabel, TweenInfo.new(0.35), { TextTransparency = 0 })
				task.wait(1)
			end

			CreateTween(BlurFX, TweenInfo.new(0.25), { Size = 0 })
			CreateTween(DuelsMachineAnimationUI, TweenInfo.new(0.25), { BackgroundTransparency = 1 }).Completed:Wait()

			DuelsMachineAnimationUI.Label1.TextTransparency = 1
			DuelsMachineAnimationUI.Label2.TextTransparency = 1
			DuelsMachineAnimationUI.Label1.Visible = false
			DuelsMachineAnimationUI.Label2.Visible = false
			DuelsMachineAnimationUI.Visible = false
			IsAnimating = false
		end)

		DuelsMachineTopFrameUI.Visible = false
		DuelsMachineTopFrameUI.Position = UDim2.fromScale(0.5, -0.2)
		TipLabel.TextTransparency = 1
		TipLabel.UIStroke.Transparency = 1

		DuelsRoundsReplion:WaitForLoaded()
		DuelsMachineTopFrameUI.Visible = true

		CreateTween(DuelsMachineTopFrameUI, TweenInfo.new(0.8, Enum.EasingStyle.Quad), { Position = UDim2.fromScale(0.5, 0.01) })
		CreateTween(TipLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 1), { TextTransparency = 0 })
		CreateTween(TipLabel.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 1), { Transparency = 0 })

		task.delay(10.5, function()
			CreateTween(TipLabel, TweenInfo.new(0.5), { TextTransparency = 1 })
			CreateTween(TipLabel.UIStroke, TweenInfo.new(0.5), { Transparency = 1 })
		end)

		DuelsRoundsReplion:Observe({ "roundTimer" }, function(timeValue)
			local intTime = math.floor(timeValue)
			local formatStr = intTime > 60 and string.format("%d:%02d", math.floor(intTime / 60), intTime % 60) or tostring(intTime)
			DuelsMachineTopFrameUI.Timer.Label.Text = formatStr
		end)

		local PlayerFrames = { DuelsMachineTopFrameUI.Blue, DuelsMachineTopFrameUI.Red }
		local DeviceIcons = {
			["PC"] = "rbxassetid://87143261820372",
			["Console"] = "rbxassetid://119798532223911",
			["Mobile"] = "rbxassetid://72402748445638"
		}

		local function UpdateTopFramePlayers()
			local expectedPlayers = DuelsRoundsReplion:TryIndex({ "expectedPlayers" })
			local roundWins = DuelsRoundsReplion:TryIndex({ "roundWins" })

			if expectedPlayers and roundWins then
				for index, userId in pairs(expectedPlayers) do
					local frame = PlayerFrames[index]
					local playerObj = Players:GetPlayerByUserId(userId)

					frame.Player.Image = ("rbxthumb://type=AvatarHeadShot&id=%s&w=100&h=100"):format(userId)
					frame.Label.Text = tostring(roundWins[tostring(userId)] or 0)

					if playerObj then
						local device = playerObj:GetAttribute("Device")
						if device then frame.Icon.Image = DeviceIcons[device] or "" end
					end
				end
			end
		end

		DuelsRoundsReplion:Observe({ "roundWins" }, UpdateTopFramePlayers)
		DuelsRoundsReplion:Observe({ "expectedPlayers" }, UpdateTopFramePlayers)

		Observers.observePlayer(function(player)
			task.spawn(UpdateTopFramePlayers)
			local attrObserve = Observers.observeAttribute(player, "Device", function()
				task.spawn(UpdateTopFramePlayers)
				return nil
			end)
			return function()
				attrObserve()
				task.spawn(UpdateTopFramePlayers)
			end
		end)
	end
end

return DuelsMachineMatchController