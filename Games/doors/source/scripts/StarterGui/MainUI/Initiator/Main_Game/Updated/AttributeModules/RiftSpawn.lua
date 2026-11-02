-- Decompiled with the Synapse X Luau decompiler.

local u1 = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicaDataModule"));
local l__TweenService__2 = game:GetService("TweenService");
return function(p1)
	local v1 = p1:GetAttribute("ShowIfNoItem");
	p1.PrimaryPart.Transparency = 1;
	while true do
		wait();
		if u1.data then
			break;
		end;	
	end;
	local v2 = game.ReplicatedStorage:WaitForChild("Misc"):WaitForChild("Rift"):Clone();
	v2:PivotTo(p1.WorldPivot);
	local function v3()
		local l__RiftItem__4 = u1.data.RiftItem;
		for v5, v6 in pairs(v2.Center.ParticlesOut:GetChildren()) do
			if v6:IsA("ParticleEmitter") then
				v6:Emit(v6:GetAttribute("EmitAmount"));
			end;
		end;
		wait(0.2);
		if l__RiftItem__4 and typeof(l__RiftItem__4) == "table" and l__RiftItem__4.Name then
			v2.Center.ItemHolder.Item.Texture = "rbxassetid://" .. l__RiftItem__4.Image;
			return true;
		end;
		v2.Center.ItemHolder.Item.Texture = "";
		if not v1 then
			local l__ParticlesIn__7 = v2:FindFirstChild("ParticlesIn", true);
			if l__ParticlesIn__7 then
				for v8, v9 in pairs(l__ParticlesIn__7:GetChildren()) do
					if v9:IsA("ParticleEmitter") then
						v9.TimeScale = 1;
						v9.Enabled = false;
					end;
				end;
			end;
			for v10, v11 in pairs(v2:GetDescendants()) do
				if v11:IsA("Sound") and v11.Looped then
					l__TweenService__2:Create(v11, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Volume = 0, 
						Pitch = 0.01
					}):Play();
				elseif v11:IsA("BasePart") then
					l__TweenService__2:Create(v11, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Transparency = 1
					}):Play();
				elseif v11:IsA("Light") then
					l__TweenService__2:Create(v11, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Brightness = 0
					}):Play();
				end;
			end;
			p1:FindFirstChild("RiftPrompt", true).Enabled = false;
		end;
		return false;
	end;
	if v3() or v1 then
		v2.Parent = p1;
		v2.Center.Music:Play();
		v2.Center.MusicClose:Play();
		p1.RiftPrompt.Parent = v2;
	end;
	u1.event.RiftItem.Event:Connect(v3);
end;
