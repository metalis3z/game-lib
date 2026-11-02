local mkps = game:GetService("MarketplaceService")
local idGamePass = 102417947 

local l__Parent__1 = script.Parent;
local l__Content__2 = l__Parent__1:WaitForChild("Content");
local l__Buttons__3 = l__Content__2:WaitForChild("Buttons");
local l__menus__4 = l__Content__2:WaitForChild("menus");
local l__teamsGui__5 = l__menus__4:WaitForChild("teamsGui");
local l__help__6 = l__menus__4:WaitForChild("help");
local l__premium__7 = l__menus__4:WaitForChild("premium");
local l__Teams__8 = game:GetService("Teams");
local l__NoticeFrame__9 = l__Parent__1:WaitForChild("NoticeFrame");
local l__okFrame__10 = l__Parent__1:WaitForChild("okFrame");
local l__tb1__11 = l__okFrame__10:WaitForChild("tb1");
local l__LocalPlayer__12 = game:GetService("Players").LocalPlayer;
local l__isBadGuard__13 = l__LocalPlayer__12.Character:WaitForChild("Status"):WaitForChild("isBadGuard");
local l__Remote__14 = workspace:WaitForChild("Remote");
local l__TeamEvent__15 = l__Remote__14.TeamEvent;
local u1 = {
	p1 = l__teamsGui__5, 
	p2 = l__menus__4:WaitForChild("help"), 
	p3 = l__menus__4:WaitForChild("premium")
};
local function u2(p1)
	for v16, v17 in pairs(l__menus__4:GetChildren()) do
		v17:TweenPosition(v17.Position + UDim2.new(0, 0, 1.4 * p1, 0), "Out", "Quint", 0.6, true);
	end;
end;
local function v18(p2)
	for v19 = 1, 3 do
		local v20 = u1["p" .. v19];
		if v20 and v20 == p2 then
			u2(v20.Position.Y.Scale / -1.4);
			return;
		end;
	end;
end;
local l__Parent__3 = l__Parent__1.Parent;
local l__RunService__4 = game:GetService("RunService");
local function v21(p3, p4, p5, p6)
	local v22 = p6 or l__Parent__3.fadeFrame;
	local v23 = p4 and 0.6;
	local v24 = p5 and 1;
	local v25 = false;
	local v26 = nil;
	local v27 = v22:findFirstChild("IsFading");
	local v28 = v22:findFirstChild("Interrupt");
	if v22:IsA("TextLabel") then
		v25 = true;
		if v27.Value then
			v28.Value = true;
			while true do
				wait();
				if v27.Value == false then
					break;
				end;			
			end;
		end;
		v27.Value = true;
	end;
	if p3 == "in" then
		v26 = -1;
		if not p6 then
			v22.Transparency = 1;
		end;
	elseif p3 == "out" then
		v26 = 1;
		if not p6 then
			v22.Transparency = 0;
		end;
	end;
	for v29 = 1, v23 * 60 do
		local v30 = nil;
		local v31 = l__RunService__4.RenderStepped:wait();
		v30 = v26 * (v24 / (v23 * 60) * (v31 / 0.0166666666666667));
		if v23 <= v31 then
			v22.Transparency = 1;
			return false;
		end;
		if v25 then
			if v28.Value then
				v28.Value = false;
				break;
			end;
			v22.TextTransparency = v22.TextTransparency + v30;
			if p3 == "out" and v22.TextTransparency >= 1 then
				v22.TextTransparency = 1;
				break;
			end;
			if p3 == "in" and v22.TextTransparency <= 0 then
				v22.TextTransparency = 0;
				break;
			end;
		else
			v22.Transparency = v22.Transparency + v30;
		end;
	end;
	if v27 then
		v27.Value = false;
	end;
	return true;
end;
local l__StarterGui__5 = game:GetService("StarterGui");
local l__CurrentCamera__6 = workspace.CurrentCamera;
local function u7()
	if l__LocalPlayer__12.TeamColor == BrickColor.new("Medium stone grey") then
		l__StarterGui__5:SetCoreGuiEnabled("All", false);
	end;
end;
local l__UserInputService__8 = game:GetService("UserInputService");
l__LocalPlayer__12.CharacterAdded:connect(function()
	u7();
end);
for v32, v33 in pairs(l__Buttons__3:GetChildren()) do
	local u9 = false;
	v33.MouseButton1Click:connect(function()
		if u9 == true then
			return;
		end;
		u9 = true;
		v18(l__menus__4[v33.Name]);
		u9 = false;
	end);
end;
local v34 = {
	button1 = l__NoticeFrame__9:WaitForChild("tb1"), 
	button2 = l__NoticeFrame__9:WaitForChild("tb2")
};
for v35, v36 in pairs(v34) do
	local l__Text__10 = v36.tl.Text;
	v36.MouseButton1Click:connect(function()
		l__NoticeFrame__9.Visible = false;
		wait();
		v36.tl.Text = l__Text__10;
	end);
end;
l__tb1__11.MouseButton1Click:connect(function()
	l__okFrame__10.Visible = false;
end);
v34.button2.MouseEnter:connect(function()
	v34.button2.tl.Text = "just kidding lmao";
end);
v34.button2.MouseLeave:connect(function()
	v34.button2.tl.Text = "Kick a random player";
end);
for v37, v38 in pairs(l__teamsGui__5:GetChildren()) do
	if v38:IsA("ImageLabel") then
		local u11 = false;
		v38:WaitForChild("Button").MouseButton1Click:connect(function()
			if not u11 then
				u11 = true;
				if v38.Name == "Guards" then
					if #l__Teams__8.Guards:GetPlayers() >= 8 then
						l__Parent__1.NoticeFrame.body.Text = "That team is full. Try joining another team.";
						l__Parent__1.NoticeFrame.Visible = true;
						u11 = false;
						return;
					end;
					if l__isBadGuard__13.Value then
						l__okFrame__10.Visible = true;
						u11 = false;
						return;
					end;
					
				elseif v38.Name == "Prisoners" then
				
				end;
				local v39 = v21("in");
				l__CurrentCamera__6.CameraType = "Custom";
				l__Parent__1.Visible = false;
				l__Parent__3.hud.Visible = true;
				wait(1);
				l__StarterGui__5:SetCoreGuiEnabled("All", true);
				if v39 then
					v21("out");
				end;
			end;
			u11 = false;
		end);
		local l__Desc__12 = v38:WaitForChild("Desc");
		v38.MouseEnter:connect(function()
			v21("in", 0.4, 1, l__Desc__12);
		end);
		v38.MouseLeave:connect(function()
			v21("out", 0.4, 1, l__Desc__12);
		end);
	end;
end;
l__premium__7:WaitForChild("riot").MouseButton1Click:connect(function()
	mkps:PromptGamePassPurchase(l__LocalPlayer__12, idGamePass)
end);
wait(0.2);
(function()
	u7();
	if l__UserInputService__8.TouchEnabled then
		print("User is on a touchscreen");
		l__Parent__1.Size = UDim2.new(1, 0, 1, 0);
		l__Parent__1.Position = UDim2.new(0, 0, 0.05, 0);
	end;
	for v40 = 1, 3 do
		local v41 = u1["p" .. v40];
		v41.Position = v41.Position + UDim2.new(0, 0, (v40 - 1) * 1.4, 0);
		v41.Visible = true;
	end;
end)();
