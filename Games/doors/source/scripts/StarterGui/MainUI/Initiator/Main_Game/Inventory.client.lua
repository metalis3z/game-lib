-- Decompiled with the Synapse X Luau decompiler.

game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
local v1 = script:FindFirstAncestor("MainUI");
local l__LocalPlayer__2 = game.Players.LocalPlayer;
local l__UserInputService__3 = game:GetService("UserInputService");
local l__TweenService__4 = game:GetService("TweenService");
local l__LocalPlayer__5 = game.Players.LocalPlayer;
local v6 = workspace:WaitForChild(l__LocalPlayer__5.Name);
local l__Hotbar__7 = v1.MainFrame.Hotbar;
local l__Template__8 = l__Hotbar__7.Template;
local v9 = tick();
function playAnim(p1, p2, p3, p4)
	pcall(function()
		print(p1.Priority)
		p1:Play(p2, p3, p4);
	end);
end;
function stopAnim(p5, p6)
	pcall(function()
		p5:Stop(p6);
	end);
end;
local l__Size__10 = l__Template__8.Size;
local v11 = {
	x = 15, 
	y = 5
};
local v12 = {
	One = {
		txt = "1"
	}, 
	Two = {
		txt = "2"
	}, 
	Three = {
		txt = "3"
	}, 
	Four = {
		txt = "4"
	}, 
	Five = {
		txt = "5"
	}, 
	Six = {
		txt = "6"
	}, 
	Seven = {
		txt = "7"
	}, 
	Eight = {
		txt = "8"
	}, 
	Nine = {
		txt = "9"
	}, 
	Zero = {
		txt = "0"
	}
};
({ "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine" })[0] = "Ten";
local u1 = true;
local u2 = require(script.Parent);
local l__Humanoid__3 = v6:WaitForChild("Humanoid");
function handleEquip(p7)
	if p7 then
		if u1 then
			if u2.stopcam == false then
				if v6:GetAttribute("Hiding") == false then
					if u2.camlock == nil then
						if u2.stunned == false then
							if p7.Parent ~= v6 then
								l__Humanoid__3:EquipTool(p7);
								return;
							end;
							l__Humanoid__3:UnequipTools();
						end;
					end;
				else
					l__Humanoid__3:UnequipTools();
				end
			end;
		end;
	end;
end;
local u4 = {
	idle = nil, 
	fire = nil, 
	equip = nil
};
local u5 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientModules"):WaitForChild("GetPlatform"));
local l__ToolButton__6 = v1.MainFrame:WaitForChild("MobileButtons"):WaitForChild("ToolButton");
local u7 = require(script.Icons);
local u8 = {};

v6.ChildAdded:connect(function(p8)
	u2.update();
	if p8:IsA("Tool") then
		
		for v13, v14 in pairs(v6:GetChildren()) do
			if v14:IsA("Tool") and v14 ~= p8 then
				v14.Parent = l__LocalPlayer__5.Backpack;
			end;
		end;
		
		for v15, v16 in pairs(u4) do
			stopAnim(v16, 0);
		end;
		u4 = {};
		for v17, v18 in pairs (p8:WaitForChild("Animations"):GetChildren()) do
			if v18:IsA("Animation") then
				u4[v18.Name] = l__Humanoid__3:LoadAnimation(v18);
			end;
		end;
		local v19, v20 = u5();
		if p8:FindFirstChild("ToolModule") == nil then
			if p8.Name == "Lighter" then
				print(p8)
			else
				if not p8:FindFirstChild("ToolModule") then
					playAnim(u4.idle, 0.4, 1, 1);
					playAnim(u4.equip, 0.05, 1, 1);
				end
			end
		end;
		
		if v20 == "mobile" and p8:GetAttribute("Interactable") then
			l__ToolButton__6.Icon.Image = u7(p8.Name);
			l__ToolButton__6.Visible = true;
		end;
		
		u2.tool = p8;
		u2.update();
		if p8:GetAttribute("ToolOffset") then
			u2.tooloffset = p8:GetAttribute("ToolOffset");
		else
			u2.tooloffset = Vector3.new(0, 0, 0);
		end;
		local l__ToolModule__21 = p8:WaitForChild("ToolModule", 1);
		if l__ToolModule__21 then
			if u8[p8] then
				local v22 = u8[p8];
			else
				u8[p8] = require(l__ToolModule__21);
			end;
			task.spawn(function()

			end);
			local u9 = nil;
			u9 = p8.AncestryChanged:Connect(function(p9, p10)
				if p10 ~= v6 then
					u9:Disconnect();
				end;
			end);
		end;
	end;
end);
v6.ChildRemoved:connect(function(p11)
	if p11:IsA("Tool") and v6:FindFirstChildOfClass("Tool") == nil then
		u2.tool = nil;
		l__ToolButton__6.Visible = false;
		for v23, v24 in pairs(u4) do
			playAnim(v24, 0);
			stopAnim(v24, 0);
		end;
	end;
	u2.update();
end);
local u10 = { v12.One, v12.Two, v12.Three, v12.Four, v12.Five, v12.Six, v12.Seven, v12.Eight, v12.Nine, v12.Zero };
local u11 = v12;
function create()
	l__Hotbar__7.Visible = true;
	local v25 = #u10;
	for v26 = 1, v25 do
		local v27 = u10[v26];
		local v28 = l__Template__8:Clone();
		v28.Parent = l__Hotbar__7;
		v28.SlotNum.Text = v27.txt;
		v28.Name = v27.txt;
		v28.Visible = false;
		v28.UIStroke.Transparency = 0.7;
		local l__tool__29 = v27.tool;
		
		if l__tool__29 then
			v28.Tool.Image = l__tool__29.TextureId;
			v28.Visible = true;
		end;
		
		v28.MouseButton1Down:Connect(function()
			for v30, v34 in pairs(u11) do
				if v34.txt == v28.Name then
					handleEquip(v34.tool);
				end;			
			end;
		end);
		
		if 0 <= 1 then
			if v26 < v25 then

			else
				break;
			end;
		elseif v25 < v26 then

		else
			break;
		end;
		v26 = v26 + 1;	
	end;
	l__Template__8:Destroy();
