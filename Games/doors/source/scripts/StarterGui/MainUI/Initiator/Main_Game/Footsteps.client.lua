local v1 = script:FindFirstAncestor("MainUI");
local v2 = require(script.Parent);
local v3 = require(game.Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls();
local v4 = game["Run Service"];
local l__UserInputService__5 = game:GetService("UserInputService");
local l__TweenService__6 = game:GetService("TweenService");
({}).Walk = {};
local v7 = game:GetService("ReplicatedStorage"):WaitForChild("FootstepsClient", 0.5);
local l__HumanoidRootPart__1 = v2.char:WaitForChild("HumanoidRootPart");
local u2 = tick();
local l__Humanoid__3 = v2.char:WaitForChild("Humanoid");
game["Run Service"].RenderStepped:connect(function(p1)
	local v8 = Vector3.new(l__HumanoidRootPart__1.Velocity.X, 0, l__HumanoidRootPart__1.Velocity.Z);
	if l__HumanoidRootPart__1.Anchored == true then
		v8 = Vector3.new(0, 0, 0);
	end;
	if u2 + 6 / l__Humanoid__3.WalkSpeed < tick() and v8.Magnitude > 5 and l__Humanoid__3.FloorMaterial ~= Enum.Material.Air and v2.stopcam ~= true then
		u2 = tick();
		local v9 = (v7:FindFirstChild(l__Humanoid__3.FloorMaterial) or v7:FindFirstChild("Fabric")):GetChildren();
		local v10 = v9[math.random(1, #v9)]
		v10 = v10:Clone()
		local volume = v10.Volume
		if v2.crouching == true then
			volume = volume / 2
		end;
		v10.Volume = volume
		--game:GetService("ReplicatedStorage").EntityInfo.Footstep:FireServer(v10:Clone());
		v10.Parent = v2.char
		v10:Play()
		game.Debris:AddItem(v10, v10.TimeLength * v10.Pitch + 2)
		 
		--v2.playaudio(v10);
		v2.spring:Impulse(Vector3.new(math.random(-10, 10), -35, math.random(-10, 10)).unit * l__HumanoidRootPart__1.Velocity.Magnitude * 0.5);
		local data = {
			sound = v10;
			crouch = v2.crouching,
			camera = workspace.CurrentCamera.CFrame,
			
		}
		game:GetService("ReplicatedStorage").ClientBricks.FootStep:FireServer(data, "code-096b13")
	end;
end);


game.ReplicatedStorage.EntityInfo.FootstepCreated.OnClientEvent:Connect(function(sound)
	local max_distance = 20;
	if sound then
		
		if sound.Parent:IsA("Model") then
			if sound.Parent.Name ~= game.Players.LocalPlayer.Name then
				local pos1 = workspace.CurrentCamera.CFrame.Position
				local pos2 = sound.Parent:GetPivot().Position
				local mag = (pos1 - pos2).Magnitude
				if mag > max_distance then
					sound:Destroy()
					print("Sound deleted!")
				end
			end
		end
	end
end)