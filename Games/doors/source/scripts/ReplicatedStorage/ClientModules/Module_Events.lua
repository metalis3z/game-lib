-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local l__LocalPlayer__2 = game.Players.LocalPlayer;
local u1 = nil;
function v1.init(p1)
	u1 = p1;
end;
local l__TweenService__2 = game:GetService("TweenService");

function v1.flickerLights(p2, p3)
	local u3 = p2;
	spawn(function()
		if typeof(u3) ~= "Instance" then
			if typeof(u3) == "number" then
				u3 = workspace.CurrentRooms:FindFirstChild(u3);
			else
				u3 = nil;
			end;
		end;
		if u3 == nil then
			warn("Cannot find room");
		end;
		local v3 = {};
		if u3 ~= nil then
		for v4, v5 in pairs(u3:GetDescendants()) do
			if v5:IsA("Model") and (v5.Name == "LightStand" or v5.Name == "Lightbulb" or v5.Name == "Chandelier") then
				table.insert(v3, v5);
			end;
		end;
		for v6, v7 in pairs(v3) do
			for v8, v9 in pairs(v7:GetDescendants()) do
				if v9:IsA("Light") then
					v9:SetAttribute("B", v9.Brightness);
				end;
			end;
			end;
		end
		l__TweenService__2:Create(game.Lighting, TweenInfo.new(p3 / 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, true), {
			Ambient = Color3.new(0, 0, 0)
		}):Play();
		local v10 = tick();
		for v11, v12 in pairs(v3) do
			task.spawn(function()
				for v13 = 1, 10000000 do
					task.wait(math.random(24, 70) / 100);
					if v10 + p3 <= tick() then
						break;
					end;
					local v14 = v12.PrimaryPart:FindFirstChild("BulbZap", true);
					if not v14 then
						v14 = game:GetService("ReplicatedStorage").Sounds.BulbZap:Clone();
						v14.Parent = v12.PrimaryPart;
					end;
					if v14 then
						v14.TimePosition = math.random(0, 13) / 20;
						v14.Pitch = v14.Pitch + math.random(-100, 100) / 5000;
						v14:Play();
					end;
					for v15, v16 in pairs(v12:GetDescendants()) do
						if v16:IsA("Light") then
							v16.Brightness = v16:GetAttribute("B");
							l__TweenService__2:Create(v16, TweenInfo.new(0.06, Enum.EasingStyle.Back, Enum.EasingDirection.InOut, 2, true, 0), {
								Brightness = 0
							}):Play();
						end;
					end;
					local l__Neon__17 = v12:FindFirstChild("Neon", true);
					if l__Neon__17 and l__Neon__17.Name == "Neon" then
						l__TweenService__2:Create(l__Neon__17, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 2, true, 0), {
							Transparency = 1
						}):Play();
					end;
				end;
			end);
		end;
		task.wait(p3 + 0.1);
		for v18, v19 in pairs(v3) do
			local v20, v21, v22 = pairs(v19:GetDescendants());
			while wait(0.5) do
				local v23, v24 = v20(v21, v22);
				if not v23 then
					break;
				end;
				if v24:IsA("Light") then
					l__TweenService__2:Create(v24, TweenInfo.new(0.06, Enum.EasingStyle.Back, Enum.EasingDirection.InOut, 2), {
						Brightness = v24:GetAttribute("B")
					}):Play();
				end;
				if v24.Name == "Neon" then
					l__TweenService__2:Create(v24, TweenInfo.new(0.06, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 2), {
						Transparency = 0
					}):Play();
				end;			
			end;
		end;
	end);
