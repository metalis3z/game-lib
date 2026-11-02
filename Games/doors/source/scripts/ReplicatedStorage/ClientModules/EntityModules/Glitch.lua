-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local v2 = game:GetService("ReplicatedStorage").Misc.Eyes:GetChildren();
v1.module_events = require(script.Parent.Parent.Module_Events);
local l__TweenService__1 = game:GetService("TweenService");
function v1.stuff(p1, p2, p3)
	local u2 = p3;
	spawn(function()
		if p1.dead == true then
			return;
		end;
		if not u2 then
			u2 = math.random(1, 500);
		end;
		u2 = Random.new(u2);
		local l__LocalPlayer__3 = game.Players.LocalPlayer;
		local l__PrimaryPart__4 = l__LocalPlayer__3.Character.PrimaryPart;
		local v5 = (p1.cam.CFrame.LookVector * Vector3.new(1, 0, 1)).unit * -1;
		local l__p__6 = p1.cam.CFrame.p;
		l__TweenService__1:Create(p1.cam, TweenInfo.new(0.9, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
			CFrame = CFrame.new(l__p__6 + v5 * 2, l__p__6 + v5 * 10)
		}):Play();
		l__PrimaryPart__4.Anchored = true;
		p1.stopcam = true;
		p1.hideplayers = 1;
		local v7 = game:GetService("ReplicatedStorage").Entities.Glitch:Clone();
		local v8 = l__PrimaryPart__4.Position + Vector3.new(0, 7, 0) + v5 * 150;
		v7:SetPrimaryPartCFrame(CFrame.new(v8, v8 - v5));
		v7.Parent = p1.cam;
		v7.Root.SoundHurt:Play();
		v7.AnimationController:LoadAnimation(v7.Animations.Run):Play(0);
		l__TweenService__1:Create(v7.Root, TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
			CFrame = CFrame.new(v8 - v5 * 140, v8 - v5 * 250)
		}):Play();
		p1.camShaker:ShakeOnce(4, 15, 1, 1);
		p1.camShaker:ShakeOnce(12, 3, 1, 1);
		l__TweenService__1:Create(game:GetService("Lighting"), TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			FogEnd = 500, 
			FogStart = 0, 
			--FogColor = Color3.new(0, 0, 0), 
			--Ambient = Color3.new(0, 0, 0)
		}):Play();
		local v9 = workspace.CurrentRooms:FindFirstChild(l__LocalPlayer__3:GetAttribute("CurrentRoom"));
		local u3 = tick() + 2;
		task.spawn(function()
			local v10 = l__LocalPlayer__3.PlayerGui.MainUI.MainFrame.GlitchEffect:Clone();
			for v11 = 1, 60 do
				for v12 = 1, 8 do
					local v13 = v10:Clone();
					v13.Name = "FakeGlitchLive";
					v13.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0);
					v13.Rotation = math.random(0, 1) * 180;
					v13.Visible = true;
					v13.Parent = l__LocalPlayer__3.PlayerGui.MainUI;
					game.Debris:AddItem(v13, math.random(1, 20) / 100);
				end;
				task.wait(0.016666666666666666);
				if u3 <= tick() then
					break;
				end;
			end;
		end);
		script.Sound:Play();
		wait(0.7);
		v7.AnimationController:LoadAnimation(v7.Animations.Attack):Play(0);
		game.Lighting.Ambience_Glitch.Enabled = true;
		task.wait(0.05);
		l__LocalPlayer__3.PlayerGui.MainUI.MainFrame.GlitchScreen.Visible = true;
		task.wait(0.1);
		task.wait(1);
		l__LocalPlayer__3.PlayerGui.MainUI.MainFrame.GlitchScreen.Visible = false;
		v7:Destroy();
		p1.hideplayers = 0;
		
		local AAAAAA = workspace.CurrentRooms:FindFirstChild(game.Players.LocalPlayer:GetAttribute("CurrentRoom"));
		local BBBBB = Color3.fromRGB(67, 51, 56);
		if AAAAAA then
			local CCCCC = AAAAAA:GetAttribute("Ambient");
			if CCCCC and type(CCCCC) == "userdata" then
				BBBBB = CCCCC;
			end;
		end;
		
		l__TweenService__1:Create(game:GetService("Lighting"), TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			--[[FogEnd = game.Lighting.FogEnd, 
			FogStart = 15, 
			FogColor = Color3.new(0, 0, 0)]]
			FogEnd = game.Lighting:GetAttribute("FogEnd"), 
			FogStart = game.Lighting:GetAttribute("FogStart"), 
			FogColor = BBBBB
		}):Play();
		p1.stopcam = false;
		l__PrimaryPart__4.Anchored = false;
		task.wait(0.05);
		game.Lighting.Ambience_Glitch.Enabled = false;
	end);
end;
return v1;
