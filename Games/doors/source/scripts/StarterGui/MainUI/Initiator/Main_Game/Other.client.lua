-- Decompiled with the Synapse X Luau decompiler.

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local u1 = require(game:GetService("ReplicatedStorage"):WaitForChild("Achievements"));
local u2 = script:FindFirstAncestor("MainUI");
local l__TweenService__3 = game:GetService("TweenService");

game.ReplicatedStorage.EntityInfo.CrucifixHaltJumpscare.OnClientEvent:Connect(function()
	local l__Jumpscare_Shade__8 = u2.Jumpscare.Jumpscare_ShadeCrucifix
	local l__Jumpscare_Shade__2 = u2.Jumpscare.Jumpscare_Shade
	l__Jumpscare_Shade__8.Visible = true
	l__Jumpscare_Shade__2.Visible = false
	local u8 = true;
	script.SoundHurtCrucifix:Play();
	u8 = math.random(0, 1000) / 1000;
	l__Jumpscare_Shade__8.Overlay.Position = UDim2.new(u8, 0, math.random(0, 1000) / 1000, 0);
	u8 = 1;
	local v20
	for u8 = u8, 15 do
		task.wait(0.05);
		l__Jumpscare_Shade__8.Overlay.Visible = true;
		l__Jumpscare_Shade__8.Static.Position = UDim2.new(math.random(0, 1000) / 1000, 0, math.random(0, 1000) / 1000, 0);
		l__Jumpscare_Shade__8.Static.Rotation = 180 * math.random(0, 1);
		if math.random(1, 2) == 2 then
			v20 = "rbxassetid://8681113503";
		else
			v20 = "rbxassetid://8681113666";
		end;
		l__Jumpscare_Shade__8.Static.Image = v20;
		l__Jumpscare_Shade__8.Static.ImageTransparency = math.random(1, 5) / 10;
		l__Jumpscare_Shade__8.Eyes.Visible = true;
		if math.random(1, 2) == 2 then
			l__Jumpscare_Shade__8.Eyes.Position = UDim2.new(math.random(450, 550) / 1000, 0, math.random(450, 550) / 1000, 0);
		end;
	end;
	l__Jumpscare_Shade__8.Eyes.Visible = false;
	l__Jumpscare_Shade__8.Overlay.Visible = false;
	l__Jumpscare_Shade__8.Visible = false
	l__Jumpscare_Shade__2.Visible = true
end)

game.ReplicatedStorage.EntityInfo.AchievementUnlock.OnClientEvent:Connect(function(p2)
	local v2 = u1[p2]:GetInfo();
	if v2 then
		local v3 = u2.AchievementsHolder.Achievement:Clone();
		v3.Size = UDim2.new(0, 0, 0, 0);
		v3.Frame.Position = UDim2.new(1.1, 0, 0, 0);
		v3.Name = "LiveAchievement";
		v3.Visible = true;
		for v4, v5 in pairs(v2) do
			local v6 = v3.Frame.Details:FindFirstChild(v4);
			if v6 then
				v6.Text = v5;
			end;
		end;
		--if v2.Image then
		--	v3.Frame.ImageLabel.Image = v2.Image;
		if v2.BadgeId then
			v3.Frame.ImageLabel.Image = "rbxassetid://" .. game.BadgeService:GetBadgeInfoAsync(v2.BadgeId).IconImageId;
		end;
		v3.Parent = u2.AchievementsHolder;
		v3.Sound:Play();
		v3:TweenSize(UDim2.new(1, 0, 0.2, 0), "In", "Quad", 0.8, true);
		wait(0.8);
		v3.Frame:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.5, true);
		l__TweenService__3:Create(v3.Frame.Glow, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			ImageTransparency = 1
		}):Play();
		wait(8);
		v3.Frame:TweenPosition(UDim2.new(1.1, 0, 0, 0), "In", "Quad", 0.5, true);
		wait(0.5);
		v3:TweenSize(UDim2.new(1, 0, -0.1, 0), "InOut", "Quad", 0.5, true);
		wait(0.5);
		v3:Destroy();
	end;
end)


local v2 = require(script.Parent)
local v3 = script.Parent
local v3f = game.Players.LocalPlayer
local v1 = script.Parent.Parent.Parent
local vperm = script.Parent.Parent.Parent.Parent.PermUI
local tp = game:GetService("TeleportService")
local l__RealGameId__3 = "13659999395";
local l__TweenService__1 = game:GetService("TweenService");
local l__Hotbar__7 = v1.MainFrame.Hotbar;

