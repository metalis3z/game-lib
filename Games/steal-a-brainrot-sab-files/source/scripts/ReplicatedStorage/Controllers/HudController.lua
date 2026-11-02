-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Controllers = ReplicatedStorage:WaitForChild("Controllers")
local InterfaceController = require(Controllers.InterfaceController)
local CameraController = require(Controllers.CameraController)
local GameController = require(Controllers.GameController)
local SoundController = require(Controllers.SoundController)
local NotificationController = require(Controllers.NotificationController)
local EventController = require(Controllers.EventController)
local TimeUtils = require(ReplicatedStorage.Utils.TimeUtils)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local LuckIcons = require(ReplicatedStorage.Datas.LuckIcons)
local Updates = require(ReplicatedStorage.Shared.Updates)
local Packages = ReplicatedStorage.Packages
local Synchronizer = require(Packages.Synchronizer)
local Net = require(ReplicatedStorage.Packages.Net)
local ServerLuck = require(ReplicatedStorage.Datas.ServerLuck)
local Timer = require(Packages.Timer)
local Classes = ReplicatedStorage:WaitForChild("Classes")
local AnimatedButton = require(Classes.AnimatedButton)
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Friends = require(Shared.Friends)
local Utils = ReplicatedStorage:WaitForChild("Utils")
local NumberUtils = require(Utils.NumberUtils)
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local LeftCenter = PlayerGui.LeftCenter.LeftCenter
local LeftBottom = PlayerGui.LeftBottom.LeftBottom
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint)
local u30 = nil
local HudController = {}
local t2 = {}

function HudController.ShowFakeEvent(_: {[any]: any}, s1: string, n1: number)
	t2[s1] = n1

	return function()
		if t2[s1] == n1 then
			t2[s1] = nil
		end
	end
