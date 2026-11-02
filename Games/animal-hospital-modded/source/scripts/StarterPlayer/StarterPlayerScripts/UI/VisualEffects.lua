local t = {}
local Lib = require(game.ReplicatedStorage.Lib)
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = game.Players.LocalPlayer
local v1 = Random.new()

local function playParticles(p1) --[[ playParticles | Line: 8 ]]
	for i, v in ipairs(p1.At:GetChildren()) do
		v:Emit(v.Rate)
	end

	p1.Poof:Play()
end

function PoofLocation(p1, p2, p3) --[[ PoofLocation | Line: 15 | Upvalues: LocalPlayer (copy), Lib (copy), playParticles (copy) ]]
	if not p3 and LocalPlayer:DistanceFromCharacter(p1) > 30 then
		return
	end

	local v1 = game.ReplicatedStorage:WaitForChild("Misc"):FindFirstChild(p2 or "Core"):Clone()

	v1.Parent = workspace
	v1.Position = p1
	Lib.Functional.Spawn(function() --[[ Line: 21 | Upvalues: playParticles (ref), v1 (copy) ]]
		task.wait(0.1)
		playParticles(v1)
		task.wait(3)
		v1:Destroy()
	end)

	return p1
end
Lib.Inject("PoofLocation", PoofLocation)
function PoofPlayer(p1) --[[ PoofPlayer | Line: 32 | Upvalues: Lib (copy), LocalPlayer (copy) ]]
	if not (p1.Character and p1.Character.PrimaryPart) then
		return
	end

	PoofLocation(p1.Character.PrimaryPart.Position + Lib.Constants.vy * 2)

	if p1 == LocalPlayer then
		p1.Character.Parent = game.ReplicatedStorage
		Lib.UI.Get("Teleporting").Frame.Visible = true
	else
		p1.Character:Destroy()
	end
end
function t.TweenPart(p1, p2, p3, p4) --[[ TweenPart | Line: 43 | Upvalues: Lib (copy) ]]
	Lib.Tween.new(p1, TweenInfo.new(p4 or 2, p3 and Enum.EasingStyle[p3] or Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false), p2):Play()
end
function t.TweenModelParts(p1, p2, p3, p4, p5) --[[ TweenModelParts | Line: 52 | Upvalues: t (copy) ]]
	for i, v in ipairs(p1:GetDescendants()) do
		if v:IsA("BasePart") then
			t.TweenPart(v, {
				[p2] = p3
			}, p4, p5)
		end
	end
end

local Part = Instance.new("Part")

function t.FireExtinguisherSpray(p1) --[[ FireExtinguisherSpray | Line: 61 | Upvalues: Part (copy), v1 (copy), Lib (copy) ]]
	Part.Shape = 0
	Part.formFactor = 0
	Part.Size = Vector3.new(1, 1, 1)
	Part.Transparency = 0.2
	Part.BottomSurface = "Smooth"
	Part.TopSurface = "Smooth"
	Part.CanCollide = true
	Part.Color = Color3.new(255/255, 255/255, 255/255)
	Part.CollisionGroup = "NPCs"

	local HumanoidRootPart = p1.Parent:FindFirstChild("HumanoidRootPart")
	local Sound = p1.Handle:FindFirstChildOfClass("Sound")

	if Sound then
		Sound:Play()
	end

	while p1 and (p1:HasTag("SprayingBubbles") and (p1.Parent and (HumanoidRootPart and (p1:IsDescendantOf(workspace) and p1.Enabled)))) do
		local unit = HumanoidRootPart.CFrame.lookVector.unit
		local v12 = Part:clone()
		local lookVector = HumanoidRootPart.CFrame.lookVector
		local v2 = math.abs(lookVector.x)
		local v3 = v2 + math.abs(lookVector.z)

		v12.Position = Vector3.new(p1.Handle.Position.x + 5 * (lookVector.x / v3), p1.Handle.Position.y, p1.Handle.Position.z + 5 * (lookVector.z / v3))

		local v8 = unit.x + v1:NextNumber(-0.2, 0.2)
		local v9 = unit.y + v1:NextNumber(-0.5, 2)
		local v10 = unit.z + v1:NextNumber(-0.2, 0.2)

		v12.Velocity = Vector3.new(v8, v9, v10) * v1:NextNumber(30, 50)
		v12.Size = Vector3.new(v1:NextNumber(1, 2), v1:NextNumber(1, 2), v1:NextNumber(1, 2))
		v12.Color = Color3.new(v1:NextNumber(0.95, 1), v1:NextNumber(0.95, 1), v1:NextNumber(0.95, 1))
		v12.Parent = game.Workspace

		if game.Players.LocalPlayer.Character and p1:IsDescendantOf(game.Players.LocalPlayer.Character) then
			v12.Touched:Connect(function(p1) --[[ Line: 91 | Upvalues: v12 (copy), Lib (ref) ]]
				if p1:HasTag("OnFire") then
					v12:Destroy()
					Lib.PoofLocation(v12.Position, "Sizzle")
					Lib.Network:FireServer("ExtinguisherBubbleHit", p1)

					return
				end

				if p1.Parent and (p1.Parent:HasTag("NPC") and p1.Parent:HasTag("OnFire")) then
					v12:Destroy()
					Lib.PoofLocation(v12.Position, "Sizzle")
					Lib.Network:FireServer("ExtinguisherBubbleHitFireNPC", p1.Parent)

					return
				end

				if p1.Parent and (p1.Parent:HasTag("NPC") and p1.Parent:GetAttribute("WaterEntity")) then
					v12:Destroy()
					Lib.PoofLocation(v12.Position, "Sizzle")
					Lib.Network:FireServer("ExtinguisherBubbleHit" .. p1.Parent.Name, p1.Parent)

					return
				end

				if not (p1.Parent and p1.Parent:HasTag("Grime")) then
					return
				end

				v12:Destroy()
				Lib.PoofLocation(v12.Position, "Sizzle")
				Lib.Network:FireServer("ExtinguisherBubbleHitGrime", p1.Parent)
			end)
		end

		game:GetService("Debris"):AddItem(v12, 2)
		wait(0.05)
	end

	if Sound then
		pcall(function() --[[ Line: 125 | Upvalues: Sound (copy) ]]
			Sound:Stop()
		end)
	end
