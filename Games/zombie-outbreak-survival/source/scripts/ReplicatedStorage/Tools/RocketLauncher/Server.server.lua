-- RocketLauncher Server Script: Modern, concise, robust, only damages Humanoids named "Zombie"

local Tool = script.Parent
local Handle = Tool:WaitForChild("Handle")
local MouseLoc = Tool:WaitForChild("MouseLoc", 10)
local RocketScript = script:WaitForChild("Rocket")
local SwooshSound = script:WaitForChild("Swoosh")
local BoomSound = script:WaitForChild("Boom")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local GRAVITY = workspace.Gravity
local RELOAD_TIME = 3
local ROCKET_SPEED = 60
local ROCKET_SIZE = Vector3.new(1.2, 1.2, 3.27)
local ROCKET_MESH_ID = "http://www.roblox.com/asset/?id=2251534"
local ROCKET_MESH_SCALE = Vector3.new(0.35, 0.35, 0.25)

local MyPlayer = nil

local function createRocket(player)
	local rocket = Instance.new("Part")
	rocket.Name = "Rocket"
	rocket.Size = ROCKET_SIZE
	rocket.CanCollide = false
	rocket.Anchored = false
	rocket.FormFactor = Enum.FormFactor.Custom

	local mesh = Instance.new("SpecialMesh")
	mesh.MeshId = ROCKET_MESH_ID
	mesh.Scale = ROCKET_MESH_SCALE
	mesh.Parent = rocket

	local fire = Instance.new("Fire")
	fire.Heat = 5
	fire.Size = 2
	fire.Parent = rocket

	local bodyForce = Instance.new("BodyForce")
	bodyForce.Name = "Antigravity"
	bodyForce.Force = Vector3.new(0, rocket:GetMass() * GRAVITY, 0)
	bodyForce.Parent = rocket

	local swooshClone = SwooshSound:Clone()
	swooshClone.Parent = rocket
	local boomClone = BoomSound:Clone()
	boomClone.PlayOnRemove = true
	boomClone.Parent = rocket

	local creatorTag = Instance.new("ObjectValue")
	creatorTag.Name = "creator"
	creatorTag.Value = player
	creatorTag.Parent = rocket

	local iconTag = Instance.new("StringValue")
	iconTag.Name = "icon"
	iconTag.Value = Tool.TextureId
	iconTag.Parent = creatorTag

	local rocketScriptClone = RocketScript:Clone()
	rocketScriptClone.Parent = rocket
	rocketScriptClone.Disabled = false

	return rocket
end

local function onActivated()
	if not Tool.Enabled then return end
	local character = MyPlayer and MyPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not character or not humanoid or humanoid.Health <= 0 then return end
	Tool.Enabled = false

	local mousePos = MouseLoc:InvokeClient(MyPlayer)
	if not mousePos then
		Tool.Enabled = true
		return
	end

	local rocket = createRocket(MyPlayer)
	Debris:AddItem(rocket, 30)
	rocket.BrickColor = MyPlayer.TeamColor

	local spawnPos = (Handle.CFrame * CFrame.new(5, 0, 0)).p
	rocket.CFrame = CFrame.new(spawnPos, mousePos)
	rocket.Velocity = rocket.CFrame.LookVector * ROCKET_SPEED
	rocket.Parent = workspace
	rocket:SetNetworkOwner(nil)

	task.wait(RELOAD_TIME)
	Tool.Enabled = true
end

local function onEquipped()
	MyPlayer = Players:GetPlayerFromCharacter(Tool.Parent)
end

Tool.Equipped:Connect(onEquipped)
Tool.Activated:Connect(onActivated)