end
function HudController.Start(_)
	local v37 = TweenService:Create(LeftCenter, tweenInfo, {
		Position = UDim2.fromScale(LeftCenter.Position.X.Scale - 1, LeftCenter.Position.Y.Scale)
	})
	local v38 = TweenService:Create(LeftCenter, tweenInfo, {
		Position = LeftCenter.Position
	})

	u30 = InterfaceController:Register("Hud", LeftCenter, "Custom")
	u30.OnOpen:Connect(function()
		CameraController:Blur(0, 0.5)
		CameraController:Fov(CameraController:GetDefaultFov(), 0.5)
		v38:Play()
	end)
	u30.OnClose:Connect(function()
		v37:Play()
	end)
	u30:Close()
	GameController:OnGameLoaded(function()
		u30:Toggle(true)
	end)

	if ServerData.IsDuelsServer() then
		LeftCenter.Buttons.Visible = false
	end

	for _, v40 in LeftCenter.Buttons:GetChildren() do
		if v40:IsA("GuiButton") then
			local v41 = AnimatedButton.new(v40)

			v41:Animate()
			v41.OnActivated:Connect(function() 
				local tradenabled = true
				if v40.Name == "TradePlayerList" and not tradenabled then
					NotificationController:Error("This is coming soon :>")
					return
				end

				InterfaceController:Toggle(v40.Name)
			end)
		end
	end

	local t4 = {}
	local ActiveEvents = PlayerGui:WaitForChild("ActiveEvents").ActiveEvents

	for _, v45 in ActiveEvents:GetChildren() do
		if v45:IsA("GuiObject") then
			t4[v45.Name] = v45
		end
	end

	ActiveEvents.ChildAdded:Connect(function(child)
		if child:IsA("GuiObject") then
			t4[child.Name] = child
		end
	end)

	local t5 = {}
	local u47 = Synchronizer:Get("ServerLuck")

	task.spawn(function()
		Synchronizer:WaitAndCall("ServerLuck", function(p2)
			u47 = p2
		end)
	end)
	Timer.Simple(1, function()
		local ServerTimeNow = workspace:GetServerTimeNow()
		local t6 = {}

		for _, v67 in EventController:GetActiveEvents() do
			t6[v67.eventName] = v67.endsAt - ServerTimeNow
		end

		local v68 = u47 and u47:Get("Index") or 0
		local v69 = if not (v68 >= 1) then nil else ServerLuck[v68]

		for _, v71 in {
			"30x",
			"25x",
			"20x",
			"15x",
			"12x",
			"10x",
			"8x",
			"6x",
			"4x",
			"2x"
			} do
			local v72 = t6[`{ v71 } Server Luck`]

			if v69 and v71 == v69.Id then
				local v73 = (u47:Get("EndTime") or ServerTimeNow) - ServerTimeNow

				if v72 == nil or v72 < v73 then
					v72 = v73
				end
			end

			if v72 then
				t6[`{ v71 } Server Luck`] = nil
				t6.Luck = v72
				t4.Luck.Main.Image = LuckIcons[v71]

				break
			end
		end

		if t6["St Patricks"] and not t6.Rainbow then
			t6.Rainbow = t6["St Patricks"]
		end

		local FuseMachineLuckTimer = ReplicatedStorage:GetAttribute("FuseMachineLuck")

		local FuseMachineIcons = {
			["Divine"] = "rbxassetid://133058451981698",
			["Witch"] = "rbxassetid://90217745566943",
			["Normal"] = "rbxassetid://121849249532242",
			["Summer"] = "rbxassetid://133077924666782",
			["Santa"] = "rbxassetid://85728936284496"
		}

		if FuseMachineLuckTimer then
			local FuseMachine = workspace:FindFirstChild("FuseMachine")
			local FuseIconKey = FuseMachine and FuseMachine:GetAttribute("FuseType")
			t4["Fuse Machine Luck"].Main.Image = FuseMachineIcons[FuseIconKey] or FuseMachineIcons["Default"]
		end

		local v75 = Synchronizer:Get(LocalPlayer)

		for v76, v77 in v75 and v75:Get("BoostExpiration") or {} do
			if typeof(v77) == "number" and not (v77 <= 0) then
				local v78 = v77 - ServerTimeNow

				if v78 > 0 then
					t6[v76] = v78
				end
			end
		end

		for v79, v80 in t2 do
			local v81 = v80 - ServerTimeNow

			if v81 <= 0 then
				t2[v79] = nil
			else
				local v82 = t6[v79]

				if not v82 or v82 < v81 then
					t6[v79] = v81
				end
			end
		end

		for _, v84 in t4 do
			local Name = v84.Name
			local v86 = t6[Name]
			local v87 = v86 ~= nil and v86 > 0

			if v87 ~= t5[Name] then
				local v88 = if not v87 then TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In) else TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
				local v89 = TweenService:Create(v84.Main, v88, {
					Position = UDim2.fromScale(0.5, not v87 and 1.5 or 0.5)
				})

				if v87 then
					v84.Visible = true
				end

				v89:Play()
				v89.Completed:Once(function()
					if not v87 then
						v84.Visible = false
					end

					v89:Cancel()
					v89:Destroy()
				end)
				t5[Name] = v87
			end

			v84.Main.TextLabel.Text = if not v86 then v84.Main.TextLabel.Text else TimeUtils:B((math.max(v86 // 1, 0)))
		end
	end)
	Timer.Simple(5, function()
		LeftBottom.FriendBoost.Text = `Friend Boost: +{ Friends:GetFriendBoostPercentage(LocalPlayer) }%`
	end)

	if ServerData.IsContentCreatorGame() then
		local CC = LeftBottom.CC
		local uDim2 = UDim2.fromScale(0, -CC.Size.Y.Scale * 0.8)

		CC.Visible = true

		local FriendBoost = LeftBottom.FriendBoost

		FriendBoost.Position = FriendBoost.Position + uDim2

		local Currency = LeftBottom.Currency

		Currency.Position = Currency.Position + uDim2

		local Cashout = LeftBottom.Cashout

		Cashout.Position = Cashout.Position + uDim2
		CC:GetPropertyChangedSignal("Parent"):Once(function()
			if CC.Parent ~= LeftBottom then
				LocalPlayer:Kick()
			end
		end)
		CC:GetPropertyChangedSignal("Visible"):Once(function()
			if not CC.Visible then
				LocalPlayer:Kick()
			end
		end)
	end

	Synchronizer:WaitAndCall(LocalPlayer, function(p3)
		local Currency = LeftBottom.Currency
		local LeftBottomSpeed = LeftBottom.Speed
		local Cashout = LeftBottom.Cashout
		local tweenInfo2 = TweenInfo.new(5, Enum.EasingStyle.Linear)

		local function updateBottomUI()
			LeftBottomSpeed.Visible = ServerData.IsTsunamiServer()

			if LeftBottomSpeed.Visible then
				LeftBottomSpeed.Position = UDim2.fromScale(0.04, 0.875)
			end

			if LeftBottomSpeed.Visible then
				Cashout.Position = UDim2.fromScale(0.03, 0.79)

				return
			end

			Cashout.Position = UDim2.fromScale(0.03, 0.872)
		end

		Updates.OnUpdateEnabled:Connect(updateBottomUI)
		Updates.OnUpdateDisabled:Connect(updateBottomUI)
		task.spawn(updateBottomUI)

	

		p3:OnChanged("TsunamiEvent.SpeedUpgrades", function(p6, _)
			local TsunamiEventData = require(ReplicatedStorage.Shared.TsunamiEventData)

			LeftBottomSpeed.Text = `{ NumberUtils:Comma(TsunamiEventData.getTotalSpeed(p6)) }`
		end, true)
		p3:OnChanged("Coins", function(n2: number, n3: number)
			Currency.Text = `${ NumberUtils:ToString(n2, 2) }`

			if n3 then
				local v104 = n2 - n3

				if v104 == 0 then
					return
				end

				local clone = Cashout.Template:Clone()

				clone.Text = `{ not (v104 > 0) and "-" or "+" }${ NumberUtils:ToString(math.abs(v104), 2) }`
				clone.TextColor3 = v104 < 0 and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(13, 255, 0)
				clone.Visible = true
				clone.Parent = Cashout

				local v106 = TweenService:Create(clone, tweenInfo2, {
					TextTransparency = 1
				})
				local v107 = TweenService:Create(clone.UIStroke, tweenInfo2, {
					Transparency = 1
				})

				v106.Completed:Once(function()
					clone:Destroy()
				end)
				v106:Play()
				v107:Play()

				if v104 > 0 then
					SoundController:PlaySound("Sounds.Sfx.Cashout")
				end
			end
		end, true)
	end)
end

task.spawn(function()
	if not ServerData.IsDevGame() then
		return
	end

	local Role = LocalPlayer:GetAttribute("Role")

	while Role == nil do
		LocalPlayer:GetAttributeChangedSignal("Role"):Wait()
		Role = LocalPlayer:GetAttribute("Role")
	end

	if Role ~= "Dev" and Role ~= "Lead" then
		local LocalPlayerName = Players.LocalPlayer.Name
		local ScreenGui = Instance.new("ScreenGui")

		ScreenGui.Enabled = true
		ScreenGui.IgnoreGuiInset = true
		ScreenGui.Name = utf8.char(65279)
		ScreenGui.ResetOnSpawn = false
		ScreenGui.Parent = Players.LocalPlayer.PlayerGui

		local ScreenGui2 = Instance.new("ScreenGui")

		ScreenGui2.Enabled = true
		ScreenGui2.IgnoreGuiInset = true
		ScreenGui2.Name = utf8.char(65279)
		ScreenGui2.ResetOnSpawn = false
		ScreenGui2.Parent = ScreenGui

		for i = -89, 2848, 89 do
			local v58 = string.rep("@" .. LocalPlayerName .. " ", 2000)
			local uDim2 = UDim2.new(2, 0, 0, 89)
			local uDim2_2 = UDim2.new(0.5, 0, 0, i)
			local vector2 = Vector2.new(0.5, 0)
			local TextLabel = Instance.new("TextLabel")

			TextLabel.Size = uDim2
			TextLabel.AnchorPoint = vector2
			TextLabel.Position = uDim2_2
			TextLabel.BackgroundTransparency = 1
			TextLabel.TextTransparency = 0.8
			TextLabel.MaxVisibleGraphemes = -1
			TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel.TextSize = 30
			TextLabel.TextWrapped = true
			TextLabel.Font = Enum.Font.SourceSansBold
			TextLabel.Rotation = 5
			TextLabel.Text = v58
			TextLabel.Parent = ScreenGui2
			task.spawn(function()
				while true do
					if not TextLabel.Visible or TextLabel.Rotation ~= 5 or TextLabel.TextSize ~= 30 or not TextLabel.TextWrapped or math.abs(0.8 - TextLabel.TextTransparency) > 0.1 or TextLabel.Text ~= v58 or TextLabel.Size ~= uDim2 or TextLabel.Position ~= uDim2_2 or TextLabel.AnchorPoint ~= vector2 or TextLabel.Parent ~= ScreenGui2 or TextLabel.Font ~= Enum.Font.SourceSansBold or TextLabel.MaxVisibleGraphemes ~= -1 or not ScreenGui2.Enabled or ScreenGui2.Parent ~= ScreenGui or ScreenGui.Parent ~= Players.LocalPlayer.PlayerGui then
						task.spawn(function()
							LocalPlayer:Kick()
							Net:RemoteEvent("abdbbc93-5ae6-48bb-a129-f9ce6dbe9617"):FireServer((0/0))

							local function e()
								buffer.create(1073741824)
								e()
							end

							while true do
								task.spawn(e)
							end
						end)
					end

					task.wait()
				end
			end)
		end
	end
end)

return HudController