function BoostVialStart(v)
	local cc = script.CC:Clone()
	local cc2 = script.PointLight:Clone()
	
	if v == true then
		cc.Parent = game.Lighting

		u2.MainFrame.Healthbar.Bar.Visible = true
		u2.MainFrame.Healthbar.Effects.SpeedBoost.Visible = true
		u2.MainFrame.Healthbar.Effects.StarlightSmall.Visible = true
		cc2.Parent = v3f.Character.HumanoidRootPart
	else
		game.Lighting:FindFirstChild("CC"):Destroy()
		v3f.Character.HumanoidRootPart:FindFirstChild("PointLight"):Destroy()
		u2.MainFrame.Healthbar.Bar.Visible = false
		u2.MainFrame.Healthbar.Effects.SpeedBoost.Visible = false
		u2.MainFrame.Healthbar.Effects.StarlightSmall.Visible = false
	end
	
end

v3f.Character:GetAttributeChangedSignal("StarvialUsed"):Connect(function()
	if v3f.Character:GetAttribute("StarvialUsed") == true then
		BoostVialStart(true)
	else
		BoostVialStart(false)
	end
end)

game.ReplicatedStorage.EntityInfo.CinematicDoor.OnClientEvent:Connect(function()
	local v3 = require(script.Parent.RemoteListener.Cutscenes.CinematicDoor)
	v3(v2)
end)

game.ReplicatedStorage.EntityInfo.EnterSecret.OnClientEvent:Connect(function()
	if game.Workspace.CurrentRooms.CurrentRoom.Value > 2 then
		pcall(function()
			v2.spectate(true, true);
			v2.char.HumanoidRootPart.Anchored = false
			task.delay(0.7, function()
				v2.char.HumanoidRootPart:PivotTo(v2.char.HumanoidRootPart.CFrame * CFrame.new(0, 1500, 0))
			end)
		end);
	end
end)

game.ReplicatedStorage.EntityInfo.Unhideplayers.OnClientEvent:Connect(function()
	v2.hideplayers = 0
end)

game.ReplicatedStorage.EntityInfo.CloseShop.OnClientEvent:Connect(function()
	v1.ItemShop.Visible = false
	v2.freemouse = false
end)

game.ReplicatedStorage.EntityInfo.FigureCutsceneFall.OnClientEvent:Connect(function()
	local v3 = require(script.Parent.RemoteListener.Cutscenes.FigureFall)
	v3(v2)
end)

game.ReplicatedStorage.EntityInfo.FigureCutsceneWalk.OnClientEvent:Connect(function()
	local v3 = require(script.Parent.RemoteListener.Cutscenes.FigureWalkIn)
	v3(v2)
end)

game.ReplicatedStorage.EntityInfo.FigureCutscene.OnClientEvent:Connect(function()
	local v3 = require(script.Parent.RemoteListener.Cutscenes.Figure)
	v3(v2)
end)

game.ReplicatedStorage.EntityInfo.FigureCutsceneNew.OnClientEvent:Connect(function()
	local v3 = require(script.Parent.RemoteListener.Cutscenes.FigureNew)
	v3(v2)
end)

game.ReplicatedStorage.EntityInfo.DupeCrucifixCutscene.OnClientEvent:Connect(function()
	local v3 = require(script.Parent.RemoteListener.Cutscenes.DupeCrucifixIntro)
	v3(v2)
end)

game.ReplicatedStorage.EntityInfo.DupeCutscene.OnClientEvent:Connect(function()
	local v3 = require(script.Parent.RemoteListener.Cutscenes.DupeIntro)
	v3(v2)
end)

game.ReplicatedStorage.EntityInfo.TriggerElevator1.OnClientEvent:Connect(function()
	local v3 = require(script.Parent.RemoteListener.Cutscenes.Elevator1Old)
	v3(v2)
end)

game.ReplicatedStorage.EntityInfo.TriggerSeek.OnClientEvent:Connect(function()
	local v3 = require(script.Parent.RemoteListener.Cutscenes.SeekIntro)
	v3(v2)
end)

game.ReplicatedStorage.EntityInfo.ToggleInv.OnClientEvent:Connect(function(d1)
	v2.ce.ToggleInventory:Fire(d1)
end)

v2.ce.ToggleInventory.Event:Connect(function(p16)
	if p16 == true then
		l__Hotbar__7:TweenPosition(UDim2.new(0.5, 0, 1, -10), "InOut", "Quad", 1, true);
		return;
	end;
	l__Hotbar__7:TweenPosition(UDim2.new(0.5, 0, 2, 0), "InOut", "Quad", 1, true);
	v3f.Character.Humanoid:UnequipTools();
end);


local rift = require(script.Parent.Updated.StoreClient.RiftSystem)
local thunderstrike = require(script.Parent.RemoteListener.Modules.LightningStrike)

