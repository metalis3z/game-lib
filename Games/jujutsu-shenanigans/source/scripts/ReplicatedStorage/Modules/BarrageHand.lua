local module = {}

if not game.Workspace:FindFirstChild("Debris") then
    local folder = Instance.new("Folder",workspace)
    folder.Name = "Debris"
end

function lerp(a, b, c)
    return a + (b - a) * c
end

function Curve(t, p0, p1, p2)
    local l1 = lerp(p0, p1, t)
    local l2 = lerp(p1, p2, t)
    local quad = lerp(l1, l2, t)
    return quad
end

function module.Run(prams,character)
	local chr = prams.Character
	local VFXHandler = require(game.ReplicatedStorage.Assets.Modules.VFXHandler)
	local Model = script["Barrage Arms"]:Clone()
	Model.Shirt.ShirtTemplate = chr:FindFirstChild("Shirt").ShirtTemplate
	Model["Right Arm"].Color = chr["Right Arm"].Color
	Model["Left Arm"].Color = chr["Left Arm"].Color
	Model.Parent = workspace.Map.Debris
    local LeftArm = Model["Left Arm"]
    local Way = script.Way:Clone()
    local Weld = script.LeftHand["HumanoidRootPart 🡪 P0"]:Clone()

	LeftArm.Anchored = true
	
	local Sound = Model["Right Arm"].Swing:Clone()
	Sound.Parent = chr.Head
	Sound:Play()
	game.Debris:AddItem(Sound,Sound.TimeLength)

    Way.Parent = workspace.Debris
    Weld.Parent = chr
    Weld.Part0 = chr.HumanoidRootPart
    Weld.Part1 = Way.P0
    LeftArm.Transparency = 0
    LeftArm.Material = Enum.Material.SmoothPlastic

	Weld.C0 = Weld.C0 * CFrame.new(math.random(0,200)/100,math.random(-200,50)/100,math.random(0,10)/100)

    local t = 0
    local step = 0.1

    task.spawn(function()
        while t <= 1 do
            local p = Curve(t, Way.P0.Position, Way.P1.Position, Way.P2.Position)
            local pNext = Curve(t + 0.1 * step, Way.P0.Position, Way.P1.Position, Way.P2.Position)
            local direction = (pNext - p).Unit
            local newCFrame = CFrame.new(p, pNext) * CFrame.new(0, 0, 0)

            newCFrame = newCFrame * CFrame.Angles(math.rad(90), 0, 0)

            LeftArm.CFrame = newCFrame

            t = t + step
            task.wait(0.001)
        end
		game.TweenService:Create(LeftArm,TweenInfo.new(.2),{Transparency = 1}):Play()
        Weld:Destroy()
        Way:Destroy()
        task.spawn(function()
            task.wait(.5)
            LeftArm:Destroy()
        end)
	end)
	
	local RightArm = Model["Right Arm"]
	local Way = script.Way:Clone()
	local Weld = script["HumanoidRootPart 🡪 P0"]:Clone()

	RightArm.Anchored = true

	Way.Parent = workspace.Debris
	Weld.Parent = chr
	Weld.Part0 = chr.HumanoidRootPart
	Weld.Part1 = Way.P0
	RightArm.Transparency = 0
	RightArm.Material = Enum.Material.SmoothPlastic

	Weld.C0 = Weld.C0 * CFrame.new(math.random(0,200)/100,math.random(-200,50)/100,math.random(0,10)/100)

	local t = 0
	local step = 0.1

	task.spawn(function()
		while t <= 1 do
			local p = Curve(t, Way.P0.Position, Way.P1.Position, Way.P2.Position)
			local pNext = Curve(t + 0.1 * step, Way.P0.Position, Way.P1.Position, Way.P2.Position)
			local direction = (pNext - p).Unit
			local newCFrame = CFrame.new(p, pNext) * CFrame.new(0, 0, 0)

			newCFrame = newCFrame * CFrame.Angles(math.rad(90), 0, 0)

			RightArm.CFrame = newCFrame

			t = t + step
			task.wait(0.001)
		end
		game.TweenService:Create(RightArm,TweenInfo.new(.2),{Transparency = 1}):Play()
		Weld:Destroy()
		Way:Destroy()
		task.spawn(function()
			task.wait(.5)
			RightArm:Destroy()
			task.wait(.2)
			Model:Destroy()
		end)
	end)
end

return module
