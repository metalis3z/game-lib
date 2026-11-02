local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")


local Controllers = ReplicatedStorage:WaitForChild("Controllers")
local InterfaceController = require(Controllers.InterfaceController)
local NotificationController = require(Controllers.NotificationController)
require(Controllers.ShopController)


local Packages = ReplicatedStorage:WaitForChild("Packages")
local Observers = require(Packages.Observers)
local Synchronizer = require(Packages.Synchronizer)
local Timer = require(Packages.Timer)
local Trove = require(Packages.Trove)
local Net = require(Packages.Net)


local Utils = ReplicatedStorage:WaitForChild("Utils")
local TimeUtils = require(Utils.TimeUtils)
local NumberUtils = require(Utils.NumberUtils)


local Datas = ReplicatedStorage:WaitForChild("Datas")
local CyberWheelData = require(Datas.CyberSpinWheel)
local ShopData = require(Datas.Shop)
local LuckyBlocks = require(Datas.LuckyBlocks)
local Animals = require(Datas.Animals)


local Classes = ReplicatedStorage:WaitForChild("Classes")
local CyberSpinWheelClass = require(script.CyberSpinWheel)
local AnimatedButton = require(Classes.AnimatedButton)


local Shared = ReplicatedStorage:WaitForChild("Shared")
local Marketplace = require(Shared.Marketplace)
local SharedAnimals = require(Shared.Animals)
local Policy = require(Shared.Policy)
local Updates = require(Shared.Updates)


local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local CyberWheelUI = PlayerGui:WaitForChild("CyberWheel").CyberWheel


local CashPackValues = {
	["Cash Pack #2"] = 325000,
	["Cash Pack #3"] = 1300000,
	["Cash Pack #5"] = 13000000,
}


local PurchaseRE = Net:RemoteEvent("ShopService/Purchase")
local SpinRE = Net:RemoteEvent("CyberEventService/Spin")

local Controller = {}

local Interface
local IsFastSpin = false
local IsSpinning = false

