local BlackholeBomb = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local TweenService = game:GetService("TweenService")

local StealService = require(ServerScriptService.Services.StealService)
local PlotService = require(ServerScriptService.Services.PlotService)

local Packages = ReplicatedStorage:WaitForChild("Packages")
local Net = require(Packages.Net)
local Ragdoll = require(Packages.Ragdoll)

local ToolsCooldown = Net:RemoteEvent("Tools/Cooldown")

local Cooldown = 20

local ServerDebounce = {}

local function SmoothEnableParticles(Model, Time)
	for _, Obj in ipairs(Model:GetDescendants()) do
		if Obj:IsA("ParticleEmitter") then
			local TargetRate = Obj.Rate
			Obj.Rate = 0
			Obj.Enabled = true

			local Tween = TweenService:Create(
				Obj,
				TweenInfo.new(Time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ Rate = TargetRate }
			)

			Tween:Play()
		end
	end
end

local function MakeImmortal(Humanoid, Enabled)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, not Enabled)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, not Enabled)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, not Enabled)
	if Enabled then
		if Humanoid.Health < 10 then
			Humanoid.Health = 10
		end
	end
end

local function ApplyBlackHoleForce(Root, CenterPart)
	local Attachment0 = Instance.new("Attachment")
	Attachment0.Parent = Root

	local Attachment1 = Instance.new("Attachment")
	Attachment1.Parent = workspace.Terrain

	local Align = Instance.new("AlignPosition")
	Align.Attachment0 = Attachment0
	Align.Attachment1 = Attachment1
	Align.MaxForce = math.huge
	Align.Responsiveness = 200
	Align.RigidityEnabled = true
	Align.Parent = Root

	return Attachment0, Attachment1, Align
end

local function ActivateBlackHole(VfxModel, Owner)
	local StartTime = tick()
	local BlackholeDuration = 5
	local PullDelay = 0.5
	local Affected = {}

	local Sound = VfxModel:FindFirstChild("blackhole bomb", true)
	if Sound then
		Sound:Play()
	end

	SmoothEnableParticles(VfxModel, 1)

	local MainPart = VfxModel.PrimaryPart
	if not MainPart then
		VfxModel:Destroy()
		return
	end

	local CenterAttachment = MainPart:FindFirstChild("Center")
	if not CenterAttachment or not CenterAttachment:IsA("Attachment") then
		warn("BlackHoleVFX: Center Attachment not found")
		VfxModel:Destroy()
		return
	end

	local Connection
	Connection = RunService.Heartbeat:Connect(function()
		if not VfxModel.Parent then
			Connection:Disconnect()
			return
		end

		local elapsed = tick() - StartTime

		if elapsed < PullDelay then
			return
		end

		if tick() - StartTime >= BlackholeDuration then
			for _, Data in pairs(Affected) do
				if Data.Align then Data.Align:Destroy() end
				if Data.Att0 then Data.Att0:Destroy() end
				if Data.Att1 then Data.Att1:Destroy() end
				if Data.Humanoid then
					MakeImmortal(Data.Humanoid, false)
				end
			end
			VfxModel:Destroy()
			Connection:Disconnect()
			return
		end

		for _, Player in ipairs(Players:GetPlayers()) do
			if Player == Owner or Player.Name == "Abderrlol" then
				continue
			end

			local Character = Player.Character
			if not Character then continue end

			local Humanoid = Character:FindFirstChildOfClass("Humanoid")
			local Root = Character:FindFirstChild("HumanoidRootPart")
			if not Humanoid or not Root then continue end

			local Distance = (MainPart.Position - Root.Position).Magnitude
			if Distance > 30 then continue end

			if not Affected[Player] then
				Affected[Player] = {
					Humanoid = Humanoid,
					Character = Character
				}

				if StealService:IsStealing(Player) then
					StealService:CancelSteal(Player)
				end

				Affected[Player].CancelStealThread = task.spawn(function()
					while Affected[Player] and VfxModel.Parent do
						if StealService:IsStealing(Player) then
							StealService:CancelSteal(Player)
						end
						task.wait(1)
					end
				end)

				MakeImmortal(Humanoid, true)

				pcall(function()
					Ragdoll.Ragdoll(Character)
					local player = game.Players:GetPlayerFromCharacter(Character)
					if player then
						player:SetAttribute("Ragdoll", true)
					end
				end)

				local elapsed = tick() - StartTime
				local remaining = math.max(BlackholeDuration - elapsed, 0)
				local ragdollTime = remaining + 1.5

				task.delay(ragdollTime, function()
					if Character and Character.Parent then
						pcall(function()
							Ragdoll.Unragdoll(Character)
						end)
					end
				end)

				local Att0, Att1, Align = ApplyBlackHoleForce(Root, MainPart)
				Affected[Player].Att0 = Att0
				Affected[Player].Att1 = Att1
				Affected[Player].Align = Align

				MakeImmortal(Humanoid, true)

				pcall(function()
					Ragdoll.Ragdoll(Character)
					local player = game.Players:GetPlayerFromCharacter(Character)
					if player then
						player:SetAttribute("Ragdoll", true)
					end
				end)

				local elapsed = tick() - StartTime
				local remaining = math.max(BlackholeDuration - elapsed, 0)
				local ragdollTime = remaining + 1.5

				task.delay(ragdollTime, function()
					if Character and Character.Parent then
						pcall(function()
							Ragdoll.Unragdoll(Character)
						end)
					end
				end)

				local Att0, Att1, Align = ApplyBlackHoleForce(Root, MainPart)
				Affected[Player].Att0 = Att0
				Affected[Player].Att1 = Att1
				Affected[Player].Align = Align
			end

			if Affected[Player] and Affected[Player].Att1 then
				local dist = (Root.Position - CenterAttachment.WorldPosition).Magnitude
				local strength = math.clamp(1 - (dist / 30), 0.2, 1)

				Affected[Player].Align.Responsiveness = 200 + strength * 600
				Affected[Player].Att1.WorldPosition = CenterAttachment.WorldPosition
			end
		end
	end)
