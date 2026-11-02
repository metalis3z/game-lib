-- Decompiled with the Synapse X Luau decompiler.

local l__mouse__1 = game.Players.LocalPlayer:GetMouse();
local v2 = game.Players:WaitForChild("" .. script.Parent.Name .. "");
local l__Character__3 = v2.Character;
local l__Humanoid__4 = l__Character__3:WaitForChild("Humanoid");
Toggle = false;
local v5 = Instance.new("Animation", l__Character__3);
v5.Name = "";
v5.AnimationId = "http://www.roblox.com/Asset?ID=";
local v6 = Instance.new("Animation", l__Character__3);
v6.Name = "";
v6.AnimationId = "http://www.roblox.com/Asset?ID=";
local v7 = l__Humanoid__4:LoadAnimation(v6);
local v8 = Instance.new("Animation", l__Character__3);
v8.Name = "";
v8.AnimationId = "http://www.roblox.com/Asset?ID=";
local v9 = l__Humanoid__4:LoadAnimation(v8);
local v10 = Instance.new("Animation", l__Character__3);
v10.Name = "sit";
v10.AnimationId = "http://www.roblox.com/Asset?ID=15049260771";
local v11 = l__Humanoid__4:LoadAnimation(v10);
local u1 = l__Humanoid__4:LoadAnimation(v5);
v2.Chatted:connect(function(p1)
	if p1:sub(1, 5) == "" then
		u1:Stop();
		v5.AnimationId = "http://www.roblox.com/Asset?ID=";
		l__Humanoid__4:LoadAnimation(v5):Play();
		return;
	end;
	if p1:sub(1, 4) == "" then
		u1:Stop();
		v5.AnimationId = "http://www.roblox.com/Asset?ID=";
		l__Humanoid__4:LoadAnimation(v6):Play();
		return;
	end;
	if p1:sub(1, 7) == "" then
		u1:Stop();
		v5.AnimationId = "http://www.roblox.com/Asset?ID=";
		l__Humanoid__4:LoadAnimation(v8):Play();
		return;
	end;
	if p1:sub(1, 20) == "/nottibop" then
		if Toggle ~= false then
			if Toggle == true then
				Toggle = false;
				bounce:Stop();
			end;
			return;
		end;
	else
		return;
	end;
	Toggle = true;
	u1:Stop();
	v5.AnimationId = "http://www.roblox.com/Asset?ID=11246184890";
	bounce = l__Humanoid__4:LoadAnimation(v10);
	bounce:Play();
end);