game.ReplicatedStorage.Bricks.FlashSpecify_AmountMax.OnClientEvent:Connect(function(p2, p3)
	local mainframe = script.Parent.Parent.Parent:FindFirstChild("MainFrame")
	local l__AmountMax__3 = mainframe.FlashSpecify:FindFirstChild("AmountMax");
	if not l__AmountMax__3 then
		return;
	end;
	local v4 = p2:GetAttribute("DurabilityMax");
	local v5 = l__AmountMax__3:Clone();
	v5.Image = p2.TextureId;
	v5.Name = v5.Name .. "Live";
	v5.DurabilityNumber.Text = p3 .. "/" .. p3;
	v5.Parent = u1.MainFrame.FlashSpecify;
	v5.Visible = true;
	l__TweenService__1:Create(v5, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = UDim2.new(0.3, 0, 0.3, 0)
	}):Play();
	l__TweenService__1:Create(v5, TweenInfo.new(2.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
	wait(2);
	for v6, v7 in pairs(v5:GetDescendants()) do
		if v7:IsA("Frame") then
			l__TweenService__1:Create(v7, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
				BackgroundTransparency = 1
			}):Play();
		elseif v7:IsA("TextLabel") then
			l__TweenService__1:Create(v7, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
				TextTransparency = 1
			}):Play();
		elseif v7:IsA("UIStroke") then
			l__TweenService__1:Create(v7, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
				Transparency = 1
			}):Play();
		end;
	end;
	wait(0.49);
	v5:Destroy();
end)

game.ReplicatedStorage.Bricks.FlashSpecify_Amount.OnClientEvent:Connect(function(p2, p3, p4)
	print(p2, p3, p4)
	local mainframe = script.Parent.Parent.Parent:FindFirstChild("MainFrame")
	local l__Amount__3 = mainframe.FlashSpecify:FindFirstChild("Amount");
	if not l__Amount__3 then
		return;
	end;
	local v5 = l__Amount__3:Clone();
	v5.Image = p2;
	v5.Name = v5.Name .. "Live";
	v5.Max.Text = " /" .. p4;
	v5.Parent = mainframe.FlashSpecify;
	v5.Visible = true;
	l__TweenService__1:Create(v5, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = UDim2.new(0.3, 0, 0.3, 0)
	}):Play();
	l__TweenService__1:Create(v5, TweenInfo.new(2.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
	local PositionSet = v5.Max.Old.Position
	v5.Max.Old.Text = p3 - 1
	local PositionOld = v5.Max.Old.Position - UDim2.new(0, 0, 0.5, 0)
	v5.Max.New.Text = p3
	wait(0.2)
	l__TweenService__1:Create(v5, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = UDim2.new(0.5, 0, 0.5, 0)
	}):Play();
	v5.Max.New.Position = v5.Max.New.Position + UDim2.new(0, 0, 0.5, 0)
	v5.Max.New.Visible = true
	v5.Max.New.Transparency = 1
	v5.Max.New.UIStroke.Transparency = 1
	wait(0.2)
	l__TweenService__1:Create(v5.Max.New, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		TextTransparency = 0,
		Position = PositionSet
	}):Play();
	l__TweenService__1:Create(v5.Max.New.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Transparency = 0,
	}):Play();
	
	l__TweenService__1:Create(v5.Max.Old, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		TextTransparency = 1,
		Position = PositionOld
	}):Play();
	l__TweenService__1:Create(v5.Max.Old.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Transparency = 1,
	}):Play();
	wait(2);
	for v6, v7 in pairs(v5:GetDescendants()) do
		if v7:IsA("Frame") then
			l__TweenService__1:Create(v7, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
				BackgroundTransparency = 1
			}):Play();
		elseif v7:IsA("TextLabel") then
			l__TweenService__1:Create(v7, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
				TextTransparency = 1
			}):Play();
		elseif v7:IsA("UIStroke") then
			l__TweenService__1:Create(v7, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
				Transparency = 1
			}):Play();
		end;
	end;
	wait(0.49);
	v5:Destroy();
end)

game.ReplicatedStorage.Bricks.FlashSpecify_BetterShape.OnClientEvent:Connect(function(p2, p3, p4)
	local mainframe = script.Parent.Parent.Parent:FindFirstChild("MainFrame")
	local l__BetterShape__3 = mainframe.FlashSpecify.BetterShape
	if not l__BetterShape__3 then
		return;
	end;
	local v4 = p2:GetAttribute("DurabilityMax");
	local v5 = l__BetterShape__3:Clone();
	v5.Image = p2.TextureId;
	v5.Name = v5.Name .. "Live";
	v5.Durability.Bar.Size = UDim2.new(p3 / v4, 0, 1, 0);
	v5.Durability.BarOther.Size = UDim2.new(p4 / v4, 0, 1, 0);
	v5.Parent = mainframe.FlashSpecify;
	v5.Visible = true;
	l__TweenService__1:Create(v5, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = UDim2.new(0.3, 0, 0.3, 0)
	}):Play();
	l__TweenService__1:Create(v5, TweenInfo.new(2.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
	l__TweenService__1:Create(v5.Reason, TweenInfo.new(2.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
	l__TweenService__1:Create(v5.Durability.Bar, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 4, true, 0), {
		BackgroundTransparency = 0, 
		BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	}):Play();
	l__TweenService__1:Create(v5.Durability.BarOther, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 4, true, 0), {
		BackgroundColor3 = Color3.fromRGB(234, 91, 55)
	}):Play();
	l__TweenService__1:Create(v5.Durability, TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
		Position = UDim2.new(0.5, 0, 1.05, 4)
	}):Play();
	wait(2);
	l__TweenService__1:Create(v5.Durability, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		Size = UDim2.new(0, 0, 0.06, 4)
	}):Play();
	for v6, v7 in pairs(v5:GetDescendants()) do
		if v7:IsA("Frame") then
			l__TweenService__1:Create(v7, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
				BackgroundTransparency = 1
			}):Play();
		end;
	end;
	wait(0.49);
	v5:Destroy();
