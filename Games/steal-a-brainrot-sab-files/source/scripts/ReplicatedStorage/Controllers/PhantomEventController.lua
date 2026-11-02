-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Controllers = ReplicatedStorage:WaitForChild("Controllers")
local InterfaceController = require(Controllers.InterfaceController)

require(Controllers.ShopController)

local NotificationController = require(Controllers.NotificationController)

require(Controllers.SoundController)

local Updates = require(ReplicatedStorage.Shared.Updates)
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
local LuckyBlocks = require(Datas.LuckyBlocks)
local PhantomSpinWheel = require(Datas.PhantomSpinWheel)
local Animals = require(ReplicatedStorage.Datas.Animals)
local Shop = require(Datas.Shop)
local Classes = ReplicatedStorage:WaitForChild("Classes")
local PhantomSpinWheel2 = require(script.PhantomSpinWheel)
local AnimatedButton = require(Classes.AnimatedButton)
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Marketplace = require(Shared.Marketplace)
local Animals2 = require(ReplicatedStorage.Shared.Animals)
local Policy = require(ReplicatedStorage.Shared.Policy)
local LocalPlayer = Players.LocalPlayer
local PhantomWheel = LocalPlayer.PlayerGui:WaitForChild("PhantomWheel").PhantomWheel
local u33 = nil
local u34 = false
local v35 = Net:RemoteEvent("ShopService/Purchase")
local v36 = Net:RemoteEvent("PhantomEventService/Spin")
local u37 = false
local t1 = {}

local function IsEnabled()
	return ReplicatedStorage:GetAttribute("PhantomEvent")
