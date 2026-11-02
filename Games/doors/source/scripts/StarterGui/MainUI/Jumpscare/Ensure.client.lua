local p2 = require(script.Parent.Parent.Initiator.Main_Game)
local l__TweenService__3 = game:GetService("TweenService");

local Jumpscared = false

function NewJumpscare(run_id)
	game.SoundService.Main.Volume = 0
	
	local screen = script.Parent.Jumpscare_HasteSome
	p2.stopcam = true
	screen.Visible = true
	screen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	screen.ImageLabel.Size = UDim2.new(0.0001, 0, 0.0001, 0)
	wait(math.random(1, 2))
	screen.BackgroundColor3 = Color3.fromRGB(5, 0, 0)
	screen.ImageLabel.Visible = true
	screen.Static:Play()
	screen.ImageLabel.Size = UDim2.new(0.05, 0, 0.05, 0)
	spawn(function()
		while true do
			wait(0.1)
			local v64 = tick();
			local v66 = math.clamp(v64 + 1.5 - tick(), 0, 1.5);
			script.Parent.Jumpscare_HasteSome.ImageLabel.Rotation = math.random(-v66 * 6, v66 * 6);
		end
	end)
	wait(math.random(1, 2))
	screen.Static:Play()
	screen.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
	screen.Static.Volume = 0.03
	screen.ImageLabel.Size = UDim2.new(0.15, 0, 0.15, 0)
	spawn(function()
		while true do
			wait(0.1)
			local v64 = tick();
			local v66 = math.clamp(v64 + 1.5 - tick(), 0, 1.5);
			script.Parent.Jumpscare_HasteSome.ImageLabel.Rotation = math.random(-v66 * 6, v66 * 6);
		end
	end)
	wait(math.random(2, 3))
	screen.Static:Play()
	screen.BackgroundColor3 = Color3.fromRGB(25, 0, 0)
	screen.Static.Volume = 0.05
	screen.ImageLabel.Size = UDim2.new(0.25, 0, 0.25, 0)
	spawn(function()
		while true do
			wait(0.1)
			local v64 = tick();
			local v66 = math.clamp(v64 + 1.5 - tick(), 0, 1.5);
			script.Parent.Jumpscare_HasteSome.ImageLabel.Rotation = math.random(-v66 * 6, v66 * 6);
		end
	end)
	wait(math.random(2, 3))
	screen.Static:Play()
	screen.BackgroundColor3 = Color3.fromRGB(35, 0, 0)
	screen.Static.Volume = 0.08
	screen.ImageLabel.Size = UDim2.new(0.35, 0, 0.35, 0)
	spawn(function()
		while true do
			wait(0.1)
			local v64 = tick();
			local v66 = math.clamp(v64 + 1.5 - tick(), 0, 1.5);
			script.Parent.Jumpscare_HasteSome.ImageLabel.Rotation = math.random(-v66 * 6, v66 * 6);
		end
	end)
	wait(math.random(4, 6))
	screen.HasteScreen.Visible = true
	screen.StaticBad:Play()
	screen.BackgroundColor3 = Color3.fromRGB(90, 0, 0)
	screen.ImageLabel.Size = UDim2.new(0.89, 0, 0.89, 0)
	spawn(function()
		while true do
			wait(0.1)
			local v64 = tick();
			local v66 = math.clamp(v64 + 1.5 - tick(), 0, 1.5);
			script.Parent.Jumpscare_HasteSome.ImageLabel.Rotation = math.random(-v66 * 6, v66 * 6);
			script.Parent.Jumpscare_HasteSome.HasteScreen.Rotation = math.random(-v66 * 6, v66 * 6);
		end
	end)
	local HasteScreen = l__TweenService__3:Create(screen.HasteScreen, TweenInfo.new(1.6, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
		Position = UDim2.new(0, 0.5, 0, 0)
	})
	HasteScreen:Play()
	wait(1)
	
	game.SoundService.Main.Volume = 1
	game.Players.LocalPlayer.Stats.Death.Value = "Haste"
	game.ReplicatedStorage.Bricks.HasteInClient:FireServer()
	p2.stopcam = false
	game.Lighting.FogStart = 43
	game.Lighting.Ambient = Color3.fromRGB(27, 20, 11)
	screen.Kill:Play()
	screen.StaticBad:Stop()
	if run_id ~= "Admin Panel" then
	screen.Visible = false
	game.Players.LocalPlayer.Character.Humanoid:TakeDamage(100)
	end
end

