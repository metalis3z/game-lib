repeat wait(); until _G.PlayerData ~= nil;
wait(0.2);

local PetsDB = game.ReplicatedStorage.GetSyncData:InvokeServer("Pets");
local u4 = require(script.DecalChroma);
local u5 = require(script.FireChroma);

local RbxUtility = require(game:GetService("ReplicatedStorage"):
    WaitForChild("LoadLibrary"):WaitForChild("RbxUtility"))

-- call RbxUtility.Create as usual
local Create = RbxUtility.Create
local Weld = require(script.Weld);

local Pets = game.ReplicatedStorage.Pets;
game:GetService("RunService"):BindToRenderStep("Pets",1000,function()
	for _,Character in pairs(game.Workspace:GetChildren()) do
		local Pet = Character:FindFirstChild("Pet");
		if Pet and Pet:IsA("StringValue") then
			local PetID = Pet.Value;
			if Pets:FindFirstChild(PetID) then
				local PetPart = Pet:FindFirstChild("Body");
				if not PetPart then
					local NewPart = Pets[PetID]:Clone();
					NewPart.Name = "Body";
					PetPart = NewPart;
					Weld(PetPart);
					local torsoAt = Character.HumanoidRootPart.Position 
					local toGhost = PetPart.Position - torsoAt toGhost = Vector3.new(toGhost.x, 0, toGhost.z).unit
					local ghostAt = torsoAt + toGhost*3 + Vector3.new(0, 2 + 1*math.sin(tick()), 0)
					PetPart.CFrame = Character.HumanoidRootPart.CFrame;
					Create"BodyPosition"{
						Name = 'Float';
						Parent = PetPart;
						position = Character.HumanoidRootPart.Position + Vector3.new(1,1,1);
						--D = 500;
					};
					Create'BodyGyro'{
						Name = 'Rotate';
						Parent = PetPart;
						cframe = Character.HumanoidRootPart.CFrame;
						maxTorque = Vector3.new(40000, 20000, 40000);
					};
					PetPart.Anchored = false;
					PetPart.CanCollide = false;	
					NewPart.Parent = Pet;
					local NameTag = game.ReplicatedStorage.NameTag:Clone();
					NameTag.Tag.Text = (Pet.PetName.Value~="" and not game:GetService("UserInputService").GamepadEnabled and Pet.PetName.Value) or PetsDB[PetID].Name;
					NameTag.StudsOffset = Vector3.new(0, (PetPart.Size.Y/2)+0.5,0);
					NameTag.Parent = PetPart;
					if Character ~= game.Players.LocalPlayer.Character then
						for v14, v15 in pairs(NewPart:GetDescendants()) do
							if v15.Name == "DecalChroma" then
								spawn(function()
									u4(v15.Parent);
								end);
							elseif v15.Name == "FireChroma" then
								spawn(function()
									u5(v15.Parent);
								end);
							end;
						end;
					end;
				else
					local torsoAt = Character.HumanoidRootPart.Position
					local toGhost = PetPart.Position - torsoAt
					toGhost = Vector3.new(toGhost.x, 0, toGhost.z).unit
					local ghostAt = torsoAt + toGhost*3 + Vector3.new(0, 2 + 1*math.sin(tick()), 0)
					--
					if Pet:FindFirstChild("Walking") then
						local Under = CFrame.new(ghostAt):toWorldSpace(CFrame.new(Vector3.new(0,-1,0)));
						local Raycast = Ray.new(ghostAt, (Under.p-ghostAt).unit*100);
						local StandOn = game.Workspace:FindPartOnRay(Raycast,Character);
						if StandOn then
							ghostAt = Vector3.new(ghostAt.X,StandOn.Position.Y+(StandOn.Size.Y/2)+(PetPart.Size.Y/2),ghostAt.Z);
						end;
					end;
					--
					PetPart.Float.position = ghostAt
					PetPart.Rotate.cframe = Character.HumanoidRootPart.CFrame
					
					if game.Players:GetPlayerFromCharacter(Character):DistanceFromCharacter(PetPart.Position) >= 50 then
						PetPart.CFrame = Character.HumanoidRootPart.CFrame;
					end
					
					
					
					if Character == game.Players.LocalPlayer.Character and _G.IsFirstPerson==true then
						if PetPart.Transparency ~= 1 then PetPart.Transparency = 0.9; end;
						PetPart.NameTag.Enabled = false;
						
						local function ScanEffects(ScanPart)
							for _,Obj in pairs(ScanPart:GetChildren()) do 
								local Effect = pcall(function() return Obj["Enabled"] end)
								if Effect and not Obj.Name == "NameTag" then Obj.Enabled = false end;
								--if Obj:IsA("BasePart") and Obj.Transparency ~= 1 then Obj.Transparency = 0.9; end;
								ScanEffects(Obj);
							end;
						end
						ScanEffects(PetPart);
						

					else
						--if PetPart.Transparency ~= 1 then PetPart.Transparency = Character.HumanoidRootPart.Transparency; end;
						PetPart.NameTag.Enabled = true--(PetPart.Transparency < 1);
						
						local function ScanEffects(ScanPart)
							for _,Obj in pairs(ScanPart:GetChildren()) do 
								local Effect = pcall(function() return Obj["Enabled"] end)
								if Effect and not Obj.Name == "NameTag" then Obj.Enabled = (PetPart.Transparency < 1) end;
								--if Obj:IsA("BasePart") and Obj.Transparency ~= 1 then Obj.Transparency = Character.HumanoidRootPart.Transparency; end;
								ScanEffects(Obj);
							end;
						end
						ScanEffects(PetPart);				
								
					end;
					
				end;	
			end
		end
	end	
end);