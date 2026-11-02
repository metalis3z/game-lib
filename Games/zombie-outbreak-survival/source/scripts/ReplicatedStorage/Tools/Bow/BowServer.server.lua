-- BowServer: Modern, robust, concise, kills only Humanoids named "Zombie" like Classic Sword

local Tool = script.Parent
local Arrow = Tool:FindFirstChild("Arrow")
local BowRE = Tool:FindFirstChild("BowRE")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local cooldown = false

local function TagHumanoid(humanoid, player)
	local tag = Instance.new("ObjectValue")
	tag.Name = "creator"
	tag.Value = player
	Debris:AddItem(tag, 2)
	tag.Parent = humanoid
end

local function UntagHumanoid(humanoid)
	for _, v in humanoid:GetChildren() do
		if v:IsA("ObjectValue") and v.Name == "creator" then
			v:Destroy()
		end
	end
end

BowRE.OnServerEvent:Connect(function(plr, instruction, charge, mHit)
	if Tool.Parent ~= plr.Character then return end

	if instruction == "shoot" and not cooldown then
		cooldown = true

		local newArrow = Arrow:Clone()
		newArrow.Parent = workspace
		Arrow.Transparency = 1

		newArrow.CFrame = CFrame.new(newArrow.Position, mHit.Position)
		newArrow.Velocity = mHit.LookVector * charge * 200

		Debris:AddItem(newArrow, 30)

		local touched = false
		newArrow.Touched:Connect(function(hit)
			if touched then return end
			if hit:IsDescendantOf(plr.Character) then return end
			touched = true
			newArrow:Destroy()

			local humanoid = hit.Parent:FindFirstChildOfClass("Humanoid")
			if humanoid and humanoid.Name == "Zombie" and humanoid.Health > 0 then
				local player = Players:GetPlayerFromCharacter(hit.Parent)
				if not player or (player ~= plr and not (plr.TeamColor == player.TeamColor and not plr.Neutral and not player.Neutral)) then
					UntagHumanoid(humanoid)
					TagHumanoid(humanoid, plr)
					humanoid:TakeDamage(100)
				end
			end
		end)

		BowRE:FireClient(plr, newArrow, charge)

		task.wait(1)
		Arrow.Transparency = 0
		cooldown = false

	elseif instruction == "string" then
		Tool.Bow.Middle.Position = charge
		Tool.Bow.Weld.C1 = mHit
	end
end)