end;
local l__Backpack__12 = l__LocalPlayer__5.Backpack;
function setup()
	local v35 = l__Backpack__12:GetChildren();
	local v36 = #v35;
	for i = 1, v36 do
		if v35[i]:IsA("Tool") then
			local v38 = #u10;
			for v39 = 1, v38 do
				local v40 = u10[v39];
				if not v40.tool then
					v40.tool = v35[v39];
					break;
				end;
			end;
		end;
	end;
	create();
end;
local u13 = {};
function adjust()
	local v41 = {};
	for v42, v46 in pairs(u13) do
		pcall(function()
			v46:Disconnect();
		end);	
	end;
	u13 = {};
	local v47 = 0;
	for v48, v52 in pairs(u10) do
		if v52.tool then
			v47 = v47 + 1;
			table.insert(v41, v52.tool);
		end;	
	end;
	u11 = {
		One = {
			txt = "1"
		}, 
		Two = {
			txt = "2"
		}, 
		Three = {
			txt = "3"
		}, 
		Four = {
			txt = "4"
		}, 
		Five = {
			txt = "5"
		}, 
		Six = {
			txt = "6"
		}, 
		Seven = {
			txt = "7"
		}, 
		Eight = {
			txt = "8"
		}, 
		Nine = {
			txt = "9"
		}, 
		Zero = {
			txt = "0"
		}
	};
	local v53 = { u11.One, u11.Two, u11.Three, u11.Four, u11.Five, u11.Six, u11.Seven, u11.Eight, u11.Nine, u11.Zero };
	for v57, v58 in pairs(v41) do
		v53[v57].tool = v58;	
	end;
	u10 = v53;
	for v62, v63 in pairs(u11) do
		local l__tool__64 = v63.tool;
		local v65 = l__Hotbar__7:FindFirstChild(v63.txt);
		if l__tool__64 then
			if v65 then
				v65.Tool.Image = l__tool__64.TextureId;
				if l__tool__64.Parent == v6 then
					v65.UIStroke.Transparency = 0;
					v65:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Back", 0.3, true);
				else
					v65.UIStroke.Transparency = 0.7;
					v65:TweenSize(UDim2.new(0.8, 0, 0.8, 0), "Out", "Quad", 0.15, true);
				end;
				local v66 = l__tool__64:GetAttribute("Durability");
				local v67 = l__tool__64:GetAttribute("DurabilityMax");
				
				v65.DurabilityNumber.Visible = false;
				v65.Durability.Visible = false;
				
				if v66 then
					if v67 then
						if v67 <= 6 then
							v65.DurabilityNumber.Text = "x" .. v66;
							v65.DurabilityNumber.Visible = true;
						else
							v65.Durability.Bar.Size = UDim2.new(v66 / v67, 0, 1, 0);
							v65.Durability.Visible = true;
						end;
						local u14 = v66;
						u13[v62] = l__tool__64:GetAttributeChangedSignal("Durability"):Connect(function()
							u14 = l__tool__64:GetAttribute("Durability");
							v65.DurabilityNumber.Text = "x" .. u14;
							v65.Durability.Bar:TweenSize(UDim2.new(u14 / v67, 0, 1, 0), "InOut", "Quad", 0.5, true);
						end);
					end;
				end;
				v65.Visible = true;
			elseif v65 then
				v65.Tool.Image = "";
				v65.UIStroke.Transparency = 0.7;
				v65.Visible = false;
				v65.DurabilityNumber.Visible = false;
				v65.Durability.Visible = false;
			end;
		elseif v65 then
			v65.Tool.Image = "";
			v65.UIStroke.Transparency = 0.7;
			v65.Visible = false;
			v65.DurabilityNumber.Visible = false;
			v65.Durability.Visible = false;
		end;	
	end;
