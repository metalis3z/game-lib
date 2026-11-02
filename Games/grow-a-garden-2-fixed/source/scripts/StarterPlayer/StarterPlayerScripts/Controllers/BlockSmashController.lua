--credit to leon games studio
local t = {
	StartOrder = 7
}
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Temporary = workspace:WaitForChild("Temporary")
local Stud_Part = ReplicatedStorage.Assets:WaitForChild("Stud_Part")

local function randomInRange(p1, p2) --[[ randomInRange | Line: 29 ]]
	return p1 + math.random() * (p2 - p1)
end

local function randomUnitVector() --[[ randomUnitVector | Line: 33 ]]
	local v1 = math.random() * math.pi * 2
	local v3 = math.acos(2 * math.random() - 1)

	return Vector3.new(math.sin(v3) * math.cos(v1), math.sin(v3) * math.sin(v1), (math.cos(v3)))
end

function t.Smash(p1, p2) --[[ Smash | Line: 58 | Upvalues: Stud_Part (copy), Temporary (copy), randomUnitVector (copy), TweenService (copy), Debris (copy) ]]
	local Position = p2.Position

	if not Position then
		return
	end

	local v2 = p2.Spread or 3
	local v3 = p2.Color or Color3.fromRGB(139, 90, 43)
	local Colors = p2.Colors
	local v4 = p2.Lifetime or 1.2
	local v5 = p2.Force or 1

	for i = 1, p2.Amount or 12 do
		local v6
		local v7 = if Colors and #Colors > 0 then Colors[math.random(1, #Colors)] else v3
		local v8 = -v2
		local v10 = -v2
		local v12 = -v2
		local v14 = Position + Vector3.new((v8 + math.random() * (v2 - v8)) * 0.5, (v10 + math.random() * (v2 - v10)) * 0.3, (v12 + math.random() * (v2 - v12)) * 0.5)
		local Size = p2.Size
		local SmashBlock = Stud_Part:Clone()

		SmashBlock.CollisionGroup = "Egg"
		SmashBlock.Size = Vector3.new(Size, Size, Size)
		SmashBlock.Name = "SmashBlock"
		SmashBlock.Color = v7
		SmashBlock.CFrame = CFrame.new(v14) * CFrame.Angles(math.random() * math.pi * 2, math.random() * math.pi * 2, math.random() * math.pi * 2)
		SmashBlock.Anchored = false
		SmashBlock.CanCollide = true
		SmashBlock.CollisionGroup = "NoPlayers"
		SmashBlock.CanQuery = false
		SmashBlock.CanTouch = false
		SmashBlock.Parent = Temporary

		local v15 = v14 - Position

		v6 = if v15.Magnitude < 0.1 then randomUnitVector() else v15.Unit

		local Unit = (v6 + randomUnitVector() * 0.4).Unit
		local v17 = (15 + math.random() * 25) * v5

		SmashBlock.AssemblyLinearVelocity = Unit * v17 + Vector3.new(0, (15 + math.random() * 15) * v5, 0)
		SmashBlock.AssemblyAngularVelocity = randomUnitVector() * 25

		local Size2 = SmashBlock.Size

		task.delay(0.4, function() --[[ Line: 126 | Upvalues: SmashBlock (copy), v4 (copy), TweenService (ref), Size2 (copy) ]]
			if not (SmashBlock and SmashBlock.Parent) then
				return
			end

			local v1 = v4 - 0.4

			if v1 <= 0 then
				SmashBlock:Destroy()
			else
				local v2 = TweenService:Create(SmashBlock, TweenInfo.new(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					Transparency = 1,
					Size = Size2 * 0.3
				})

				v2:Play()
				v2.Completed:Once(function() --[[ Line: 141 | Upvalues: SmashBlock (ref) ]]
					if not (SmashBlock and SmashBlock.Parent) then
						return
					end

					SmashBlock:Destroy()
				end)
			end
		end)
		Debris:AddItem(SmashBlock, v4 + 1)
	end
end
function t.Init(p1) --[[ Init | Line: 157 ]] end
function t.Start(p1) --[[ Start | Line: 160 ]] end

return t