local function PlaySpinAnimation(rewardIndex)
	if IsSpinning then return end
	IsSpinning = true

	local wheel = CyberWheelUI.Wheel
	local spinSound = SoundService:FindFirstChild("Spinning")
	local volume = IsFastSpin and 1 or 0.8

	if spinSound then
		spinSound.Looped = true
		spinSound.Volume = volume
		spinSound:Play()
	end

	local targetOffset = (rewardIndex - 1) * -60 - (math.random() - 0.5) * 40
	local totalRotation = targetOffset + (IsFastSpin and 360 or 9 * 360)
	local duration = IsFastSpin and 0.5 or 5

	local lastTick
	local conn = RunService.PostSimulation:Connect(function()
		local tick = (wheel.Rotation + 30) // 60
		if tick ~= lastTick then
			lastTick = tick
			CyberWheelUI.Tick.Rotation = -40
			TweenService:Create(CyberWheelUI.Tick, TweenInfo.new(0.3), {Rotation = 0}):Play()
		end
	end)

	local tween = TweenService:Create(
		wheel,
		TweenInfo.new(duration, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		{Rotation = totalRotation}
	)

	if spinSound then
		TweenService:Create(spinSound, TweenInfo.new(duration), {Volume = 0}):Play()
	end

	tween:Play()
	tween.Completed:Wait()

	conn:Disconnect()
	wheel.Rotation = targetOffset

	if spinSound then
		spinSound:Stop()
		spinSound.Volume = volume
	end

	-- Reward text
	local reward = CyberWheelData.Rewards[rewardIndex]
	local text = reward.Display

	if reward.Type == "Cash-Pack" then
		local value = CashPackValues[reward.Display] or 0
		text = "$" .. NumberUtils:ToString(value, 2)
	end

	NotificationController:Success(("You received %s!"):format(text))
	IsSpinning = false
end

function Controller.SetupCyberWheel()
	Interface = InterfaceController:Register("CyberWheel", CyberWheelUI, "TopQuint")
	Interface:AttachCloseButton(CyberWheelUI.Close)
	Interface:Close()

	local playerData = Synchronizer:Wait(LocalPlayer)

	local spinBtn = CyberWheelUI.Buttons.Spin
	local spinAnim = AnimatedButton.new(spinBtn)
	spinAnim:Animate()

	playerData:OnChanged("CyberSpinWheel.Spins", function(value)
		local spins = value or 0
		spinBtn.Main.Spins.Text = ("Spin (%s)"):format(spins)

		local canSpin = spins >= 1

		local gradient = spinBtn.Main:FindFirstChildOfClass("UIGradient")
		if gradient then
			gradient.Enabled = not canSpin
		end

		spinBtn.Active = canSpin
		spinBtn.AutoButtonColor = canSpin
	end)

	spinAnim.OnActivated:Connect(function()
		if not IsSpinning then
			SpinRE:FireServer()
		end
	end)

	local toggle = CyberWheelUI.FastSpin.Toggle
	local toggleAnim = AnimatedButton.new(toggle)
	toggleAnim:Animate()

	toggleAnim.OnActivated:Connect(function()
		IsFastSpin = not IsFastSpin
		toggle.Checkmark.Visible = IsFastSpin
	end)

	for _, btn in ipairs(CyberWheelUI.Buttons:GetChildren()) do
		if btn:IsA("ImageButton") and btn.Name ~= "Spin" then
			local anim = AnimatedButton.new(btn)
			anim:Animate()

			anim.OnActivated:Connect(function()
				PurchaseRE:FireServer(btn:GetAttribute("ProductId"))
			end)

			local info = Marketplace:GetProductInfo(btn:GetAttribute("ProductId"), "Product")
			btn.RbxAmount.Text = info.PriceInRobux
		end
	end

	local function UpdateUI()
		local spins = (playerData:Get("CyberSpinWheel.Spins") or 0)

		spinBtn.Main.Spins.Text = ("Spin (%s)"):format(spins)

		local canSpin = spins >= 1

		local gradient = spinBtn.Main:FindFirstChildOfClass("UIGradient")
		if gradient then
			gradient.Enabled = not canSpin
		end

		spinBtn.Active = canSpin
		spinBtn.AutoButtonColor = canSpin

		local nextTime = ReplicatedStorage:GetAttribute("NextCyberEvent") or 0
		local timeRemaining = nextTime - workspace:GetServerTimeNow()

		-- Afficher le timer seulement si le joueur n'a plus de spins
		if spins <= 0 and timeRemaining > 0 then
			spinBtn.Main.Timer.Visible = true
			spinBtn.Main.Timer.Text = ("Next free spin: %s"):format(
				TimeUtils:D(timeRemaining)
			)
		elseif spins >= 1 then
			-- Le joueur a des spins, cacher le timer
			spinBtn.Main.Timer.Visible = false
		else
			-- Plus de spins mais l'event est actif, afficher "Ready"
			spinBtn.Main.Timer.Visible = true
			spinBtn.Main.Timer.Text = "Free spin ready!"
		end
	end

	Timer.Simple(1, UpdateUI)

	SpinRE.OnClientEvent:Connect(function(index)
		task.spawn(UpdateUI)
		PlaySpinAnimation(index)
	end)

	Observers.observeTag("CyberSpinWheel", function(model)
		local wheel = CyberSpinWheelClass.new(model)
		return function()
			wheel:Destroy()
		end
	end)

	local trove = Trove.new()

	local function RenderLuckyBlock()
		trove:Clean()

		for _, reward in CyberWheelData.Rewards do
			if reward.Type == "Animal" and reward.Index == "Secret Lucky Block" then
				local list = {}

				for _, data in LuckyBlocks[reward.Index].Animals do
					if (not data.IsEnabled or data.IsEnabled()) and data.Chance then
						table.insert(list, data)
					end
				end

				table.sort(list, function(a, b)
					return b.Chance < a.Chance
				end)

				for i, data in ipairs(list) do
					local clone = trove:Clone(CyberWheelUI.LuckyBlock.Contents.Template)
					clone.LayoutOrder = i
					clone.Label.Text = Animals[data.Name].DisplayName
					clone.Chance.Text = ("%s%%"):format(data.Chance)
					clone.Visible = true
					clone.Parent = CyberWheelUI.LuckyBlock.Contents

					local model = SharedAnimals:AttachOnViewport(
						data.Name,
						clone.ViewportFrame,
						true,
						reward.Mutation
					)

					if model then
						trove:Add(model)
					end
				end
			end
		end
	end

	Interface.OnOpen:Connect(RenderLuckyBlock)
	Updates.OnUpdateEnabled:Connect(RenderLuckyBlock)
	Updates.OnUpdateDisabled:Connect(RenderLuckyBlock)
end

function Controller.Start(self)
	self:SetupCyberWheel()
end

return Controller