local Tool = script.Parent
local Fireflies = 7
local Debris = game:GetService("Debris")
local Check = true
local Equipped = false
local Handle = Tool:WaitForChild("Handle")
local Lid = Tool:WaitForChild("Lid")
local Weld = Tool:WaitForChild("Weld")
local Animation = Tool:WaitForChild("Animation")
local FireflyScript = script:WaitForChild("FireflyScript")
local FirefliesEvent = Tool:WaitForChild("FirefliesEvent")
local SetCursorEvent = Tool:WaitForChild("SetCursorEvent")
local PointLight = Handle:WaitForChild("PointLight")

local function CreateFirefly()
	local Part = Instance.new("Part")
	Part.Name = "Firefly"
	Part.Size = Vector3.new(.1, .1, .1)
	Part.CFrame = Handle.CFrame * CFrame.new(math.random() - .5, 1 + math.random(), math.random() - .5)
	Part.Transparency = 1
	Part.CanCollide = true
	Part.Material = Enum.Material.SmoothPlastic
	local SelectionBox = Instance.new("SelectionBox", Part)
	SelectionBox.Color3 = Color3.fromRGB(255, 255, 0)
	SelectionBox.Adornee = Part
	local BodyVelocity = Instance.new("BodyVelocity", Part)
	BodyVelocity.MaxForce = Vector3.new(1,1,1) * 10 ^ 2
	BodyVelocity.Velocity = Vector3.new(math.random() - .5, 1, math.random() - .5) * 4
	local BodyAngularVelocity = Instance.new("BodyAngularVelocity", Part)
	BodyAngularVelocity.MaxTorque = Vector3.new(1,1,1) * 10 ^ 2
	BodyAngularVelocity.AngularVelocity = Vector3.new(math.random() - .5, math.random() - .5, math.random() - .5) * 20
	local NewPointLight = Instance.new("PointLight", Part)
	NewPointLight.Color = PointLight.Color
	NewPointLight.Range = math.random(4, 8)
	NewPointLight.Brightness = 1
	local NewFireflyScript = FireflyScript:Clone()
	NewFireflyScript.Disabled = false
	NewFireflyScript.Parent = Part
	Debris:AddItem(Part, math.random(20, 30))
	Part.Parent = workspace
	return Part
end

local function OnServerEvent(Player)
	local Character = Player.Character
	local Humanoid = Character:WaitForChild("Humanoid")
	local AnimationTrack = Humanoid:LoadAnimation(Animation)
	if Check then
		SetCursorEvent:FireClient(Player, "rbxasset://textures\\GunWaitCursor.png")
		Check = false
		AnimationTrack:Play()
		wait(1)
		wait(1.7)
		Lid.Transparency = 1
		local FakeLid = Lid:Clone()
		FakeLid.Transparency = 0
		FakeLid.CanCollide = true
		Debris:AddItem(FakeLid, 5)
		FakeLid.Parent = workspace
		FakeLid.AssemblyLinearVelocity = FakeLid.AssemblyLinearVelocity + Vector3.new(math.random() - .5, 3, math.random() - .5) * 10
		wait(1)
		for Count = 1, Fireflies do
			CreateFirefly()
			PointLight.Brightness = 4 * 1 - Count / Fireflies
			wait(math.random())
		end
		wait(5)
		SetCursorEvent:FireClient(Player, "rbxasset://textures\\GunCursor.png")
		PointLight.Brightness = 4
		Lid.Transparency = 0
		Check = true
	end
end

FirefliesEvent.OnServerEvent:Connect(OnServerEvent)