end;
function v1.tryp(p4, p5)
	spawn(function()
		for v25, v26 in pairs(p4:GetDescendants()) do
			if v26:IsA("BasePart") then
				spawn(function()
					local l__Material__27 = v26.Material;
					v26.Color = Color3.new(0.2, 0, 0);
					l__TweenService__2:Create(v26, TweenInfo.new(p5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
						Color = v26.Color
					}):Play();
				end);
			end;
		end;
	end);
	spawn(function()
		for v28, v29 in pairs(p4:GetDescendants()) do
			if v29:IsA("BasePart") and (v29.Name == "Wall" or v29.Name == "Wall_Strip" or v29.Name == "WallAlt" or v29.Name == "Floor" or v29.Name == "Carpet" or v29.Name == "Ceiling") then
				local v30 = { Enum.NormalId.Front, Enum.NormalId.Back, Enum.NormalId.Right, Enum.NormalId.Left, Enum.NormalId.Top, Enum.NormalId.Bottom };
				if v29.Name == "Wall" or v29.Name == "Wall_Strip" or v29.Name == "WallAlt" then
					v30 = { Enum.NormalId.Front, Enum.NormalId.Back, Enum.NormalId.Right, Enum.NormalId.Left };
				end;
				if v29.Name == "Floor" or v29.Name == "Carpet" then
					v30 = { Enum.NormalId.Top };
				end;
				if v29.Name == "Ceiling" then
					v30 = { Enum.NormalId.Bottom };
				end;
				for v31, v32 in pairs(v30) do
					local v33 = game:GetService("ReplicatedStorage").Misc.TryTexture:Clone();
					v33.Face = v32;
					v33.Parent = v29;
					l__TweenService__2:Create(v33, TweenInfo.new(p5 + math.random(0, 100) / 500, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
						OffsetStudsU = 10, 
						OffsetStudsV = 10, 
						Transparency = 1
					}):Play();
					game.Debris:AddItem(v33, p5 + 1);
				end;
			end;
		end;
	end);
end;
function v1.turnOffLights(p6, p7)
	local u4 = p6;
	local u5 = p7;
	spawn(function()
		for v34, v35 in pairs(u4:GetDescendants()) do
			if v35:IsA("Light") and v35:GetAttribute("ToTurnOn") == true then
				v35.Enabled = true;
			end;
		end;
		wait(0.2);
		u5 = 0.4;
		if typeof(u4) ~= "Instance" then
			if typeof(u4) == "number" then
				u4 = workspace.Rooms:FindFirstChild(u4);
			else
				u4 = nil;
			end;
		end;
		if u4 == nil then
			warn("Cannot find room");
		end;
		local v36 = {};
		for v37, v38 in pairs(u4:GetDescendants()) do
			if v38:IsA("Model") and (v38.Name == "LightStand" or v38.Name == "Chandelier") then
				table.insert(v36, v38);
			end;
		end;
		for v39, v40 in pairs(v36) do
			for v41, v42 in pairs(v40:GetDescendants()) do
				if v42:IsA("Light") then
					v42:SetAttribute("B", v42.Brightness);
				end;
			end;
		end;
		--print("Hello everybody; my name is Markiplier, and here are the amount of light bulbs I own:", #v36);
		l__TweenService__2:Create(game.Lighting, TweenInfo.new(4, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
			Ambient = Color3.new(0, 0, 0)
		}):Play();
		local v43 = tick();
		for v44, v45 in pairs(v36) do
			task.spawn(function()
				for v46 = 1, 10000000 do
					task.wait(math.random(24, 70) / 100);
					if v43 + u5 <= tick() then
						break;
					end;
					local v47 = v45.PrimaryPart:FindFirstChild("BulbZap", true);
					if not v47 then
						v47 = game:GetService("ReplicatedStorage").Sounds.BulbZap:Clone();
						v47.Parent = v45.PrimaryPart;
					end;
					if v47 then
						v47.TimePosition = math.random(0, 13) / 20;
						v47.Pitch = v47.Pitch + math.random(-100, 100) / 5000;
						v47:Play();
					end;
					for v48, v49 in pairs(v45:GetDescendants()) do
						if v49:IsA("Light") then
							v49.Brightness = v49:GetAttribute("B");
							l__TweenService__2:Create(v49, TweenInfo.new(0.06, Enum.EasingStyle.Back, Enum.EasingDirection.InOut, 2, true, 0), {
								Brightness = 0
							}):Play();
						end;
					end;
					local l__Neon__50 = v45:FindFirstChild("Neon", true);
					if l__Neon__50 and l__Neon__50.Name == "Neon" then
						l__TweenService__2:Create(l__Neon__50, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 2, true, 0), {
							Transparency = 1
						}):Play();
					end;
				end;
			end);
		end;
		task.wait(u5 + 0.6);
		for v51, v52 in pairs(v36) do
			local v53, v54, v55 = pairs(v52:GetDescendants());
			while wait(0.5) do
				local v56, v57 = v53(v54, v55);
				if not v56 then
					break;
				end;
				if v57:IsA("Light") then
					v57.Brightness = 0.4;
					l__TweenService__2:Create(v57, TweenInfo.new(math.random(1, 10) / 10, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut, 1), {
						Brightness = 0
					}):Play();
				end;
				if v57.Name == "Neon" then
					v57.Material = Enum.Material.Glass;
				end;			
			end;
		end;
		local v58, v59, v60 = pairs(u4:GetDescendants());
		while wait(0.5) do
			local v61, v62 = v58(v59, v60);
			if not v61 then
				break;
			end;
			if v62:IsA("Light") and v62:GetAttribute("ForceOn") ~= true then
				v62.Brightness = 0.4;
				l__TweenService__2:Create(v62, TweenInfo.new(math.random(1, 10) / 15, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut, math.random(0, 2)), {
					Brightness = 0
				}):Play();
			end;
			if v62:IsA("ParticleEmitter") and v62:GetAttribute("Light") == true then
				v62.Enabled = false;
			elseif v62:IsA("Sound") and v62:GetAttribute("Light") == true then
				v62.Volume = 0;
				v62:Stop();
			end;		
		end;
	end);