end)

game.ReplicatedStorage.Bricks.FlashSpecify_Swap.OnClientEvent:Connect(function(p2, p3, p4)
	local mainframe = script.Parent.Parent.Parent:FindFirstChild("MainFrame")
	local l__Swap__3 = mainframe.FlashSpecify.Swap
	if not l__Swap__3 then
		return;
	end;
	local v4 = p2:GetAttribute("DurabilityMax");
	local v5 = l__Swap__3:Clone();
	v5.Image = p2.TextureId;
	v5.Name = v5.Name .. "Live";
	v5.Durability.Bar.Size = UDim2.new(p3 / v4, 0, 1, 0);
	v5.Durability.BarOld.Size = UDim2.new(p3 / v4, 0, 1, 0);
	v5.Parent = mainframe.FlashSpecify;
	v5.Visible = true;
	l__TweenService__1:Create(v5, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = UDim2.new(0.3, 0, 0.3, 0)
	}):Play();
	l__TweenService__1:Create(v5, TweenInfo.new(2.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
	l__TweenService__1:Create(v5.Reason, TweenInfo.new(2.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
	wait(0.3);
	l__TweenService__1:Create(v5.Durability.Bar, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = UDim2.new(p4 / v4, 0, 1, 0)
	}):Play();
	l__TweenService__1:Create(v5.Durability.Bar, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		BackgroundTransparency = 0, 
		BackgroundColor3 = Color3.fromRGB(255, 222, 189)
	}):Play();
	l__TweenService__1:Create(v5.Durability.BarOld, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		BackgroundTransparency = 1
	}):Play();
	wait(2);
	l__TweenService__1:Create(v5.Durability, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		Size = UDim2.new(0, 0, 0.06, 4)
	}):Play();
	for v6, v7 in pairs(v5:GetDescendants()) do
		if v7:IsA("Frame") then
			l__TweenService__1:Create(v7, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
				BackgroundTransparency = 1
			}):Play();
		end;
	end;
	wait(0.39);
	v5:Destroy();
end)

game.ReplicatedStorage.Bricks.FlashSpecify_ChargeMax.OnClientEvent:Connect(function(p2)
	local mainframe = script.Parent.Parent.Parent:FindFirstChild("MainFrame")
	local l__ChargeMax__3 = mainframe.FlashSpecify.ChargeMax
	if not l__ChargeMax__3 then
		return;
	end;
	local v4 = p2:GetAttribute("DurabilityMax");
	local v5 = l__ChargeMax__3:Clone();
	v5.Image = p2.TextureId;
	v5.Name = v5.Name .. "Live";
	v5.Parent = mainframe.FlashSpecify;
	v5.Visible = true;
	l__TweenService__1:Create(v5, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = UDim2.new(0.3, 0, 0.3, 0)
	}):Play();
	l__TweenService__1:Create(v5, TweenInfo.new(2.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
	l__TweenService__1:Create(v5.Reason, TweenInfo.new(2.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
	l__TweenService__1:Create(v5.Durability.Bar, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 4, true, 0), {
		BackgroundTransparency = 0, 
		BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	}):Play();
	l__TweenService__1:Create(v5.Durability, TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
		Position = UDim2.new(0.5, 0, 1.05, 4)
	}):Play();
	wait(2);
	l__TweenService__1:Create(v5.Durability, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		Size = UDim2.new(0, 0, 0.06, 4)
	}):Play();
	for v6, v7 in pairs(v5:GetDescendants()) do
		if v7:IsA("Frame") then
			l__TweenService__1:Create(v7, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
				BackgroundTransparency = 1
			}):Play();
		end;
	end;
	wait(0.49);
	v5:Destroy();
end)

