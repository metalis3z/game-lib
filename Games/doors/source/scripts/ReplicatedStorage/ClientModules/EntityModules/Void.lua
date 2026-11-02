-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local v2 = game:GetService("ReplicatedStorage").Misc.Eyes:GetChildren();
v1.module_events = require(script.Parent.Parent.Module_Events);
local l__TweenService__1 = game:GetService("TweenService");

local debounce = false

function v1.stuff(p1, cb)
	if debounce == false then
		debounce = true
		spawn(function()
			if p1.dead == true then
				return;
			end;
			local l__LocalPlayer__3 = game.Players.LocalPlayer;
			local l__PrimaryPart__4 = l__LocalPlayer__3.Character.PrimaryPart;
			local v5 = (p1.cam.CFrame.LookVector * Vector3.new(1, 0, 1)).unit * -1;
			local l__p__6 = p1.cam.CFrame.p;
			script.Sound.SoundGroup = nil;
			script.Sound:Play();
			l__PrimaryPart__4.Anchored = true;
			p1.hideplayers = 1;
			p1.camShaker:ShakeOnce(12, 12, 1, 1);
			p1.camShaker:ShakeOnce(24, 3, 1, 1);
			--game.Lighting.FogEnd = 1000;
			local v7 = game.Lighting.Sanity:Clone();
			v7.Name = "LiveVoidReaction";
			v7.Enabled = true;
			v7.Parent = game.Lighting;
			local v8 = game.SoundService.Main.SanityEqualizer:Clone();
			v8.Name = "SanityEqualizerLive";
			v8.Enabled = true;
			v8.Parent = game.SoundService.Main;
			l__TweenService__1:Create(v7, TweenInfo.new(0.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
				Brightness = -2, 
				Contrast = 2, 
				TintColor = Color3.new(5, 1, 1)
			}):Play();
			l__TweenService__1:Create(game:GetService("Lighting"), TweenInfo.new(0.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
				FogEnd = 0, 
				FogStart = 0, 
				FogColor = Color3.new(0, 0, 0), 
				Ambient = Color3.new(0, 0, 0)
			}):Play();
			l__TweenService__1:Create(v8, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
				LowGain = 10, 
				MidGain = -20, 
				HighGain = -40
			}):Play();
			--local v9 = workspace.CurrentRooms:FindFirstChild(l__LocalPlayer__3:GetAttribute("CurrentRoom"));
			local v10 = tick() + 2;
			wait(1);
			l__PrimaryPart__4:PivotTo(cb)
			v7.Brightness = 2;
			p1.hideplayers = 0;
			l__TweenService__1:Create(v7, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
				Brightness = 0, 
				Contrast = 0, 
				TintColor = Color3.new(1, 1, 1)
			}):Play();
		--[[if game.Lighting:FindFirstChild("Atmosphere") then
			--//Idk man i just added this here else screen = black = no see
			l__TweenService__1:Create(game:GetService("Lighting"), TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				FogEnd = game.Lighting.FogEnd, 
				--FogStart = 15, -- original doors
				FogStart = 0, 
				FogColor = Color3.new(0, 0, 0)
			}):Play();
		else--]]

			--local AAAAAA = workspace.CurrentRooms:FindFirstChild(game.Players.LocalPlayer:GetAttribute("CurrentRoom"));
			local v80 = Color3.fromRGB(67, 51, 56);
	--[[	if AAAAAA then
			local v81 = AAAAAA:GetAttribute("Ambient");
			if v81 and type(v81) == "userdata" then
				v80 = v81;
			end;
		end;--]]

			l__TweenService__1:Create(game:GetService("Lighting"), TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				FogEnd = game.Lighting:GetAttribute("FogEnd"), 
				FogStart = game.Lighting:GetAttribute("FogStart"), 
				FogColor = v80
			}):Play();
			--end
			l__TweenService__1:Create(v8, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				LowGain = 0, 
				MidGain = 0, 
				HighGain = 0
			}):Play();
			l__PrimaryPart__4.Anchored = false;
			task.wait(1);
			debounce = false
			v7:Destroy();
			v8:Destroy();
		end);
	end
end;
return v1;