end;
local u15 = v9;
local u16 = 1;
function onKeyPress(p12, p13)
	if l__UserInputService__3:GetFocusedTextBox() == nil then
		local v68 = u11[p12.KeyCode.Name];
		if v68 then
			u15 = tick() + 0.2;
			handleEquip(v68.tool);
			return;
		end;
		if p12.UserInputType ~= Enum.UserInputType.MouseButton1 then
			if p12.KeyCode == Enum.KeyCode.ButtonR2 then
				if u2.tool ~= nil then
					if u8[u2.tool] then
						u8[u2.tool].fire();
						return;
					end;
				end;
			elseif p12.KeyCode ~= Enum.KeyCode.ButtonL1 then
				if p12.KeyCode == Enum.KeyCode.ButtonR1 then
					local v69 = 0;
					local v70 = #u10;
					for v71 = 1, v70 do
						if u10[v71].tool then
							v69 = v69 + 1;
						end;
					end;
					local v72 = 1;
					if p12.KeyCode == Enum.KeyCode.ButtonL1 then
						v72 = -1;
					end;
					local v73 = u16 + v72;
					if v73 <= 0 then
						v73 = v69;
					elseif v69 < v73 then
						v73 = 0;
					end;
					u16 = v73;
					local v74 = #u10;
					for v75 = 1, v74 do
						if u16 <= v75 then
							if u10[v75].tool then
								handleEquip(u10[v75].tool);
								return;
							end;
						end;				
					end;
				end;
			else
				v69 = 0;
				v70 = #u10;
				for v71 = 1, v70 do
					if u10[v71].tool then
						v69 = v69 + 1;
					end;		
				end;
				v72 = 1;
				if p12.KeyCode == Enum.KeyCode.ButtonL1 then
					v72 = -1;
				end;
				v73 = u16 + v72;
				if v73 <= 0 then
					v73 = v69;
				elseif v69 < v73 then
					v73 = 0;
				end;
				u16 = v73;
				v74 = #u10;
				for v75 = 1, v74 do
					if u16 <= v75 then
						if u10[v75].tool then
							handleEquip(u10[v75].tool);
							return;
						end;
					end;
				end;
			end;
		elseif u2.tool ~= nil then
			if u8[u2.tool] then
				u8[u2.tool].fire();
				return;
			end;
		end;
	end;
end;
l__ToolButton__6.MouseButton1Down:Connect(function()
	if u2.tool ~= nil and u8[u2.tool] then
		u8[u2.tool].fire();
	end;
end);
function handleAddition(p14)
	if p14:IsA("Tool") then
		local v76 = true;
		for v77, v81 in pairs(u11) do
			local l__tool__82 = v81.tool;
			if l__tool__82 then
				if l__tool__82 == p14 then
					v76 = false;
				end;
			end;		
		end;
		if v76 then
			local v83 = #u10;
			for v84 = 1, v83 do
				if not u10[v84].tool then
					u10[v84].tool = p14;
					break;
				end;
				if 0 <= 1 then
					if v84 < v83 then

					else
						break;
					end;
				elseif v83 < v84 then

				else
					break;
				end;
				v84 = v84 + 1;			
			end;
		end;
		adjust();
	end;
end;
function handleRemoval(p15)
	if p15:IsA("Tool") then
		if p15.Parent ~= v6 then
			if p15.Parent ~= l__Backpack__12 then
				local v85 = #u10;
				for v86 = 1, v85 do
					if u10[v86].tool == p15 then
						u10[v86].tool = nil;
						break;
					end;	
				end;
			end;
		end;
		adjust();
	end;
end;
adjust()
l__UserInputService__3.InputBegan:Connect(onKeyPress);
v6.ChildAdded:Connect(handleAddition);
v6.ChildRemoved:Connect(handleRemoval);
l__Backpack__12.ChildAdded:Connect(handleAddition);
l__Backpack__12.ChildRemoved:Connect(handleRemoval);
setup();