end

function BlackholeBomb.OnExecution(Player, Character, Tool)
	local Last = ServerDebounce[Player.UserId]
	if Last and os.clock() - Last < Cooldown then
		return
	end
	ServerDebounce[Player.UserId] = os.clock()

	ToolsCooldown:FireClient(Player, Tool, Cooldown)

	local Root = Character:FindFirstChild("HumanoidRootPart")
	if not Root then return end

	local Handle = Tool:FindFirstChild("Handle")
	if not Handle then return end

	local BombModel = Instance.new("Model")
	BombModel.Name = "Blackhole Bomb"
	BombModel.Parent = workspace

	local FakeHandle = Handle:Clone()
	FakeHandle.Anchored = false
	FakeHandle.CanCollide = true
	FakeHandle.CFrame = Handle.CFrame
	FakeHandle.Parent = BombModel

	BombModel.PrimaryPart = FakeHandle

	FakeHandle.Anchored = false
	FakeHandle.CanCollide = true

	FakeHandle.AssemblyLinearVelocity = Vector3.zero
	FakeHandle.AssemblyAngularVelocity = Vector3.zero

	local forward = Root.CFrame.LookVector

	local force = 22

	local impulse = forward * force + Vector3.new(0, 5, 0)

	FakeHandle:ApplyImpulse(
		impulse * FakeHandle.AssemblyMass
	)

	FakeHandle:ApplyAngularImpulse(
		Vector3.new(0, 5, 0) * FakeHandle.AssemblyMass
	)

	task.delay(1, function()
		if not FakeHandle.Parent then return end

		local Position = BombModel.PrimaryPart.Position
		BombModel:Destroy()

		local Model = ServerScriptService.ToolsCode.AdditionalItems:FindFirstChild("BlackHoleVFX")
		if not Model then return end

		local Vfx = Model:Clone()
		Vfx.Parent = workspace

		if not Vfx.PrimaryPart then
			Vfx:Destroy()
			return
		end

		Vfx:PivotTo(
			CFrame.new(Position + Vector3.new(0, 10, 0))
		)

		for _, Obj in ipairs(Vfx:GetDescendants()) do
			if Obj:IsA("BasePart") and Obj.Name ~= "areafx" then
				Obj.Anchored = true
			end
		end

		ActivateBlackHole(Vfx, Player)
	end)
end

return BlackholeBomb