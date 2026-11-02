-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local GameplayToolGuard = require(ServerScriptService.Library.Tools.Internal.GameplayToolGuard)
local Player = require(ReplicatedStorage.Library.Player)
local Ragdoll = require(ReplicatedStorage.Library.Modules.Ragdoll)
local v1 = script.Parent
local v2 = v1.Parent

assert(v2:IsA("Model"), "Sentry turret script parent must be inside the sentry Model")

local v4 = 0
local v5 = false

local function getOwnerPlayer() --[[ getOwnerPlayer | Line: 54 | Upvalues: v2 (copy), Players (copy) ]]
	local v1 = v2:GetAttribute("Owner")

	if typeof(v1) ~= "string" then
		return nil
	end

	for i, v in ipairs(Players:GetPlayers()) do
		if v.Name == v1 then
			return v
		end
	end

	return nil
end

local function getPlayerTarget(p1, p2, p3) --[[ getPlayerTarget | Line: 68 | Upvalues: GameplayToolGuard (copy), Player (copy) ]]
	if p1 == p3 or not GameplayToolGuard.IsPlayerInGameplayArea(p1) then
		return nil
	end

	local Character = p1.Character
	local v1 = Player.Optional.Humanoid(p1)
	local v2 = Player.Optional.HumanoidRootPart(p1)

	if Character == nil or (v1 == nil or (v2 == nil or v1.Health <= 0)) then
		return nil
	end

	local Magnitude = (v2.Position - p2).Magnitude

	if Magnitude > 50 then
		return nil
	end

	return {
		Player = p1,
		Character = Character,
		Root = v2,
		Distance = Magnitude
	}
end

local function getNearestTarget() --[[ getNearestTarget | Line: 93 | Upvalues: getOwnerPlayer (copy), GameplayToolGuard (copy), v1 (copy), Players (copy), getPlayerTarget (copy) ]]
	local v12 = getOwnerPlayer()

	if v12 == nil or not GameplayToolGuard.IsPlayerInGameplayArea(v12) then
		return nil
	end

	local Position = v1.Position
	local v2 = nil

	for i, v in ipairs(Players:GetPlayers()) do
		local v3 = getPlayerTarget(v, Position, v12)

		if v3 ~= nil and (v2 == nil or v3.Distance < v2.Distance) then
			v2 = v3
		end
	end

	return v2
end

local function lookAt(p1) --[[ lookAt | Line: 110 | Upvalues: v1 (copy), v2 (copy) ]]
	local Position = v1.Position
	local Position2 = p1.Position

	v1.CFrame = CFrame.new(Position, (Vector3.new(Position2.X, Position.Y, Position2.Z)))
	v2.Main.CFrame = v1.CFrame + v1.CFrame.LookVector * 1.6

	local Main = v2.Main

	Main.CFrame = Main.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
	v2.Shotpart.CFrame = v1.CFrame + v1.CFrame.LookVector * 1.6

	local Shotpart = v2.Shotpart

	Shotpart.CFrame = Shotpart.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
	v2.Scanner.CFrame = v1.CFrame + v1.CFrame.LookVector * 1.6

	local Scanner = v2.Scanner

	Scanner.CFrame = Scanner.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
end

local function findPlayerFromHit(p1) --[[ findPlayerFromHit | Line: 124 | Upvalues: Players (copy) ]]
	local v1 = p1.Parent

	while v1 ~= nil do
		if v1:IsA("Model") then
			local v2 = Players:GetPlayerFromCharacter(v1)

			if v2 ~= nil then
				return v2, v1
			end
		end

		v1 = v1.Parent
	end

	return nil, nil
end

local function applyPlayerHit(p1, p2) --[[ applyPlayerHit | Line: 138 | Upvalues: getOwnerPlayer (copy), GameplayToolGuard (copy), Player (copy), v1 (copy), Ragdoll (copy) ]]
	local v12 = getOwnerPlayer()

	if v12 == nil or (p1 == v12 or not GameplayToolGuard.IsPlayerInGameplayArea(p1)) then
		return
	end

	local v2 = Player.Optional.HumanoidRootPart(p1)

	if v2 ~= nil then
		Ragdoll.TimedRagdoll(p2, 2, (v1.CFrame.LookVector * 50 + Vector3.new(5, 10, 5)) * v2.AssemblyMass)
		GameplayToolGuard.DropHeldEggFromPlayerHit(p1)
	end
end

