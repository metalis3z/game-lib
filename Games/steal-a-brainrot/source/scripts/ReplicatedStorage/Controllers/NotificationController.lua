local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("TweenService");
local l_GuiService_0 = game:GetService("GuiService");
local l_Players_0 = game:GetService("Players");
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local v6 = require(l_Packages_0.Net);
local l_Controllers_0 = l_ReplicatedStorage_0:WaitForChild("Controllers");
local v8 = require(l_Controllers_0.SoundController);
local _ = require(l_ReplicatedStorage_0.Packages.Gradients);
local v10 = require(l_ReplicatedStorage_0.Packages.CreateTween);
local v11 = require(l_ReplicatedStorage_0.Controllers.CustomRichTextController);
local l_PlayerGui_0 = l_Players_0.LocalPlayer.PlayerGui;
local l_Notification_0 = l_PlayerGui_0:WaitForChild("Notification").Notification;
local l_Template_0 = l_Notification_0.Template;
local v15 = v6:RemoteEvent("NotificationService/Notify");
local v16 = TweenInfo.new(1, Enum.EasingStyle.Linear);
local v17 = {};
v17.Error = function(_, v19)
	local v20 = ("<font color=\"#FA0103\">%*</font>"):format(v19);
	v17:Notify(v20, 5, "Sounds.Sfx.Error");
end;
v17.Success = function(_, v22)
	local v23 = ("<font color=\"#92FF67\">%*</font>"):format(v22);
	v17:Notify(v23, 5, "Sounds.Sfx.Success");
end;
local v24 = {};
v17.Notify = function(_, v26, v27, v28, v29, _, v31, v32, v40)
	task.spawn(function()
		v27 = v27 or 5;
		if v32 and v31 ~= nil and v24[v31] then
			v24[v31]:Destroy();
			v24[v31] = nil;
			return;
		elseif v26 == "" then
			if v28 then
				v8:PlaySound(v28);
			end;
			return;
		else
			local v33 = false;
			if v31 ~= nil then
				v33 = v24[v31];
			end;
			if v33 then
				v11.apply(v33, v26);
				return;
			else
				local v34 = l_Template_0:Clone();
				if v31 ~= nil then
					v24[v31] = v34;
				end;
				if v28 then
					v8:PlaySound(v28);
				end;
				v34.Visible = true;
				if v29 == "Top" then
					v34.Size = UDim2.fromScale(1, 0.3);
				end;
				local v41 = v34:FindFirstChild("Avatar");
				if v41 then
					if v40 then
						v41.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(v40) .. "&w=150&h=150";
						v41.Visible = true;
					else
						v41.Visible = false;
					end;
				end;
				v11.apply(v34, v26);
				v34.Parent = if v29 == "Top" then l_PlayerGui_0:WaitForChild("TopNotification").TopNotification else l_Notification_0;
				if v41 and v40 then
					-- Laisser le texte se dimensionner (TextScaled) avant de calculer sa largeur réelle
					l_RunService_0.Heartbeat:Wait();
					local v44 = v34.TextBounds.X;
					local v45 = 14; -- espace entre l'avatar et le texte
					local v46 = v41.AbsoluteSize.X;
					v41.Position = UDim2.new(0.5, -(v44 / 2) - v45 - v46, 0.5, 0);
				end;
				task.wait(v27);
				if not v34:IsDescendantOf(l_PlayerGui_0) then
					if v31 ~= nil then
						v24[v31] = nil;
					end;
					return;
				else
					for _, v36 in v34:GetChildren() do
						if v36:IsA("TextLabel") then
							v10(v34, v16, {
								TextTransparency = 1
							});
							v10(v34.UIStroke, v16, {
								Transparency = 1
							});
						end;
					end;
					task.wait(v16.Time);
					v34:Destroy();
					if v31 ~= nil then
						v24[v31] = nil;
					end;
					return;
				end;
			end;
		end;
	end);
end;
v17.Start = function(_)
	task.spawn(function()
		if not l_UserInputService_0:GetLastInputType() then
			l_UserInputService_0.LastInputTypeChanged:Wait();
		end;
		if l_UserInputService_0.PreferredInput ~= Enum.PreferredInput.Touch then
			return;
		else
			local v38 = 60;
			if l_GuiService_0:IsTenFootInterface() then
				v38 = 100;
			end;
			local v39 = v38 + 5 + 5;
			l_Notification_0.AnchorPoint = Vector2.new(0.5, 1);
			l_Notification_0.Position = UDim2.fromScale(0.5, 1) - UDim2.fromOffset(0, v39);
			return;
		end;
	end);
	v15.OnClientEvent:Connect(function(...)
		v17:Notify(...);
	end);
	local l_Poll_0 = l_PlayerGui_0:WaitForChild("TopUI").Frame.Poll;
	local l_Countdown_0 = l_PlayerGui_0:WaitForChild("TopUI").Frame.Countdown;
	local function v43()
		local v42 = 0;
		if l_Poll_0.Visible then
			v42 = v42 + (l_Poll_0.AbsoluteSize.Y - l_Poll_0.Template.AbsoluteSize.Y);
		end;
		if l_Countdown_0.Visible then
			v42 = v42 + l_Countdown_0.AbsoluteSize.Y;
		end;
		l_PlayerGui_0:WaitForChild("TopNotification").TopNotification.Position = UDim2.fromScale(0.5, 0.20) + UDim2.fromOffset(0, v42);
	end;
	l_GuiService_0:GetPropertyChangedSignal("TopbarInset"):Connect(v43);
	l_Countdown_0:GetPropertyChangedSignal("AbsoluteSize"):Connect(v43);
	l_Countdown_0:GetPropertyChangedSignal("Visible"):Connect(v43);
	l_Poll_0:GetPropertyChangedSignal("AbsoluteSize"):Connect(v43);
	l_Poll_0:GetPropertyChangedSignal("Visible"):Connect(v43);
	v43();
end;
return v17;