end;
local u6 = game:GetService("ReplicatedStorage").Shards:GetChildren();

function v1.breakLights(p8, p10)
	local u7 = p10;
	local room_start_id = "None"
	if p8:FindFirstChild("RoomEntrance") then
		room_start_id = "RoomEntrance"
	elseif p8:FindFirstChild("RoomStart") then
		room_start_id = "RoomStart"
	end
	if room_start_id == "None" then
		warn("Failed to get start version")
		return
	end
	spawn(function()
		wait(0.1);
		if not u7 then
			u7 = 60;
		end;
		local v63 = {};
		for v64, v65 in pairs(p8.Assets.Light_Fixtures:GetChildren()) do
			if v65:IsA("Model") and v65.Name == "LightStand" or v65.Name == "Lightbulb" or v65.Name == "Chandelier" and v65:WaitForChild("LightFixture", 0.5):WaitForChild("PointLight", 0.5).Enabled == true or v65:WaitForChild("Neon", 0.5):WaitForChild("PointLight", 0.5).Enabled == true then
				table.insert(v63, v65);
			end;
		end;
		for v66, v67 in pairs(v63) do
			delay((p8[room_start_id].Position - v67.PrimaryPart.Position).Magnitude / u7 + math.random(0, 10) / 100, function()
				local v68
				if not v67.PrimaryPart:FindFirstChild("BulbBreak") then
					v68 = game:GetService("ReplicatedStorage").Sounds.BulbBreak:Clone();
					v68.Parent = v67.PrimaryPart;
				elseif v67.PrimaryPart:FindFirstChild("BulbBreak") then
					v68 = v67.PrimaryPart.BulbBreak
				end;
				v68.Pitch = v68.Pitch + math.random(-140, 140) / 1000;
				v68.TimePosition = math.random(0, 7) * 3; -- math.random(0, 7) * 3
				v68:Play();
				game.Debris:AddItem(v68, 2);
				pcall(function()
					u1.shakerel(v67.PrimaryPart.Position, 6, 15, 0, 0.3, Vector3.new(0, 0, 0));
				end);
				for v69 = 1, 4 do
					local v70 = u6[math.random(1, #u6)]:Clone();
					v70.CFrame = v67.PrimaryPart.CFrame + Vector3.new(math.random(-3, 3) / 5, math.random(-3, 3) / 5, math.random(-3, 3) / 5);
					v70.Velocity = Vector3.new(math.random(-6, 6), math.random(-6, 6), math.random(-6, 6));
					v70.RotVelocity = Vector3.new(math.random(-3, 3) / 5, math.random(-3, 3) / 5, math.random(-3, 3) / 5);
					v70.Parent = game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1);
					--game.Debris:AddItem(v70, math.random(20, 35));
				end;
				for v71, v72 in pairs(v67:GetDescendants()) do
					if v72:IsA("Light") then
						l__TweenService__2:Create(v72, TweenInfo.new(0.06, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, math.random(0, 2), false, 0), {
							Brightness = 0
						}):Play();
						if room_start_id == "RoomEntrance" then
						v72 = v72.Parent
						end
						if v72.Parent:FindFirstChild("Neon") then
							v72.Parent:FindFirstChild("Neon").Material = Enum.Material.Glass;
							v72.Parent:FindFirstChild("Neon").Transparency = 1;
						end;
					end;
				end;
			end);
		end;
		local v73, v74, v75 = pairs(p8:GetDescendants());
		while wait(0.5) do
			local v76, v77 = v73(v74, v75);
			if not v76 then
				break;
			end;
			if v77:IsA("Light") and v77:GetAttribute("ForceOn") ~= true then
				if v77.Parent.Name == "LightBase" then
					v77.Brightness = 0.5;
				else
					v77.Enabled = false;
				end;
			end;
			if v77:IsA("ParticleEmitter") and v77:GetAttribute("Light") == true then
				v77.Enabled = false;
			elseif v77:IsA("Sound") and v77:GetAttribute("Light") == true then
				v77.Volume = 0;
				v77:Stop();
			end;		
		end;
	end);
end;

function v1.breakLights_Time(p8, p10)
	local u7 = p10;
	local room_start_id = "None"
	if p8:FindFirstChild("RoomEntrance") then
		room_start_id = "RoomEntrance"
	elseif p8:FindFirstChild("RoomStart") then
		room_start_id = "RoomStart"
	end
	if room_start_id == "None" then
		warn("Failed to get start version")
		return
	end
	spawn(function()
		wait(0.1);
		if not u7 then
			u7 = 60;
		end;
		local v63 = {};
		for v64, v65 in pairs(p8.Assets.Light_Fixtures:GetChildren()) do
			if v65:IsA("Model") and v65.Name == "LightStand" or v65.Name == "Lightbulb" or v65.Name == "Chandelier" and v65:WaitForChild("LightFixture", 0.5):WaitForChild("PointLight", 0.5).Enabled == true or v65:WaitForChild("Neon", 0.5):WaitForChild("PointLight", 0.5).Enabled == true then
				table.insert(v63, v65);
			end;
		end;
		
		local d = false
		
		for v66, v67 in pairs(v63) do
			if d == false then
				d = true
				delay((p8[room_start_id].Position - v67.PrimaryPart.Position).Magnitude / u7 + math.random(0, 10) / 100, function()
					local v68
					if not v67.PrimaryPart:FindFirstChild("BulbBreak") then
						v68 = game:GetService("ReplicatedStorage").Sounds.BulbBreak:Clone();
						v68.Parent = v67.PrimaryPart;
					elseif v67.PrimaryPart:FindFirstChild("BulbBreak") then
						v68 = v67.PrimaryPart.BulbBreak
					end;
					v68.Pitch = v68.Pitch + math.random(-140, 140) / 1000;
					v68.TimePosition = 0;
					v68:Play();
					game.Debris:AddItem(v68, 2);
					pcall(function()
						u1.shakerel(v67.PrimaryPart.Position, 6, 15, 0, 0.3, Vector3.new(0, 0, 0));
					end);
					for v69 = 1, 4 do
						local v70 = u6[math.random(1, #u6)]:Clone();
						v70.CFrame = v67.PrimaryPart.CFrame + Vector3.new(math.random(-3, 3) / 5, math.random(-3, 3) / 5, math.random(-3, 3) / 5);
						v70.Velocity = Vector3.new(math.random(-6, 6), math.random(-6, 6), math.random(-6, 6));
						v70.RotVelocity = Vector3.new(math.random(-3, 3) / 5, math.random(-3, 3) / 5, math.random(-3, 3) / 5);
						v70.Parent = game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1);
					end;
					for v71, v72 in pairs(v67:GetDescendants()) do
						if v72:IsA("Light") then
							l__TweenService__2:Create(v72, TweenInfo.new(0.06, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, math.random(0, 2), false, 0), {
								Brightness = 0
							}):Play();
							if room_start_id == "RoomEntrance" then
								v72 = v72.Parent
							end
							if v72.Parent:FindFirstChild("Neon") then
								v72.Parent:FindFirstChild("Neon").Material = Enum.Material.Glass;
								v72.Parent:FindFirstChild("Neon").Transparency = 1;
							end;
						end;
					end;
				end);
			end
		end;
		local v73, v74, v75 = pairs(p8:GetDescendants());
		while wait(0.5) do
			local v76, v77 = v73(v74, v75);
			if not v76 then
				break;
			end;
			if v77:IsA("Light") and v77:GetAttribute("ForceOn") ~= true then
				if v77.Parent.Name == "LightBase" then
					v77.Brightness = 0.5;
				else
					v77.Enabled = false;
				end;
			end;
			if v77:IsA("ParticleEmitter") and v77:GetAttribute("Light") == true then
				v77.Enabled = false;
			elseif v77:IsA("Sound") and v77:GetAttribute("Light") == true then
				v77.Volume = 0;
				v77:Stop();
			end;		
		end;
	end);
end;

local u9 = {
	Seek = { "I SEE YOU", "RUN", "RUN", "YOU CAN'T HIDE", "I'M COMING" }
};

return v1;

--[[	local eye = game.ReplicatedStorage.Misc.Eyes

local function rotateMod(mod,center,rotation)
	local parts ={}
	local function scan(parent)
		for _,obj in pairs(parent:GetChildren()) do
			if (obj:IsA("BasePart")) then
				table.insert(parts,obj)
			end
			scan(obj)
		end
	end
	scan(mod)
	for _,part in pairs(parts) do
		part.CFrame = (center*rotation*(center:inverse()*part.CFrame))
	end
end
for i = 1, times do
	wait(0.1)
	local random = eye:GetChildren()[math.random(1, #eye:GetChildren())]
	local step = math.random(5, 15)
	local random2 = math.random(1, 7)

	local stepX = math.random(1, 25)
	local stepZ = math.random(1, 3)
	local cloned = random:Clone()
	cloned.Part.Splat:Play()
	cloned.Parent = parentt
	if random2 == 1 then
		cloned:PivotTo(t.CFrame + Vector3.new(0, -stepZ, 0))
		rotateMod(cloned,cloned:GetModelCFrame(),CFrame.Angles(0,0,math.rad(step)))
	elseif random2 == 2 then
		cloned:PivotTo(t.CFrame + Vector3.new(0, stepZ, 0))
		rotateMod(cloned,cloned:GetModelCFrame(),CFrame.Angles(0,0,math.rad(-step)))
	elseif random2 == 3 then
		cloned:PivotTo(t.CFrame + Vector3.new(0, stepZ, 0))
		rotateMod(cloned,cloned:GetModelCFrame(),CFrame.Angles(0,0,math.rad(step)))
	elseif random2 == 4 then
		cloned:PivotTo(t.CFrame + Vector3.new(0, -stepZ, 0))
		rotateMod(cloned,cloned:GetModelCFrame(),CFrame.Angles(0,0,math.rad(-step)))
	elseif random2 == 5 then
		cloned:PivotTo(t.CFrame + Vector3.new(0, stepZ, 0))
		rotateMod(cloned,cloned:GetModelCFrame(),CFrame.Angles(0,0,math.rad(step)))
	elseif random2 == 6 then
		cloned:PivotTo(t.CFrame + Vector3.new(0, stepZ, 0))
		rotateMod(cloned,cloned:GetModelCFrame(),CFrame.Angles(0,0,math.rad(step)))
	elseif random2 == 7 then
		cloned:PivotTo(t.CFrame + Vector3.new(0, -stepZ, 0))
		rotateMod(cloned,cloned:GetModelCFrame(),CFrame.Angles(0,0,math.rad(-step)))
	end
end-]]
