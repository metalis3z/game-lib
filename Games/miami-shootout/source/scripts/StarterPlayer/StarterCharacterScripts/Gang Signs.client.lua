-- Decompiled with the Synapse X Luau decompiler.

local l__mouse__1 = game.Players.LocalPlayer:GetMouse();
local v2 = game.Players:WaitForChild("" .. script.Parent.Name .. "");
local l__Character__3 = v2.Character;
local l__Humanoid__4 = l__Character__3:WaitForChild("Humanoid");
Toggle = false;
local v5 = Instance.new("Animation", l__Character__3);
v5.Name = "Actions";
v5.AnimationId = "http://www.roblox.com/Asset?ID=431926970";
local u1 = l__Humanoid__4:LoadAnimation(v5);
v2.Chatted:connect(function(p1)
	if p1:sub(1, 8) == "/e DOA" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://15049268468";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/sturdy1" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://11877156017";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/sturdy3" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://11877164825";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/sturdy2" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://11877184225";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/sturdy4" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://11877187467";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/e 4zK" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://15049270534";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/e YGZ" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://15049286646";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/e YGZK" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://11402844266";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/e GD" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://11402935021";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/e GDK" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://11402949315";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/e OY" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://11402970234";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/e OYK" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://11402980466";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/e MB" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://11403005365";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/e MBK" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://11403010330";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/e OYOG" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://11403044926";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/e Crip" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://11413027728";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/e CripK" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://11413037467";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/e Notti" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://11426582851";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/e WDE" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://11715123935";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/e Reverse" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://11801272038";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/e Jersey" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://11801282047";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/e side2side" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://11801292886";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/e SB" then
		if Toggle == false then
			Toggle = true;
			u1:Stop();
			v5.AnimationId = "rbxassetid://11814432049";
			anim1 = l__Humanoid__4:LoadAnimation(v5);
			anim1:Play();
			return;
		else
			Toggle = false;
			anim1:Stop();
			return;
		end;
	end;
	if p1:sub(1, 12) == "/e c" then
		if Toggle ~= false then
			Toggle = false;
			anim1:Stop();
			return;
		end;
	else
		return;
	end;
	Toggle = true;
	u1:Stop();
	v5.AnimationId = "rbxassetid://8515236908";
	anim1 = l__Humanoid__4:LoadAnimation(v5);
	anim1:Play();
end);