end

local function OutGhost(p1) --[[ OutGhost | Line: 128 | Upvalues: LocalPlayer (copy), TweenService (copy) ]]
	local v1 = game.ReplicatedStorage.Misc.GhostSoul:Clone()

	task.spawn(function() --[[ Line: 130 | Upvalues: LocalPlayer (ref), v1 (copy), p1 (copy), TweenService (ref) ]]
		if LocalPlayer.Character.PrimaryPart then
			v1:SetPrimaryPartCFrame(CFrame.new(p1, p1 - LocalPlayer.Character.PrimaryPart.CFrame.LookVector))
			v1.Parent = workspace.Misc
			TweenService:Create(v1.PrimaryPart, TweenInfo.new(1.6), {
				Transparency = 1,
				Size = v1.PrimaryPart.Size * 0.9,
				Position = v1.PrimaryPart.Position + Vector3.new(0, 4, 0)
			}):Play()
			v1.PrimaryPart.Ghost:Play()
			task.wait(1.6)
			v1:Destroy()
		end
	end)
end

Lib.CS:GetInstanceAddedSignal("SprayingBubbles"):Connect(function(p1) --[[ Line: 143 | Upvalues: t (copy) ]]
	t.FireExtinguisherSpray(p1)
end)
function t.ThrowProyectile(p1, p2, p3, p4) --[[ ThrowProyectile | Line: 147 | Upvalues: Lib (copy) ]]
	Lib.Math.PlayBezier2Points(p1, p2, p3, p4)
end
t.PoofPlayer = PoofPlayer
t.PoofLocation = PoofLocation
t.PoofPosition = PoofLocation
t.OutGhost = OutGhost
Lib.Network:BindEvents({
	PoofPlayers = function(p1, p2) --[[ PoofPlayers | Line: 158 | Upvalues: CollectionService (copy) ]]
		for i, v in ipairs(CollectionService:GetTagged(p1 .. "Student")) do
			if not p2 or p2[v] then
				PoofPlayer(v)
			end
		end
	end,
	PoofLocation = PoofLocation,
	TweenPart = t.TweenPart,
	TweenModelParts = t.TweenModelParts,
	ThrowProyectile = t.ThrowProyectile,
	OutGhost = OutGhost,
	PlayShootEffect = function(p1, p2, p3, p4) --[[ PlayShootEffect | Line: 172 | Upvalues: LocalPlayer (copy), Lib (copy) ]]
		if p1 == LocalPlayer then
			return
		end

		local Tool = p1.Character:FindFirstChildOfClass("Tool")

		if not (Tool and Tool:FindFirstChild("Dispenser")) then
			return
		end

		Lib.LocalBeam.ShootEffect(p3.CFrame.p, p4)
		p2.Handle.GunSound:Play()
	end,
	PlayAreaEffectFor = function(p1) --[[ PlayAreaEffectFor | Line: 181 ]]
		local v1 = game.ReplicatedStorage.Misc.PowerUpArea:Clone()

		v1.Position = p1.PrimaryPart.Position - Vector3.new(0, 1, 0)
		v1.Parent = workspace
		v1.Attachment.Hit:Emit(1)
		v1.sound:Play()
		task.wait(2.5)
		v1:Destroy()
	end,
	ShootEffect = Lib.LocalBeam.ShootEffect
})

return t