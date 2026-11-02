--credit to quartz games studio
local v1 = script.Parent
local LocalPlayer = game.Players.LocalPlayer
local Networking = require(game.ReplicatedStorage.SharedModules.Networking)
local DevProductController = require(LocalPlayer.PlayerScripts.Controllers.DevProductController)
local Base_Speed = v1:WaitForChild("Base_Speed")
local Max_Backpack = v1:WaitForChild("Max_Backpack")
local Base_Jump = v1:WaitForChild("Base_Jump")
local Shovel_Power = v1:WaitForChild("Shovel_Power")
local StatPointsCounter = script.Parent.Parent.StatPointsCounter

local function skillPointsOn() --[[ skillPointsOn | Line: 14 ]]
	return workspace:GetAttribute("SkillPointsOn") == true
end

if workspace:GetAttribute("SkillPointsOn") == true then
	local SkillData = LocalPlayer:WaitForChild("SkillData")
	local SkillPoints = SkillData:WaitForChild("SkillPoints")
	local BaseSpeed = SkillData:WaitForChild("BaseSpeed")
	local BaseJump = SkillData:WaitForChild("BaseJump")
	local ShovelPower = SkillData:WaitForChild("ShovelPower")
	local MaxBackpack = SkillData:WaitForChild("MaxBackpack")

	local function GetUpgradeCost(p1) --[[ GetUpgradeCost | Line: 42 ]]
		return p1
	end

	local function updateSkillDisplay(p1, p2) --[[ updateSkillDisplay | Line: 46 ]]
		local Level = p1:FindFirstChild("Level")

		if not Level then
			return
		end

		if Level:IsA("TextLabel") then
			Level.Text = "Level " .. tostring(p2)
		end

		local TextLabel = Level:FindFirstChild("TextLabel")

		if not TextLabel then
			return
		end

		TextLabel.Text = "Level " .. tostring(p2)
	end

	local function updateCostDisplay(p1, p2) --[[ updateCostDisplay | Line: 59 ]]
		local PlusButton = p1:FindFirstChild("PlusButton")

		if not PlusButton then
			return
		end

		local InteriorText = PlusButton:FindFirstChild("InteriorText")

		if not InteriorText then
			return
		end

		local TextLabel = InteriorText:FindFirstChild("TextLabel")

		if TextLabel and TextLabel:IsA("TextLabel") then
			TextLabel.Text = tostring(p2)
		end

		local v2 = if TextLabel then TextLabel:FindFirstChild("TextLabel") else TextLabel

		if not (v2 and v2:IsA("TextLabel")) then
			return
		end

		v2.Text = tostring(p2)
	end

	local function updateUI() --[[ updateUI | Line: 75 | Upvalues: SkillPoints (copy), Base_Speed (copy), BaseSpeed (copy), Base_Jump (copy), BaseJump (copy), Shovel_Power (copy), ShovelPower (copy), Max_Backpack (copy), MaxBackpack (copy), updateCostDisplay (copy), StatPointsCounter (copy) ]]
		local v1 = SkillPoints.Value
		local v3 = BaseSpeed.Value
		local Level = Base_Speed:FindFirstChild("Level")

		if Level then
			if Level:IsA("TextLabel") then
				Level.Text = "Level " .. tostring(v3)
			end

			local TextLabel = Level:FindFirstChild("TextLabel")

			if TextLabel then
				TextLabel.Text = "Level " .. tostring(v3)
			end
		end

		local v5 = BaseJump.Value
		local Level2 = Base_Jump:FindFirstChild("Level")

		if Level2 then
			if Level2:IsA("TextLabel") then
				Level2.Text = "Level " .. tostring(v5)
			end

			local TextLabel = Level2:FindFirstChild("TextLabel")

			if TextLabel then
				TextLabel.Text = "Level " .. tostring(v5)
			end
		end

		local v7 = ShovelPower.Value
		local Level3 = Shovel_Power:FindFirstChild("Level")

		if Level3 then
			if Level3:IsA("TextLabel") then
				Level3.Text = "Level " .. tostring(v7)
			end

			local TextLabel = Level3:FindFirstChild("TextLabel")

			if TextLabel then
				TextLabel.Text = "Level " .. tostring(v7)
			end
		end

		local v9 = MaxBackpack.Value
		local Level4 = Max_Backpack:FindFirstChild("Level")

		if Level4 then
			if Level4:IsA("TextLabel") then
				Level4.Text = "Level " .. tostring(v9)
			end

			local TextLabel = Level4:FindFirstChild("TextLabel")

			if TextLabel then
				TextLabel.Text = "Level " .. tostring(v9)
			end
		end

		updateCostDisplay(Base_Speed, BaseSpeed.Value)
		updateCostDisplay(Base_Jump, BaseJump.Value)
		updateCostDisplay(Shovel_Power, ShovelPower.Value)
		updateCostDisplay(Max_Backpack, MaxBackpack.Value)
		StatPointsCounter.Text = tostring(v1) .. " points available"
		Base_Speed.PlusButton.Fade.Visible = v1 < BaseSpeed.Value
		Base_Jump.PlusButton.Fade.Visible = v1 < BaseJump.Value
		Shovel_Power.PlusButton.Fade.Visible = v1 < ShovelPower.Value
		Max_Backpack.PlusButton.Fade.Visible = v1 < MaxBackpack.Value
	end

	SkillPoints.Changed:Connect(updateUI)
	BaseSpeed.Changed:Connect(updateUI)
	BaseJump.Changed:Connect(updateUI)
	ShovelPower.Changed:Connect(updateUI)
	MaxBackpack.Changed:Connect(updateUI)
	updateUI()

	local v3 = 0
	local TweenService = game:GetService("TweenService")
	local FX_UI = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("FX_UI")
	local v4 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
	local SfxController = require(game.StarterPlayer.StarterPlayerScripts.Controllers.SfxController)

	local function PLAYEFFECT(p1) --[[ PLAYEFFECT | Line: 123 | Upvalues: FX_UI (copy), TweenService (copy), v4 (copy), SfxController (copy) ]]
		local Frame = Instance.new("Frame")

		Frame.Parent = FX_UI
		Frame.BackgroundColor3 = Color3.new(255/255, 255/255, 255/255)
		Frame.AnchorPoint = Vector2.new(0.5, 0.5)
		Frame.Size = UDim2.new(0, p1.AbsoluteSize.X, 0, p1.AbsoluteSize.Y * 1.5)
		Frame.Position = UDim2.new(0, p1.AbsolutePosition.X + p1.AbsoluteSize.X / 2, 0, p1.AbsolutePosition.Y + p1.AbsoluteSize.Y / 2)

		local v1 = TweenService:Create(Frame, v4, {
			BackgroundTransparency = 1,
			Size = Frame.Size + UDim2.new(0.1, 0, 0, 0)
		})

		v1:Play()
		game.Debris:AddItem(Frame, v4.Time)
		game.Debris:AddItem(v1, v4.Time)
		SfxController:PlaySFX("Purchase")
	end

	local function spendPoint(p1, p2, p3) --[[ spendPoint | Line: 137 | Upvalues: SkillPoints (copy), v3 (ref), PLAYEFFECT (copy), Networking (copy) ]]
		if p3.Value > SkillPoints.Value then
			return
		end

		local v1 = tick()

		if not (v1 - v3 < 0.05) then
			v3 = v1
			PLAYEFFECT(p2)
			Networking.SkillPoints.SpendSkillPoint:Fire(p1)
		end
	end

	Base_Speed.PlusButton.MouseButton1Click:Connect(function() --[[ Line: 148 | Upvalues: Base_Speed (copy), BaseSpeed (copy), SkillPoints (copy), v3 (ref), PLAYEFFECT (copy), Networking (copy) ]]
		local v1 = Base_Speed

		if BaseSpeed.Value > SkillPoints.Value then
			return
		end

		local v2 = tick()

		if not (v2 - v3 < 0.05) then
			v3 = v2
			PLAYEFFECT(v1)
			Networking.SkillPoints.SpendSkillPoint:Fire("BaseSpeed")
		end
	end)
	Base_Jump.PlusButton.MouseButton1Click:Connect(function() --[[ Line: 152 | Upvalues: Base_Jump (copy), BaseJump (copy), SkillPoints (copy), v3 (ref), PLAYEFFECT (copy), Networking (copy) ]]
		local v1 = Base_Jump

		if BaseJump.Value > SkillPoints.Value then
			return
		end

		local v2 = tick()

		if not (v2 - v3 < 0.05) then
			v3 = v2
			PLAYEFFECT(v1)
			Networking.SkillPoints.SpendSkillPoint:Fire("BaseJump")
		end
	end)
	Shovel_Power.PlusButton.MouseButton1Click:Connect(function() --[[ Line: 156 | Upvalues: Shovel_Power (copy), ShovelPower (copy), SkillPoints (copy), v3 (ref), PLAYEFFECT (copy), Networking (copy) ]]
		local v1 = Shovel_Power

		if ShovelPower.Value > SkillPoints.Value then
			return
		end

		local v2 = tick()

		if not (v2 - v3 < 0.05) then
			v3 = v2
			PLAYEFFECT(v1)
			Networking.SkillPoints.SpendSkillPoint:Fire("ShovelPower")
		end
	end)
	Max_Backpack.PlusButton.MouseButton1Click:Connect(function() --[[ Line: 160 | Upvalues: Max_Backpack (copy), MaxBackpack (copy), SkillPoints (copy), v3 (ref), PLAYEFFECT (copy), Networking (copy) ]]
		local v1 = Max_Backpack

		if MaxBackpack.Value > SkillPoints.Value then
			return
		end

		local v2 = tick()

		if not (v2 - v3 < 0.05) then
			v3 = v2
			PLAYEFFECT(v1)
			Networking.SkillPoints.SpendSkillPoint:Fire("MaxBackpack")
		end
	end)

	local t = {
		39,
		89,
		139,
		189,
		239,
		289,
		339,
		389,
		439,
		489
	}

	local function GetTier(p1) --[[ GetTier | Line: 170 ]]
		return math.clamp(p1 // 5 + 1, 1, 10)
	end

	local function GetTierPrice(p1) --[[ GetTierPrice | Line: 174 | Upvalues: t (copy) ]]
		return t[math.clamp(p1 // 5 + 1, 1, 10)]
	end

	local function UpdateRobuxButtonPrice(p1, p2) --[[ UpdateRobuxButtonPrice | Line: 180 | Upvalues: t (copy) ]]
		local RobuxButton = p1:FindFirstChild("RobuxButton")

		if not RobuxButton then
			return
		end

		local v1 = t[math.clamp(p2 // 5 + 1, 1, 10)]
		local TextLabel = RobuxButton:FindFirstChild("TextLabel")

		if TextLabel and TextLabel:IsA("TextLabel") then
			TextLabel.RichText = true
			TextLabel.Text = ("<font family=\"rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json\" weight=\"400\">robux</font> %*"):format(v1)
		end

		local v2 = if TextLabel then TextLabel:FindFirstChild("TextLabel") else TextLabel

		if not (v2 and v2:IsA("TextLabel")) then
			return
		end

		v2.RichText = true
		v2.Text = ("<font family=\"rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json\" weight=\"400\">robux</font> %*"):format(v1)
	end

	local RobuxButton = Max_Backpack:FindFirstChild("RobuxButton")

	if RobuxButton and RobuxButton:IsA("GuiObject") then
		RobuxButton.Visible = false
	end

	local function UpdateAllRobuxPrices() --[[ UpdateAllRobuxPrices | Line: 205 | Upvalues: UpdateRobuxButtonPrice (copy), Base_Speed (copy), BaseSpeed (copy), Base_Jump (copy), BaseJump (copy), Shovel_Power (copy), ShovelPower (copy) ]]
		UpdateRobuxButtonPrice(Base_Speed, BaseSpeed.Value)
		UpdateRobuxButtonPrice(Base_Jump, BaseJump.Value)
		UpdateRobuxButtonPrice(Shovel_Power, ShovelPower.Value)
	end

	BaseSpeed.Changed:Connect(UpdateAllRobuxPrices)
	BaseJump.Changed:Connect(UpdateAllRobuxPrices)
	ShovelPower.Changed:Connect(UpdateAllRobuxPrices)
	UpdateRobuxButtonPrice(Base_Speed, BaseSpeed.Value)
	UpdateRobuxButtonPrice(Base_Jump, BaseJump.Value)
	UpdateRobuxButtonPrice(Shovel_Power, ShovelPower.Value)

	local v5 = false

	local function PromptSkillUpgrade(p1, p2) --[[ PromptSkillUpgrade | Line: 218 | Upvalues: v5 (ref), DevProductController (copy) ]]
		if not v5 then
			v5 = true
			DevProductController:PromptPurchase((("SkillUpgrade:%*:%*"):format(p1, (math.clamp(p2.Value // 5 + 1, 1, 10)))))
			task.wait(1)
			v5 = false
		end
	end

	for v6, v7 in {
		{
			name = "Base Speed",
			frame = Base_Speed,
			value = BaseSpeed
		},
		{
			name = "Base Jump",
			frame = Base_Jump,
			value = BaseJump
		},
		{
			name = "Shovel Power",
			frame = Shovel_Power,
			value = ShovelPower
		}
	} do
		local RobuxButton2 = v7.frame:FindFirstChild("RobuxButton")

		if RobuxButton2 and RobuxButton2:IsA("GuiButton") then
			RobuxButton2.MouseButton1Click:Connect(function() --[[ Line: 242 | Upvalues: v7 (copy), v5 (ref), DevProductController (copy) ]]
				local name = v7.name
				local value = v7.value

				if not v5 then
					v5 = true
					DevProductController:PromptPurchase((("SkillUpgrade:%*:%*"):format(name, (math.clamp(value.Value // 5 + 1, 1, 10)))))
					task.wait(1)
					v5 = false
				end
			end)
		end
	end
else
	local v8 = script.Parent.Parent

	v8.Visible = false

	local GardenStatsHeader = v8.Parent:FindFirstChild("GardenStatsHeader")

	if not (GardenStatsHeader and GardenStatsHeader:IsA("GuiObject")) then
		return
	end

	GardenStatsHeader.Visible = false
end