local function createBullet() --[[ createBullet | Line: 156 | Upvalues: v1 (copy), Workspace (copy) ]]
	local Bullet = Instance.new("Part")

	Bullet.Name = "Bullet"
	Bullet.Size = Vector3.new(0.5, 0.5, 1)
	Bullet.Material = Enum.Material.Neon
	Bullet.BrickColor = BrickColor.new("Really red")
	Bullet.CanCollide = false
	Bullet.Shape = Enum.PartType.Ball
	Bullet.CFrame = v1.CFrame + v1.CFrame.LookVector * 2
	Bullet.Parent = Workspace

	local BodyVelocity = Instance.new("BodyVelocity")

	BodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
	BodyVelocity.Velocity = v1.CFrame.LookVector * 100
	BodyVelocity.Parent = Bullet

	return Bullet
end

local function shoot(p1) --[[ shoot | Line: 175 | Upvalues: v1 (copy), lookAt (copy), createBullet (copy), findPlayerFromHit (copy), Player (copy), applyPlayerHit (copy), Debris (copy), v4 (ref) ]]
	v1.Bang:Play()
	lookAt(p1.Root)

	local v12 = createBullet()
	local t = {}

	v12.Touched:Connect(function(p1) --[[ Line: 181 | Upvalues: v12 (copy), findPlayerFromHit (ref), Player (ref), t (copy), applyPlayerHit (ref) ]]
		if v12.Parent == nil then
			return
		end

		local v1, v2 = findPlayerFromHit(p1)

		if v1 == nil or v2 == nil then
			return
		end

		local v3 = Player.Optional.Humanoid(v1)

		if v3 ~= nil and t[v3] ~= true then
			t[v3] = true
			applyPlayerHit(v1, v2)
			v12:Destroy()
		end
	end)
	Debris:AddItem(v12, 3)
	v4 = os.clock()
end

local function tweenTextTransparency(p1, p2, p3) --[[ tweenTextTransparency | Line: 205 | Upvalues: TweenService (copy) ]]
	return TweenService:Create(p1, TweenInfo.new(p3, Enum.EasingStyle.Linear), {
		TextTransparency = p2
	})
end

local function pulseText(p1) --[[ pulseText | Line: 213 | Upvalues: TweenService (copy) ]]
	local v1 = TweenService:Create(p1, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
		TextTransparency = 0.3
	})
	local v2 = TweenService:Create(p1, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
		TextTransparency = 0
	})

	v1:Play()
	v1.Completed:Once(function() --[[ Line: 217 | Upvalues: v2 (copy) ]]
		v2:Play()
	end)
end

local function createCountdownBillboard() --[[ createCountdownBillboard | Line: 222 | Upvalues: v1 (copy), pulseText (copy), v5 (ref), TweenService (copy), v2 (copy) ]]
	local CountdownBillboard = Instance.new("BillboardGui")

	CountdownBillboard.Name = "CountdownBillboard"
	CountdownBillboard.Size = UDim2.fromScale(6, 2)
	CountdownBillboard.StudsOffset = Vector3.new(0, 5, 0)
	CountdownBillboard.AlwaysOnTop = true
	CountdownBillboard.MaxDistance = 40
	CountdownBillboard.Parent = v1

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.fromScale(1, 1)
	TextLabel.BackgroundTransparency = 1
	TextLabel.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
	TextLabel.BorderSizePixel = 0
	TextLabel.Text = ""
	TextLabel.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	TextLabel.TextScaled = true
	TextLabel.Font = Enum.Font.SourceSansBold
	TextLabel.Parent = CountdownBillboard

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Thickness = 2.5
	UIStroke.Parent = TextLabel

	for i = 5, 1, -1 do
		TextLabel.Text = ("Sentry ready in %*s"):format(i)
		TextLabel.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		task.wait(1)
	end

	TextLabel.Text = ""
	pulseText(TextLabel)
	task.wait(0.1)
	CountdownBillboard.StudsOffset = Vector3.new(0, 4, 0)
	v5 = true

	for j = 60, 1, -1 do
		TextLabel.Text = ("%*s"):format(j)
		TextLabel.TextColor3 = Color3.new(255/255, 0/255, 0/255)

		if j <= 10 then
			pulseText(TextLabel)
		end

		task.wait(1)
	end

	local v12 = TweenService:Create(TextLabel, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
		TextTransparency = 1,
		BackgroundTransparency = 1
	})

	v12:Play()
	v12.Completed:Once(function() --[[ Line: 273 | Upvalues: CountdownBillboard (copy), v2 (ref) ]]
		CountdownBillboard:Destroy()

		if v2.Parent == nil then
			return
		end

		v2:Destroy()
	end)
end

task.spawn(createCountdownBillboard)

while v2.Parent ~= nil do
	if v5 then
		local v6 = getNearestTarget()

		if v6 ~= nil then
			lookAt(v6.Root)

			if os.clock() - v4 >= 1 then
				shoot(v6)
			end
		end
	end

	task.wait(0.1)
end