game.ReplicatedStorage.Bricks.FlashSpecify_Charge.OnClientEvent:Connect(function(p2, p3, p4)
	local mainframe = script.Parent.Parent.Parent:FindFirstChild("MainFrame")
	local l__Charge__3 = mainframe.FlashSpecify.Charge
	local v4 = p2:GetAttribute("DurabilityMax");
	local v5 = l__Charge__3:Clone();
	v5.Image = p2.TextureId;
	v5.Name = v5.Name .. "Live";
	v5.Durability.Bar.Size = UDim2.new(p3 / v4, 0, 1, 0);
	v5.Durability.BarOld.Size = UDim2.new(p3 / v4, 0, 1, 0);
	v5.Parent = mainframe.FlashSpecify;
	v5.Visible = true;
	l__TweenService__1:Create(v5, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = UDim2.new(0.3, 0, 0.3, 0)
	}):Play();
	l__TweenService__1:Create(v5, TweenInfo.new(2.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
	l__TweenService__1:Create(v5.Reason, TweenInfo.new(2.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
		ImageTransparency = 1
	}):Play();
	wait(0.3);
	l__TweenService__1:Create(v5.Durability.Bar, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = UDim2.new(p4 / v4, 0, 1, 0)
	}):Play();
	l__TweenService__1:Create(v5.Durability.Bar, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		BackgroundTransparency = 0, 
		BackgroundColor3 = Color3.fromRGB(255, 222, 189)
	}):Play();
	l__TweenService__1:Create(v5.Durability.BarOld, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		BackgroundTransparency = 1
	}):Play();
	wait(2);
	l__TweenService__1:Create(v5.Durability, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
		Size = UDim2.new(0, 0, 0.06, 4)
	}):Play();
	for v6, v7 in pairs(v5:GetDescendants()) do
		if v7:IsA("Frame") then
			l__TweenService__1:Create(v7, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
				BackgroundTransparency = 1
			}):Play();
		end;
	end;
	wait(0.39);
	v5:Destroy();
end)

game.ReplicatedStorage.ClientBricks.PlayerInDark.OnClientEvent:Connect(function()
	game.Lighting.FogEnd = 15
	
	l__TweenService__1:Create(game.Lighting, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		FogColor = Color3.new(0, 0, 0),
		--FogEnd = 15,
		FogStart = 5
	}):Play();
end)

game.ReplicatedStorage.ClientBricks.PlayerOutDark.OnClientEvent:Connect(function()
	l__TweenService__1:Create(game.Lighting, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		FogColor = Color3.new(0, 0, 0),
		FogEnd = 5000,
		FogStart = 100
	}):Play();
end)

game.ReplicatedStorage.ClientBricks.PlayerHide.OnClientEvent:Connect(function()
	
	local runService = game:GetService("RunService")
	
	local camera = workspace.CurrentCamera
	local head = v2.char:WaitForChild("Head")
	
	for i,v in pairs(v2.char:GetChildren()) do
		if v:IsA("Accessory") then
			if v:FindFirstChildOfClass("Part") then
				v:FindFirstChildOfClass("Part").Transparency = 1
			elseif v:FindFirstChildOfClass("MeshPart") then
				v:FindFirstChildOfClass("MeshPart").Transparency = 1
			elseif v:FindFirstChildOfClass("BasePart") then
				v:FindFirstChildOfClass("BasePart").Transparency = 1
			end
		end
	end

	local event = runService.RenderStepped:Connect(function()
		camera.CFrame = head.CFrame
	end)
	
	game.ReplicatedStorage.ClientBricks.PlayerGetout.OnClientEvent:Connect(function()
		event:Disconnect()
		
		for i,v in pairs(v2.char:GetChildren()) do
			if v:IsA("Accessory") then
				if v:FindFirstChildOfClass("Part") then
					v:FindFirstChildOfClass("Part").Transparency = 0
				elseif v:FindFirstChildOfClass("MeshPart") then
					v:FindFirstChildOfClass("MeshPart").Transparency = 0
				elseif v:FindFirstChildOfClass("BasePart") then
					v:FindFirstChildOfClass("BasePart").Transparency = 0
				end
			end
		end
		v2.cam.CameraSubject = v2.char:WaitForChild("Humanoid");
		--v2.freemouse = false;
	end)--]]
	
end)

game.ReplicatedStorage.ClientBricks.AntiTool.OnClientEvent:Connect(function()
	v2.tool = false
	v2.faketool = false
end)

game.ReplicatedStorage.ClientBricks.RiftInfirmary.OnClientEvent:Connect(function()
	rift:SpawnRift(v3f)
end)

game.ReplicatedStorage.ClientBricks.RiftSpawn.OnClientEvent:Connect(function()
	rift:StartSpawn(v3f)
end)

game.ReplicatedStorage.ClientBricks.SkipItemShop.OnClientEvent:Connect(function()
	v1.ItemShop.Visible = false
	v2.freemouse = false
end)