function Jumpscare(v)
	if Jumpscared == false then
		Jumpscared = true
		game.ReplicatedStorage.FloorClientStuff.ClientRemote.Haste.Ambience.TimePosition = 0.1
		game.ReplicatedStorage.FloorClientStuff.ClientRemote.Haste.Ambience:Stop()
		game.Lighting:FindFirstChild("HasteCorrection"):Destroy()
		game.Lighting:FindFirstChild("LightCorrection"):Destroy()
		p2.stopcam = true
		local l__TweenService__3 = game:GetService("TweenService");
		script.Parent.Jumpscare_Haste.Visible = true
		script.Parent.Jumpscare_Haste.Static:Play()
		if game.Lighting:FindFirstChild("MainColorCorrection") then
			game.Lighting:FindFirstChild("MainColorCorrection"):Destroy()
		end
		local corection = script.Parent.Jumpscare_Haste.MainColorCorrection:Clone()
		corection.Parent = game.Lighting
		game.Lighting.Ambient = Color3.fromRGB(255, 0, 0)
		local HasteScreen = l__TweenService__3:Create(script.Parent.Jumpscare_Haste.HasteScreen, TweenInfo.new(1.8, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
			Position = UDim2.new(0, 0.5, 0, 0)
		})
		HasteScreen:Play()
		HasteScreen.Completed:Wait()
		
		game.ReplicatedStorage.GameData.TimerOver.Value = true
		game.Players.LocalPlayer.Stats.Death.Value = "Haste"
		game.ReplicatedStorage.Bricks.HasteInClient:FireServer()
		p2.stopcam = false
		game.Lighting.FogStart = 43
		game.Lighting.Ambient = Color3.fromRGB(27, 20, 11)
		script.Parent.Jumpscare_Haste.Kill:Play()
		script.Parent.Jumpscare_Haste.Static:Stop()
		corection:Destroy()
		game.Players.LocalPlayer.Character.Humanoid:TakeDamage(100)
	else
		return
	end
end

function tweenToMovingPart(movePart, targetPart, duration)
	local startCFrame = movePart.CFrame
	local startTime = os.clock()
	local connection = nil
	connection = game:GetService('RunService').Heartbeat:Connect(function()
		local t = math.clamp((os.clock()-startTime)/duration, 0 ,1)
		if movePart and movePart.Parent and targetPart and targetPart.Parent then
			movePart.CFrame = startCFrame:Lerp(targetPart.CFrame, t)
		end
		
		if t == 1 then
			movePart.Parent:Destroy()
			connection:Disconnect()
			connection = nil
		end
	end)
end

function Play()
	local Vignette = script.Parent.HasteVignette
	Vignette.Visible = true
	Vignette.Size = UDim2.new(1.6, 0, 1.6, 0)
	Vignette.ImageTransparency = 1
	for i, v in pairs(Vignette:GetChildren()) do
		if v:IsA("Frame") then
			v.BackgroundTransparency = 1
		end
		
		if v:IsA("ImageLabel") then
			v.ImageTransparency = 1
		end
	end
	wait(0.69)
	
	Vignette.HasteCorrection:Clone().Parent = game.Lighting
	Vignette.LightCorrection:Clone().Parent = game.Lighting
	game.Lighting.Ambient = Color3.fromRGB(255, 0, 0)
	local Entity = game.ReplicatedStorage.FloorClientStuff.ClientRemote.Haste.EntityModel:Clone()
	
	Entity.Main.Footsteps:Play()
	Entity:PivotTo(game.Players.LocalPlayer.Character.PrimaryPart.CFrame * CFrame.new(math.random(300, 1000), 5, math.random(300, 1000)))
	Entity.Parent = game.Workspace.CurrentCamera
	
	tweenToMovingPart(Entity.PrimaryPart, game.Players.LocalPlayer.Character.PrimaryPart, 14)
	
	task.delay(13.5, function()
		NewJumpscare()
	end)
	
	game.ReplicatedStorage.FloorClientStuff.ClientRemote.Haste.Ambience.TimePosition = 0.1
	game.ReplicatedStorage.FloorClientStuff.ClientRemote.Haste.Ambience:Play()
	Vignette:TweenSize(UDim2.new(1.1, 0, 1.1, 0), "In", "Quad", 0.2, true);
	Vignette.ImageTransparency = 0
	for i, v in pairs(Vignette:GetChildren()) do
		if v:IsA("Frame") then
			v.BackgroundTransparency = 0
		end

		if v:IsA("ImageLabel") then
			v.ImageTransparency = 0
		end
	end
	
	while true do
		if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then
			Vignette.Visible = false
			game.Lighting.Ambient = Color3.fromRGB(27, 20, 11)
			game.ReplicatedStorage.FloorClientStuff.ClientRemote.Haste.Ambience:Stop()
			if game.Lighting:FindFirstChild("HasteCorrection") then
				game.Lighting:FindFirstChild("HasteCorrection"):Destroy()
				game.Lighting:FindFirstChild("LightCorrection"):Destroy()
			end
			break
		else
			wait(0.09)
			p2.camShaker:ShakeOnce(2, 16, 0.1, 0.1, Vector3.new(0, 0, 0), Vector3.new(3, 1, 3));
			Vignette.Swirl.Rotation = math.random(1, 360)
			Vignette.Rotation = math.random(1, 360)
		end
	end
end

game.Workspace.Game:GetAttributeChangedSignal("GameTimer"):Connect(function()
	if game.Workspace.Game:GetAttribute("GameTimer") == 0 then
		wait()
		Play()
	end
end)

game.ReplicatedStorage.EntityInfo:WaitForChild("HasteJumpscare").OnClientEvent:Connect(function(run_id)
	NewJumpscare(run_id)
end)