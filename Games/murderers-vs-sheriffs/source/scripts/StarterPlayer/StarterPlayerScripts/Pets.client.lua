-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

task.wait(0.2);
local l_Pets_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync")).Pets;
local v1 = require(script.Weld);
local _ = game.Workspace:FindFirstChild("TreeBases") ~= nil;
local v3 = {};
local l_Pets_1 = game.ReplicatedStorage.Pets;
game:GetService("RunService").PreSimulation:connect(function()
	for _, v6 in game.Workspace:GetChildren() do
		local l_Pet_0 = v6:FindFirstChild("Pet");
		if l_Pet_0 and l_Pet_0:IsA("StringValue") and v6:FindFirstChild("HumanoidRootPart") then
			local l_Value_0 = l_Pet_0.Value;
			if l_Pets_1:FindFirstChild(l_Value_0) then
				local l_Body_0 = l_Pet_0:FindFirstChild("Body");
				if not l_Body_0 then
					local v10 = l_Pets_1[l_Value_0]:Clone();
					v10.Name = "Body";
					l_Body_0 = v10;
					v1(l_Body_0);
					local l_Position_0 = v6.HumanoidRootPart.Position;
					local v12 = l_Body_0.Position - l_Position_0;
					local _ = l_Position_0 + Vector3.new(v12.x, 0, v12.z).unit * 3 + Vector3.new(0, 2 + 1 * math.sin((tick())), 0);
					l_Body_0.CFrame = v6.HumanoidRootPart.CFrame;
					local l_BodyPosition_0 = Instance.new("BodyPosition");
					l_BodyPosition_0.Name = "Float";
					l_BodyPosition_0.Parent = l_Body_0;
					l_BodyPosition_0.position = v6.HumanoidRootPart.Position + Vector3.new(1, 1, 1, 0);
					local l_BodyGyro_0 = Instance.new("BodyGyro");
					l_BodyGyro_0.Name = "Rotate";
					l_BodyGyro_0.Parent = l_Body_0;
					l_BodyGyro_0.cframe = v6.HumanoidRootPart.CFrame;
					l_BodyGyro_0.maxTorque = Vector3.new(40000, 20000, 40000, 0);
					l_Body_0.Anchored = false;
					l_Body_0.CanCollide = false;
					v10.Parent = l_Pet_0;
					local v16 = script.PetTag:Clone();
					v16.Name = "NameTag";
					v16.Enabled = true;
					local v17 = l_Pet_0:GetAttribute("PetName") ~= "" and l_Pet_0:GetAttribute("PetName") or l_Pets_0[l_Value_0].Name;
					if game:GetService("GuiService"):IsTenFootInterface() then
						v17 = l_Pets_0[l_Value_0].Name;
					end;
					v16.Tag.Text = v17;
					v16.StudsOffset = Vector3.new(0, l_Body_0.Size.Y / 2 + 0.5, 0);
					v16.Enabled = true;
					v16.Parent = l_Body_0;
				else
					local l_Position_1 = v6.HumanoidRootPart.Position;
					local v19 = l_Body_0.Position - l_Position_1;
					local v20 = l_Position_1 + Vector3.new(v19.x, 0, v19.z).unit * 3 + Vector3.new(0, 2 + 1 * math.sin((tick())), 0);
					if l_Pet_0:GetAttribute("Walking") then
						local v21 = CFrame.new(v20):toWorldSpace(CFrame.new((Vector3.new(0, -1, 0, 0))));
						local v22 = Ray.new(v20, (v21.p - v20).unit * 100);
						local l_PartOnRayWithIgnoreList_0, v24 = game.Workspace:FindPartOnRayWithIgnoreList(v22, {
							v6, 
							unpack(v3)
						});
						if l_PartOnRayWithIgnoreList_0 and (l_PartOnRayWithIgnoreList_0.Transparency >= 1 or l_PartOnRayWithIgnoreList_0.CanCollide == false) then
							table.insert(v3, l_PartOnRayWithIgnoreList_0);
						end;
						if v24 then
							v20 = Vector3.new(v20.X, v24.Y + l_Body_0.Size.Y / 2 + 0.2, v20.Z);
						end;
					end;
					l_Body_0.Float.position = v20;
					l_Body_0.Rotate.cframe = v6.HumanoidRootPart.CFrame;
					if game.Players:GetPlayerFromCharacter(v6):DistanceFromCharacter(l_Body_0.Position) >= 50 then
						l_Body_0.CFrame = v6.HumanoidRootPart.CFrame;
					end;
					if v6 == game.Players.LocalPlayer.Character and _G.IsFirstPerson == true then
						if l_Body_0.Transparency ~= 1 then
							l_Body_0.Transparency = 0.8;
						end;
						l_Body_0.NameTag.Enabled = false;
						local function v25(v26)
							for _, v28 in pairs(v26:GetChildren()) do
								if not v28.Name == "NameTag" and (v28:IsA("ParticleEmitter") or v28:IsA("Fire") or v28:IsA("Trail") or v28:IsA("Beam")) then
									v28.Enabled = false;
								end;
								if v28:IsA("BasePart") and v28.Transparency ~= 1 then
									v28.Transparency = 0.9;
								end;
								v25(v28);
							end;
						end;
						v25(l_Body_0);
					elseif v6:FindFirstChild("UpperTorso") then
						if l_Body_0.Transparency ~= 1 then
							l_Body_0.Transparency = v6.UpperTorso.Transparency;
						end;
						local v29 = v6.UpperTorso.Transparency < 0.5;
						if l_Body_0:FindFirstChild("NameTag") then
							l_Body_0.NameTag.Enabled = v29;
						end;
						local function v30(v31)
							for _, v33 in pairs(v31:GetChildren()) do
								if v33:IsA("ParticleEmitter") or v33:IsA("Fire") or v33:IsA("Trail") or v33:IsA("Beam") then
									v33.Enabled = v29;
								end;
								if v33:IsA("Decal") then
									v33.Transparency = v6.UpperTorso.Transparency;
								end;
								if v33:IsA("BasePart") and v33.Transparency ~= 1 then
									v33.Transparency = v6.UpperTorso.Transparency;
								end;
								v30(v33);
							end;
						end;
						v30(l_Body_0);
					end;
				end;
			end;
		end;
	end;
end);