game.ReplicatedStorage.ClientBricks.HealthChange.OnClientEvent:Connect(function()
	v1.MainFrame.Healthbar.Visible = true
	v1.MainFrame.Healthbar.Effects.HerbGreenEffect.Visible = true
	v1.MainFrame.Healthbar.Effects.Visible = true
end)

game.ReplicatedStorage.ClientBricks.Entities.HaltActive.OnClientEvent:Connect(function(v1)
	require(game.ReplicatedStorage.ClientModules.EntityModules.Shade).stuff(v2, v1)
end)

game.ReplicatedStorage.ClientBricks.Entities.GlitchActive.OnClientEvent:Connect(function(cb)
	require(game.ReplicatedStorage.ClientModules.EntityModules.Glitch).stuff(v2)
end)

game.ReplicatedStorage.ClientBricks.Entities.VoidClient.OnClientEvent:Connect(function()
	pcall(function()
	local tr = "RoomStart"
	if game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1):FindFirstChild("RoomEntrance") then
		tr = "RoomEntrance"
	end
	require(game.ReplicatedStorage.ClientModules.EntityModules.Void).stuff(v2, game.Workspace.CurrentRooms:FindFirstChild(game.Workspace.CurrentRooms.CurrentRoom.Value - 1)[tr].CFrame)
	end)	
end)

game.ReplicatedStorage.ClientBricks.Entities.VoidActive.OnClientEvent:Connect(function(cb)
	require(game.ReplicatedStorage.ClientModules.EntityModules.Void).stuff(v2, cb)
end)

game.ReplicatedStorage:FindFirstChild("ClientBricks"):WaitForChild("StressPlayer").OnClientEvent:Connect(function()
	v1.MainFrame.Healthbar.Visible = true
	l__TweenService__1:Create(v1.MainFrame.Healthbar.Bar.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		Color = Color3.fromRGB(255, 117, 107)
	}):Play();
	
	game.ReplicatedStorage:FindFirstChild("ClientBricks"):WaitForChild("StressServer"):FireServer(game.Players.LocalPlayer)
end)

game.ReplicatedStorage.Bricks.FireCamera.OnClientEvent:Connect(function(p1, p2, p3, p4)
	v2.camShaker:ShakeOnce(p1, p2, p3, p4);
end)

game.ReplicatedStorage.ClientBricks.SeekChase.OnClientEvent:Connect(function()
	v3f.Character:FindFirstChild("Humanoid"):SetAttribute("SeekChase", true)
end)

game.ReplicatedStorage.EntityInfo.SeekClientEnd.OnClientEvent:Connect(function(plr, v)
	l__TweenService__1:Create(game:GetService("Lighting"), TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		Ambient = Color3.new(0, 0, 0)
	}):Play();
	game.SoundService.Main:FindFirstChild("ChaseInSession").TimePosition = 92.5
	v:Destroy()
end)

game.ReplicatedStorage.ClientBricks.SeekEnd.OnClientEvent:Connect(function()
	v3f.Character:FindFirstChild("Humanoid"):SetAttribute("SeekChase", false)
	v2.fovtarget = 70
end)

game.Players.LocalPlayer.InGameStats.SeekInCutsene.Changed:Connect(function()
	if game.Players.LocalPlayer.InGameStats.SeekInCutsene.Value == true then
		v1.Enabled = false
		vperm.Enabled = false
	else
		v1.Enabled = true
		vperm.Enabled = true
	end
end)

--[[game.ReplicatedStorage.Bricks:FindFirstChild("TweenHotbar").OnClientEvent:Connect(function(item, number)
	l__TweenService__1:Create(game.Players.LocalPlayer.PlayerGui:WaitForChild("MainUI").Hotbar:FindFirstChild(item).Durability.Bar, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		Size = UDim2.new(number, 0, 1, 0)
	}):Play();
end)--]]

if game:GetService("ReplicatedStorage"):FindFirstChild("PlayClientSound") then
	game:GetService("ReplicatedStorage"):FindFirstChild("PlayClientSound").OnClientEvent:Connect(function(p1, p2)
		local sound = Instance.new("Sound")
		sound.Parent = script
		
		sound.SoundId = p1
		sound.Volume = p2
		
		task.wait()
		sound:Play()
		
		sound.Ended:Connect(function()
			sound:Destroy()
		end)
	end)
end

if game:GetService("ReplicatedStorage"):FindFirstChild("ClientBricks") then
	game:GetService("ReplicatedStorage"):FindFirstChild("ClientBricks").PlayServerObtainSound.OnClientEvent:Connect(function(p1, p2, p3, p4, p5)
		local sound = Instance.new("Sound")
		sound.Parent = p3
		
		sound.RollOffMaxDistance = p4
		sound.RollOffMinDistance = p5
		
		sound.SoundId = p1
		sound.Volume = p2

		task.wait()
		sound:Play()

		sound.Ended:Connect(function()
			sound:Destroy()
		end)
	end)
