--!strict
-- PetFollower: client-side pet following in arc formations with walk bobbing.
-- Pattern module written for this library. Ideas taken from:
--   rcu-roller (PetPosition: up to 3 arcs behind the player, small pets front, huge pets back)
--   pet-rng    (PetEquip: pets bob faster while the player walks, slower when idle)
-- Server decides WHICH pets are equipped; each client draws every player's pets locally,
-- so there is no physics ownership fight and no server cost per frame.
--
-- Usage (LocalScript):
--   local PetFollower = require(ReplicatedStorage.PetFollower)
--   local follower = PetFollower.new(player)               -- any player, including others
--   follower:SetPets({
--       { Id = "a1", Model = PetModels.Dog:Clone(),    Size = "Small" },
--       { Id = "b2", Model = PetModels.Dragon:Clone(), Size = "Huge" },
--   })
--   -- later: follower:SetPets({}) to clear, follower:Destroy() when the player leaves
--
-- Pet models need a PrimaryPart. They are anchored and moved with PivotTo every frame.

local RunService = game:GetService("RunService")

export type PetSpec = { Id: string, Model: Model, Size: ("Small" | "Big" | "Huge")? }

local ROW_LIMITS = { 3, 5, math.huge } -- pets per arc (row 1, row 2, row 3)
local ROW_SPACING = 4                    -- studs between arcs
local MAX_ARC = math.rad(60)             -- widest spread of one arc
local STEP_ARC = math.rad(30)            -- spread added per extra pet
local FOLLOW_SPEED = 10                  -- higher = snappier
local BOB_IDLE, BOB_WALK = 1.5, 8        -- bob speed (radians per second)
local BOB_HEIGHT = 0.6

local PetFollower = {}
PetFollower.__index = PetFollower

-- Pure layout function: returns { [index] = CFrame offset relative to the root part }.
function PetFollower.Layout(pets: { PetSpec }): { CFrame }
	local front, middle, back = {}, {}, {}
	for i, p in ipairs(pets) do
		local list = if p.Size == "Huge" then back elseif p.Size == "Big" then middle else front
		table.insert(list, i)
	end
	local rows = { {}, {}, {} }
	local function fill(rowIndex: number, source: { number })
		while #source > 0 and #rows[rowIndex] < ROW_LIMITS[rowIndex] do
			table.insert(rows[rowIndex], table.remove(source, 1))
		end
	end
	fill(1, front)
	fill(2, middle); fill(2, front)
	fill(3, back); fill(3, middle); fill(3, front)

	local offsets = {}
	for rowIndex, row in ipairs(rows) do
		local n = #row
		if n > 0 then
			local radius = rowIndex * ROW_SPACING
			local spread = math.min(MAX_ARC, STEP_ARC * (n - 1))
			local step = if n > 1 then spread / (n - 1) else 0
			for k, petIndex in ipairs(row) do
				local angle = (k - 1) * step - spread / 2
				-- +Z is behind the character in its own CFrame space
				offsets[petIndex] = CFrame.new(radius * 2 * math.sin(angle), 0, radius * math.cos(angle))
			end
		end
	end
	return offsets
end

function PetFollower.new(owner: Player)
	local self = setmetatable({}, PetFollower)
	self.Owner = owner
	self.Pets = {} :: { PetSpec }
	self.Offsets = {} :: { CFrame }
	self.Folder = Instance.new("Folder")
	self.Folder.Name = owner.Name .. "_Pets"
	self.Folder.Parent = workspace
	self.Clock = 0
	self.Connection = RunService.RenderStepped:Connect(function(dt)
		self:_step(dt)
	end)
	return self
end

function PetFollower:SetPets(pets: { PetSpec })
	for _, old in ipairs(self.Pets) do
		old.Model:Destroy()
	end
	self.Pets = pets
	self.Offsets = PetFollower.Layout(pets)
	local root = self:_root()
	for _, p in ipairs(pets) do
		for _, d in ipairs(p.Model:GetDescendants()) do
			if d:IsA("BasePart") then
				d.Anchored = true
				d.CanCollide = false
				d.CanQuery = false
				d.CanTouch = false
			end
		end
		if root then
			p.Model:PivotTo(root.CFrame)
		end
		p.Model.Parent = self.Folder
	end
end

function PetFollower:_root(): BasePart?
	local character = self.Owner.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	return if root and root:IsA("BasePart") then root else nil
end

function PetFollower:_step(dt: number)
	local root = self:_root()
	if not root then
		return
	end
	local humanoid = root.Parent and root.Parent:FindFirstChildOfClass("Humanoid")
	local moving = humanoid ~= nil and humanoid.MoveDirection.Magnitude > 0.05
	self.Clock += dt * (if moving then BOB_WALK else BOB_IDLE)
	local alpha = 1 - math.exp(-FOLLOW_SPEED * dt) -- frame-rate independent lerp
	-- flat facing (ignore pitch/roll of the root)
	local look = root.CFrame.LookVector
	local flat = CFrame.lookAt(root.Position, root.Position + Vector3.new(look.X, 0, look.Z))
	for i, p in ipairs(self.Pets) do
		local offset = self.Offsets[i] or CFrame.new(0, 0, ROW_SPACING)
		local bob = math.abs(math.sin(self.Clock + i)) * BOB_HEIGHT
		local target = flat * offset * CFrame.new(0, bob - 1.5, 0)
		local current = p.Model:GetPivot()
		p.Model:PivotTo(current:Lerp(target, alpha))
	end
end

function PetFollower:Destroy()
	self.Connection:Disconnect()
	self.Folder:Destroy()
	self.Pets = {}
end

return PetFollower
