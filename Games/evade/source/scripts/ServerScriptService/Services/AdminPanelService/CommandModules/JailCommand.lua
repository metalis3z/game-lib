local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local JailCommand = {}
JailCommand.__index = JailCommand

function JailCommand.new()
	local self = setmetatable({}, JailCommand)
	return self
end

function JailCommand:Execute(executor: Player, targetPlayer: Player)
	if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		warn("[JailCommand] Target player has no character or HumanoidRootPart")
		return
	end

	local character = targetPlayer.Character
	local root = character.HumanoidRootPart

	local jail = Instance.new("Model")
	jail.Name = "JailCell_" .. targetPlayer.Name
	jail.Parent = workspace

	local jailSize = Vector3.new(8, 8, 8)
	local jailPosition = root.Position + Vector3.new(0, jailSize.Y/2, 0)

	-- Floor
	local floor = Instance.new("Part")
	floor.Name = "Floor"
	floor.Size = Vector3.new(jailSize.X, 0.5, jailSize.Z)
	floor.Position = jailPosition - Vector3.new(0, jailSize.Y/2, 0)
	floor.Anchored = true
	floor.Material = Enum.Material.Concrete
	floor.Color = Color3.new(0.5, 0.5, 0.5)
	floor.Parent = jail

	-- Function to create transparent glass wall
	local function createGlassWall(size, position)
		local wall = Instance.new("Part")
		wall.Size = size
		wall.Position = position
		wall.Anchored = true
		wall.Transparency = 0.5
		wall.Color = Color3.fromRGB(180, 220, 255)
		wall.CanCollide = true
		wall.Parent = jail
	end

	-- Walls
	createGlassWall(Vector3.new(jailSize.X, jailSize.Y, 0.5), jailPosition + Vector3.new(0, 0, jailSize.Z/2))
	createGlassWall(Vector3.new(jailSize.X, jailSize.Y, 0.5), jailPosition + Vector3.new(0, 0, -jailSize.Z/2))
	createGlassWall(Vector3.new(0.5, jailSize.Y, jailSize.Z), jailPosition + Vector3.new(jailSize.X/2, 0, 0))
	createGlassWall(Vector3.new(0.5, jailSize.Y, jailSize.Z), jailPosition + Vector3.new(-jailSize.X/2, 0, 0))

	-- Glass ceiling
	createGlassWall(Vector3.new(jailSize.X, 0.5, jailSize.Z), jailPosition + Vector3.new(0, jailSize.Y/2, 0))

	-- Move player inside
	root.CFrame = CFrame.new(jailPosition)

	local originalPosition = root.CFrame

	print("[JailCommand] Player", targetPlayer.Name, "has been jailed for 10 seconds")

	task.delay(10, function()
		if jail and jail.Parent then
			jail:Destroy()
		end

		if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
			targetPlayer.Character.HumanoidRootPart.CFrame = originalPosition + Vector3.new(0, 5, 0)
		end
	end)
end

return JailCommand.new()