end
game.ReplicatedStorage.Bricks.AchievementUnlock.OnClientEvent:Connect(function(p1, p2, p3, p4)
	local player = game.Players.LocalPlayer
	if not game:GetService("BadgeService"):UserHasBadgeAsync(player.UserId, p1) then
		game.ReplicatedStorage.Achievement:FireClient(player, p2, p3, p4, "rbxassetid://"..p1)
		game:GetService("BadgeService"):AwardBadge(player.UserId, p1)
	else
		return
	end
end)

game.ReplicatedStorage.Bricks.ItemDetect.OnClientEvent:Connect(function(Item)
	if v3f.PlayerGui:FindFirstChild("MainUI").MainFrame.Hotbar:FindFirstChild(Item) then
		v3f.PlayerGui:FindFirstChild("MainUI").MainFrame.Hotbar:FindFirstChild(Item):Destroy()
	end
end)

game.ReplicatedStorage.Bricks.ItemGiver.OnClientEvent:Connect(function(Item)
	if not v3f.Backpack:FindFirstChild(Item) and v3f.Character:FindFirstChild(Item) then
		local Item = game.ServerStorage:FindFirstChild(Item):Clone()
		Item.Parent = v3f.Backpack
	end
end)

--[[game.ReplicatedStorage.Bricks:FindFirstChild("ReturingToLobby").OnClientEvent:Connect(function()
	--script.Parent.Parent.Parent.DeathPanelDead.PlayAgain.Timer.Text = "Returing to Lobby..."
	script.P--arent.Parent.Parent.DeathPanelDead.PlayAgain.Players.Visible = false
end)-]]

local l__DeathPanelDead__26 = script.Parent.Parent.Parent.DeathPanelDead
local debouce = true

--[[function playAnimation()
	l__DeathPanelDead__26.Caption.Visible = true
	while wait(0.1) do
		l__TweenService__1:Create(l__DeathPanelDead__26.Caption, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			TextColor3 = Color3.fromRGB(198, 255, 188)
		}):Play();
		wait(1)
		l__TweenService__1:Create(l__DeathPanelDead__26.Caption, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			TextColor3 = Color3.fromRGB(255, 222, 189)
		}):Play();
		wait(2)
	end
end--]]

--[[__DeathPanelDead__26.Leave.MouseButton1Down:Connect(function()
	if debouce == true then
		game.ReplicatedStorage.Bricks.ReturingToLobby:FireServer(v3f)
		--playAnimation()
		debouce = false
	else
		return
	end
end);--]]

if v2.chase == true then
	script.Parent.Parent.Parent.MainFrame.Healthbar.Visible = false
	script.Parent.Parent.Parent.MainFrame.Crosshair.Visible = false
else
	script.Parent.Parent.Parent.MainFrame.Crosshair.Visible = true
end


local l__TweenService__5 = game:GetService("TweenService");

--[[game.ReplicatedStorage.Bricks:WaitForChild("KeyRequire").OnClientEvent:Connect(function(Item)
	
	local capureting = false
	
	function v1(photo)
		if capureting == false then
			capureting = true
			local l__TweenService__5 = game:GetService("TweenService");
			local v8 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
			local v9 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
			local v1 = script.ItemTemplate
			v1.Parent = script.Parent.Parent.Parent.MainFrame.Item
			v1.Image = photo
			local v2 = 0.1 
			l__TweenService__5:Create(v1, v8, {
				ImageColor3 = Color3.fromRGB(255, 189, 189)
			}):Play();
			wait(v2)
			l__TweenService__5:Create(v1, v8, {
				ImageColor3 = Color3.fromRGB(255, 255, 255),
				Size = UDim2.new(0, 88, 0, 88)
			}):Play();
			wait(v2)
			l__TweenService__5:Create(v1, v8, {
				ImageColor3 = Color3.fromRGB(255, 189, 189)
			}):Play();
			wait(v2)
			l__TweenService__5:Create(v1, v8, {
				ImageColor3 = Color3.fromRGB(255, 255, 255)
			}):Play();
			wait(v2)
			l__TweenService__5:Create(v1, v8, {
				ImageColor3 = Color3.fromRGB(255, 189, 189)
			}):Play();
			wait(v2)
			l__TweenService__5:Create(v1, v8, {
				ImageColor3 = Color3.fromRGB(255, 255, 255)
			}):Play();
			wait(v2)
			l__TweenService__5:Create(v1, v8, {
				ImageColor3 = Color3.fromRGB(255, 189, 189)
			}):Play();
			wait(v2)
			l__TweenService__5:Create(v1, v8, {
				ImageColor3 = Color3.fromRGB(255, 255, 255)
			}):Play();
			wait(v2)
			l__TweenService__5:Create(v1, v9, {
				ImageTransparency = 1
			}):Play();
			wait(1.2)
			v1.Parent = script
			v1.ImageTransparency = 0
			v1.Size = UDim2.new(0, 79, 0, 79)
			v1.Image = ""
			capureting = false
		else
			print("Spamming on KeyRequire")
		end
	end
	
	if Item == "Key" then
		v1("rbxassetid://7818981800")
	elseif Item == "ElectricKey" then
		v1("rbxassetid://13394514666")
	elseif Item == "Cannot" then
		v1("rbxassetid://11639544819")

	elseif Item == "Lighter" then
		v1("rbxassetid://9994899589")
	elseif Item == "Crucifix" then
		v1("rbxassetid://11414232888")
	elseif Item == "Shears" then
		v1("rbxassetid://11389545392")
	elseif Item == "Lockpick" then
		v1("rbxassetid://10264432376")
	end
end)--]]