end
local function ResultAnimation(n1: number, b1: boolean?)
	local v43 = Synchronizer:Wait(LocalPlayer)

	if u37 then
		return
	end

	u37 = true

	local Wheel = PhantomWheel.Wheel
	local Spinning = SoundService:FindFirstChild("Spinning")
	local v46 = not u34 and 0.8 or 1

	if Spinning then
		Spinning.Looped = true
		Spinning.Volume = v46
		Spinning:Play()
	end

	local v47 = (n1 - 1) * -60 - (math.random() - 0.5) * 0.7 * 60
	local v48 = v47 + (not u34 and 9 or 1) * 360
	local v49 = not u34 and 5 or 0.5
	local u50 = nil
	local connection = RunService.PostSimulation:Connect(function()
		debug.profilebegin("PhantomEventController:ResultAnimation")

		local v76 = (Wheel.Rotation + 30) / 60 // 1

		if v76 ~= u50 then
			u50 = v76
			PhantomWheel.Tick.Rotation = -40
			TweenService:Create(PhantomWheel.Tick, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				Rotation = 0
			}):Play()
		end

		debug.profileend()
	end)
	local tweenInfo = TweenInfo.new(v49, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	local tween = TweenService:Create(Wheel, tweenInfo, {
		Rotation = v48
	})

	if Spinning then
		TweenService:Create(Spinning, TweenInfo.new(v49, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			Volume = 0
		}):Play()
	end

	tween:Play()
	tween.Completed:Wait()
	connection:Disconnect()
	Wheel.Rotation = v47

	if Spinning then
		Spinning:Stop()
		Spinning.Volume = v46
	end

	local v54 = b1 == true and PhantomSpinWheel.AltRewards[n1] or PhantomSpinWheel.Rewards[n1]
	local v58

	if v54.Type == "Cash-Pack" then
		local v55 = Shop[v54.Index]

		if not v55 then
			u37 = false

			return false
		end

		local v56 = v55.Value or 0
		local v57 = v43:Get("Rebirth") or 0

		if v57 > 0 then
			v56 *= if not (v57 <= 1) then v57 else 1.5
		end

		v58 = `${ NumberUtils:ToString(v56, 2) }`
	else
		v58 = v54.Display
	end

	NotificationController:Success(`You received { v58 }!`)
	u37 = false
end

function t1.SetupPhantomWheel(_)
	u33 = InterfaceController:Register("PhantomWheel", PhantomWheel, "TopQuint")
	u33:AttachCloseButton(PhantomWheel.Close)
	u33:Close()

	local v60 = Synchronizer:Wait(LocalPlayer)

	local function setup()
		local Wheel = PhantomWheel.Wheel
		local Items = Wheel.Items
		local Names = Wheel.Names
		local Odds = Wheel.Odds
		local t2 = {}

		for i = 1, #PhantomSpinWheel.Rewards do
			local v83 = PhantomSpinWheel.Rewards[i]

			if v83 then
				if v83.Type == "Item" and v60:Get(`Items.{ v83.Index }`) and PhantomSpinWheel.AltRewards[i] then
					v83 = PhantomSpinWheel.AltRewards[i]
				end

				t2[i] = v83.Weight
			end
		end

		local n2 = 0

		for _, v86 in t2 do
			n2 += v86
		end

		t2[5] = t2[5] + (100 - n2)

		for i = 1, #PhantomSpinWheel.Rewards do
			local v88 = PhantomSpinWheel.Rewards[i]

			if v88 then
				if v88.Type == "Item" and v60:Get(`Items.{ v88.Index }`) and PhantomSpinWheel.AltRewards[i] then
					v88 = PhantomSpinWheel.AltRewards[i]
				end

				local i2 = Items:FindFirstChild(i)
				local i3 = Names:FindFirstChild(i)
				local i4 = Odds:FindFirstChild(i)
				local s1 = ""
				local Icon

				if v88.Type == "Cash-Pack" then
					local Value = Shop[v88.Index].Value
					local v94 = v60:Get("Rebirth") or 0

					if v94 > 0 then
						Value *= if not (v94 <= 1) then v94 else 1.5
					end

					s1 = `${ NumberUtils:ToString(Value, 2) }`

					local Index = v88.Index

					Icon = Marketplace:GetProductInfo(Index, "Product").Icon
				else
					Icon = v88.Icon
				end

				local Display = v88.Display
				local v98 = s1 == "" and Display or s1
				local v99 = `{ math.floor(t2[i] * 100) / 100 }%`

				i2.Image = Icon
				i3.Text = v98
				i4.Text = v99
			end
		end
	end

	setup()
	v60:OnDictionaryInserted("Items", function(_: boolean, s2: string)
		local v102 = false

		for i = 1, #PhantomSpinWheel.Rewards do
			local v104 = PhantomSpinWheel.Rewards[i]

			if v104.Type == "Item" and s2 == v104.Index then
				v102 = true

				break
			end
		end

		if v102 then
			while u37 do
				task.wait()
			end

			setup()
		end
	end)

	local Toggle = PhantomWheel.FastSpin.Toggle
	local v63 = AnimatedButton.new(Toggle)

	v63:Animate()

	local function updateFastSpin()
		Toggle.Checkmark.Visible = u34
	end

	v63.OnActivated:Connect(function()
		u34 = not u34
		Toggle.Checkmark.Visible = u34
	end)
	Toggle.Checkmark.Visible = u34

	for _, child in PhantomWheel.Buttons:GetChildren() do
		if child:IsA("ImageButton") and child.Name ~= "Spin" then
			local v67 = AnimatedButton.new(child)

			v67:Animate()
			v67.OnActivated:Connect(function()
				v35:FireServer(child:GetAttribute("ProductId"))
			end)

			local ProductInfo = Marketplace:GetProductInfo(child:GetAttribute("ProductId"), "Product")

			child.RbxAmount.Text = ProductInfo.PriceInRobux
		end
	end

	local Spin = PhantomWheel.Buttons.Spin
	local v70 = AnimatedButton.new(Spin)

	v70:Animate()
	v70.OnActivated:Connect(function()
		if u37 == true then
			return
		end

		v36:FireServer()
	end)

	local u71 = nil

	task.spawn(function()
		u71 = Policy.getPolicy(LocalPlayer)
	end)

	local function mainLoop()
		local n3 = 0

		if ReplicatedStorage:GetAttribute("PhantomEvent") then
			if v60:Get("PhantomSpinWheel.LastFreeClaimed") ~= ReplicatedStorage:GetAttribute("PhantomEventLastTime") then
				n3 += 1
				Spin.Main.Timer.Text = "SPIN NOW"
			else
				Spin.Main.Timer.Text = `Free Spin in { TimeUtils:D((ReplicatedStorage:GetAttribute("NextPhantomEvent") or 0) - workspace:GetServerTimeNow()) }`
			end
		else
			Spin.Main.Timer.Text = `Free Spin in { TimeUtils:D((ReplicatedStorage:GetAttribute("NextPhantomEvent") or 0) - workspace:GetServerTimeNow()) }`
		end

		local v106 = n3 + v60:Get("PhantomSpinWheel.Spins")

		Spin.Main.Spins.Text = v106 > 1 and `Spins ({ v106 })` or `Spin ({ v106 })`
		Spin.Main.UIGradient.Enabled = v106 <= 0

		local v107 = u71 and not u71.ArePaidRandomItemsRestricted
		local v108 = workspace:GetServerTimeNow() - v60:Get("PhantomSpinWheel.LastDailyDiscount") >= 86400

		PhantomWheel.Buttons.Buy1.Visible = not v108 and v107
		PhantomWheel.Buttons.Buy1Discount.Visible = v108 and v107

		local v109 = v60:Get("PhantomSpinWheel.PaidSpins.x3") >= 5

		PhantomWheel.Buttons.Buy10.Visible = v109 and v107
		PhantomWheel.Buttons.Buy3.Visible = not v109 and v107
	end

	v36.OnClientEvent:Connect(function(n4: number, b3: boolean?)
		task.spawn(mainLoop)
		ResultAnimation(n4, b3)
	end)
	Timer.Simple(1, mainLoop)
	Observers.observeTag("PhantomSpinWheel", function(p2)
		local v113 = PhantomSpinWheel2.new(p2)

		return function()
			v113:Destroy()
		end
	end)
	ReplicatedStorage:GetAttributeChangedSignal("PhantomWheelActive"):Connect(function()
		if ReplicatedStorage:GetAttribute("PhantomWheelActive") == false and u33:IsOpened() then
			InterfaceController:Toggle("PhantomWheel", false)
		end
	end)

	local v73 = Trove.new()

	local function renderLuckyBlock()
		v73:Clean()

		if not u33:IsOpened() then
			return
		end

		for _, v115 in PhantomSpinWheel.Rewards do
			if v115.Type == "Animal" and v115.Index == "Secret Lucky Block" then
				local Mutation = v115.Mutation
				local t3 = {}

				for _, v119 in LuckyBlocks[v115.Index].Animals do
					if (not v119.IsEnabled or v119.IsEnabled()) and v119.Chance then
						table.insert(t3, {
							animal = v119.Name,
							chance = v119.Chance
						})
					end
				end

				table.sort(t3, function(p3, p4)
					return p4.chance < p3.chance
				end)

				for v120, v121 in t3 do
					local clone = v73:Clone(PhantomWheel.LuckyBlock.Contents.Template)

					clone.Name = tostring(v120)
					clone.LayoutOrder = v120
					clone.Label.Text = Animals[v121.animal].DisplayName
					clone.Chance.Text = `{ v121.chance }%`
					clone.Visible = true
					clone.Parent = PhantomWheel.LuckyBlock.Contents

					local v123 = Animals2:AttachOnViewport(v121.animal, clone.ViewportFrame, true, Mutation)

					if v123 then
						v73:Add(v123)
					end
				end

				return
			end
		end
	end

	u33.OnOpen:Connect(renderLuckyBlock)
	u33.OnClose:Connect(function()
		v73:Clean()
	end)
	Updates.OnUpdateEnabled:Connect(renderLuckyBlock)
	Updates.OnUpdateDisabled:Connect(renderLuckyBlock)
end
function t1.Start(p5)
	task.spawn(function()
		p5:SetupPhantomWheel()
	end)
end

return t1