--[[game.ReplicatedStorage.Bricks:WaitForChild("KeyFull").OnClientEvent:Connect(function(Item, Count)
	
	local capureting = false
	
	function v1(photo)
		if capureting == false then
			capureting = true
			local l__TweenService__5 = game:GetService("TweenService");
			local v8 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
			local v9 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
			local v1 = script.ItemTemplate
			v1.Parent = script.Parent.Parent.Parent.MainFrame.Item
			v1.Image = photo
			v1.DurabilityText.Text = Count
			v1.DurabilityText.Visible = true
			local v2 = 0.1 
			l__TweenService__5:Create(v1, v8, {
				ImageColor3 = Color3.fromRGB(255, 255, 255)
			}):Play();
			wait(v2)
			l__TweenService__5:Create(v1, v8, {
				Size = UDim2.new(0, 88, 0, 88)
			}):Play();
			wait(v2)
			l__TweenService__5:Create(v1.DurabilityText, v8, {
				TextColor3 = Color3.fromRGB(255, 64, 64)
			}):Play();
			wait(v2)
			l__TweenService__5:Create(v1.DurabilityText, v8, {
				TextColor3 = Color3.fromRGB(255, 255, 255)
			}):Play();
			wait(v2)
			l__TweenService__5:Create(v1.DurabilityText, v8, {
				TextColor3 = Color3.fromRGB(255, 64, 64)
			}):Play();
			wait(v2)
			l__TweenService__5:Create(v1.DurabilityText, v8, {
				TextColor3 = Color3.fromRGB(255, 255, 255)
			}):Play();
			wait(v2)
			l__TweenService__5:Create(v1.DurabilityText, v8, {
				TextColor3 = Color3.fromRGB(255, 64, 64)
			}):Play();
			wait(v2)
			l__TweenService__5:Create(v1.DurabilityText, v8, {
				TextColor3 = Color3.fromRGB(255, 255, 255)
			}):Play();
			wait(v2)
			l__TweenService__5:Create(v1.DurabilityText, v9, {
				TextTransparency = 1
			}):Play();
			l__TweenService__5:Create(v1.DurabilityText.UIStroke, v9, {
				Transparency = 1
			}):Play();
			l__TweenService__5:Create(v1, v9, {
				ImageTransparency = 1
			}):Play();
			wait(1.2)
			v1.Parent = script
			v1.ImageTransparency = 0
			v1.DurabilityText.Visible = false
			v1.DurabilityText.TextTransparency = 0
			v1.DurabilityText.UIStroke.Transparency = 0
			v1.Size = UDim2.new(0, 79, 0, 79)
			v1.Image = ""
			capureting = false
		else
			print("Spamming on KeyFull")
		end
	end

	if Item == "Key" then
		v1("rbxassetid://7818981800")
	elseif Item == "ElectricKey" then
		v1("rbxassetid://13394514666")
	elseif Item == "Vitamins" then
		v1("rbxassetid://10482863785")
	end
end)--]]

local bodyRot = CFrame.new(0,0,0)
local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
local players = game:GetService("Players")
local player = players.LocalPlayer
local character = player.Character or player.CharacterAdded:wait()

local humRootPart = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
game["Run Service"].RenderStepped:Connect(function()
	character.Humanoid.AutoRotate = false
end)

local d = false

while true do
	
	if v2.dead == true then
		if d == false then
			d = true
			
			v3f.Character.TiltMovement.Enabled = false
			
			v2.freemouse = true
			script.Parent.Parent.Parent.MainFrame.Hotbar.Visible = false
			script.Parent.Parent.Parent.MainFrame.Healthbar.Visible = false
			script.Parent.Parent.Parent.MainFrame.Crosshair.Visible = false
		end
	end
	
	local d = math.random(7, 15)
	wait(d)
	
	if game.Players.LocalPlayer.PlayerStats.TypeRun.Value == "Hotel" then
		thunderstrike()
	end
end