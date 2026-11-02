
--!nolint
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
				if u2.camlock == nil then
					if u2.stunned == false then
						if p7.Parent ~= v6 then
							l__Humanoid__3:EquipTool(p7);
							return;
						end;
						l__Humanoid__3:UnequipTools();
					end;
				end;
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
		for v17, v18 in p8:WaitForChild("Animations", 1)() do
			if v18:IsA("Animation") then
				u4[v18.Name] = l__Humanoid__3:LoadAnimation(v18);
			end;
		end;
		if p8:FindFirstChild("ToolModule") == nil then
			playAnim(u4.idle, 0.4, 1, 1);
			playAnim(u4.equip, 0.05, 1, 1);
		elseif u5() == "mobile" and p8:GetAttribute("Interactable") then
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
		local l__ToolModule__19 = p8:WaitForChild("ToolModule", 1);
		if l__ToolModule__19 then
			if u8[p8] then
				local v20 = u8[p8];
			else
				u8[p8] = require(l__ToolModule__19);
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
		for v21, v22 in pairs(u4) do
			stopAnim(v22, 0);
		end;
	end;
	u2.update();
end);
local u10 = { v12.One, v12.Two, v12.Three, v12.Four, v12.Five, v12.Six, v12.Seven, v12.Eight, v12.Nine, v12.Zero };
local u11 = v12;
function create()
	l__Hotbar__7.Visible = true;
	local v23 = #u10;
	local v24 = 1 - 1;
	while true do
		local v25 = u10[v24];
		local v26 = l__Template__8:Clone();
		v26.Parent = l__Hotbar__7;
		v26.SlotNum.Text = v25.txt;
		v26.Name = v25.txt;
		v26.Visible = false;
		v26.UIStroke.Transparency = 0.7;
		local l__tool__27 = v25.tool;
		if l__tool__27 then
			v26.Tool.Image = l__tool__27.TextureId;
			v26.Visible = true;
		end;
		v26.MouseButton1Down:Connect(function()
			local v28, v29, v30 = pairs(u11);
			while true do
				local v31, v32 = v28(v29, v30);
				if v31 then

				else
					break;
				end;
				v30 = v31;
				if v32.txt == v26.Name then
					handleEquip(v32.tool);
				end;			
			end;
		end);
		if 0 <= 1 then
			if v24 < v23 then

			else
				break;
			end;
		elseif v23 < v24 then

		else
			break;
		end;
		v24 = v24 + 1;	
	end;
	l__Template__8:Destroy();
end;
local l__Backpack__12 = l__LocalPlayer__5.Backpack;
function setup()
	local v33 = l__Backpack__12:GetChildren();
	local v34 = #v33;
	local v35 = 1 - 1;
	while true do
		if v33[v35]:IsA("Tool") then
			local v36 = #u10;
			local v37 = 1 - 1;
			while true do
				local v38 = u10[v37];
				if not v38.tool then
					v38.tool = v33[v37];
					break;
				end;
				if 0 <= 1 then
					if v37 < v36 then

					else
						break;
					end;
				elseif v36 < v37 then

				else
					break;
				end;
				v37 = v37 + 1;			
			end;
		end;
		if 0 <= 1 then
			if v35 < v34 then

			else
				break;
			end;
		elseif v34 < v35 then

		else
			break;
		end;
		v35 = v35 + 1;	
	end;
	create();
end;
local u13 = {};
function adjust()
	local v39 = {};
	local v40, v41, v42 = pairs(u13);
	while true do
		local v43, v44 = v40(v41, v42);
		if v43 then

		else
			break;
		end;
		v42 = v43;
		pcall(function()
			v44:Disconnect();
		end);	
	end;
	u13 = {};
	local v45 = 0;
	local v46, v47, v48 = pairs(u10);
	while true do
		local v49, v50 = v46(v47, v48);
		if v49 then

		else
			break;
		end;
		v48 = v49;
		if v50.tool then
			v45 = v45 + 1;
			table.insert(v39, v50.tool);
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
	local v51 = { u11.One, u11.Two, u11.Three, u11.Four, u11.Five, u11.Six, u11.Seven, u11.Eight, u11.Nine, u11.Zero };
	local v52, v53, v54 = pairs(v39);
	while true do
		local v55, v56 = v52(v53, v54);
		if v55 then

		else
			break;
		end;
		v54 = v55;
		v51[v55].tool = v56;	
	end;
	u10 = v51;
	local v57, v58, v59 = pairs(u11);
	while true do
		local v60, v61 = v57(v58, v59);
		if v60 then

		else
			break;
		end;
		local l__tool__62 = v61.tool;
		local v63 = l__Hotbar__7:FindFirstChild(v61.txt);
		if l__tool__62 then
			if v63 then
				v63.Tool.Image = l__tool__62.TextureId;
				if l__tool__62.Parent == v6 then
					v63.UIStroke.Transparency = 0;
					v63:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Back", 0.3, true);
				else
					v63.UIStroke.Transparency = 0.7;
					v63:TweenSize(UDim2.new(0.8, 0, 0.8, 0), "Out", "Quad", 0.15, true);
				end;
				local v64 = l__tool__62:GetAttribute("Durability");
				local v65 = l__tool__62:GetAttribute("DurabilityMax");
				v63.DurabilityNumber.Visible = false;
				v63.Durability.Visible = false;
				if v64 then
					if v65 then
						if v65 <= 10 then
							v63.DurabilityNumber.Text = "x" .. v64;
							v63.DurabilityNumber.Visible = true;
						else
							v63.Durability.Bar.Size = UDim2.new(v64 / v65, 0, 1, 0);
							v63.Durability.Visible = true;
						end;
						local u14 = v64;
						u13[v60] = l__tool__62:GetAttributeChangedSignal("Durability"):Connect(function()
							u14 = l__tool__62:GetAttribute("Durability");
							v63.DurabilityNumber.Text = "x" .. u14;
							v63.Durability.Bar:TweenSize(UDim2.new(u14 / v65, 0, 1, 0), "InOut", "Quad", 0.5, true);
						end);
					end;
				end;
				v63.Visible = true;
			elseif v63 then
				v63.Tool.Image = "";
				v63.UIStroke.Transparency = 0.7;
				v63.Visible = false;
				v63.DurabilityNumber.Visible = false;
				v63.Durability.Visible = false;
			end;
		elseif v63 then
			v63.Tool.Image = "";
			v63.UIStroke.Transparency = 0.7;
			v63.Visible = false;
			v63.DurabilityNumber.Visible = false;
			v63.Durability.Visible = false;
		end;	
	end;
end;
local u15 = v9;
local u16 = 1;
function onKeyPress(p12, p13)
	if l__UserInputService__3:GetFocusedTextBox() == nil then
		local v66 = u11[p12.KeyCode.Name];
		if v66 then
			u15 = tick() + 0.2;
			handleEquip(v66.tool);
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
					local v67 = 0;
					local v68 = #u10;
					local v69 = 1 - 1;
					while true do
						if u10[v69].tool then
							v67 = v67 + 1;
						end;
						if 0 <= 1 then
							if v69 < v68 then

							else
								break;
							end;
						elseif v68 < v69 then

						else
							break;
						end;
						v69 = v69 + 1;					
					end;
					local v70 = 1;
					if p12.KeyCode == Enum.KeyCode.ButtonL1 then
						v70 = -1;
					end;
					local v71 = u16 + v70;
					if v71 <= 0 then
						v71 = v67;
					elseif v67 < v71 then
						v71 = 1;
					end;
					u16 = v71;
					local v72 = #u10;
					local v73 = 1 - 1;
					while true do
						if u16 <= v73 then
							if u10[v73].tool then
								handleEquip(u10[v73].tool);
								return;
							end;
						end;
						if 0 <= 1 then
							if v73 < v72 then

							else
								break;
							end;
						elseif v72 < v73 then

						else
							break;
						end;
						v73 = v73 + 1;					
					end;
				end;
			else
				v67 = 0;
				v68 = #u10;
				v69 = 1 - 1;
				while true do
					if u10[v69].tool then
						v67 = v67 + 1;
					end;
					if 0 <= 1 then
						if v69 < v68 then

						else
							break;
						end;
					elseif v68 < v69 then

					else
						break;
					end;
					v69 = v69 + 1;				
				end;
				v70 = 1;
				if p12.KeyCode == Enum.KeyCode.ButtonL1 then
					v70 = -1;
				end;
				v71 = u16 + v70;
				if v71 <= 0 then
					v71 = v67;
				elseif v67 < v71 then
					v71 = 1;
				end;
				u16 = v71;
				v72 = #u10;
				v73 = 1 - 1;
				while true do
					if u16 <= v73 then
						if u10[v73].tool then
							handleEquip(u10[v73].tool);
							return;
						end;
					end;
					if 0 <= 1 then
						if v73 < v72 then

						else
							break;
						end;
					elseif v72 < v73 then

					else
						break;
					end;
					v73 = v73 + 1;				
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
		local v74 = true;
		local v75, v76, v77 = pairs(u11);
		while true do
			local v78, v79 = v75(v76, v77);
			if v78 then

			else
				break;
			end;
			v77 = v78;
			local l__tool__80 = v79.tool;
			if l__tool__80 then
				if l__tool__80 == p14 then
					v74 = false;
				end;
			end;		
		end;
		if v74 then
			local v81 = #u10;
			local v82 = 1 - 1;
			while true do
				if not u10[v82].tool then
					u10[v82].tool = p14;
					break;
				end;
				if 0 <= 1 then
					if v82 < v81 then

					else
						break;
					end;
				elseif v81 < v82 then

				else
					break;
				end;
				v82 = v82 + 1;			
			end;
		end;
		adjust();
	end;
end;
function handleRemoval(p15)
	if p15:IsA("Tool") then
		if p15.Parent ~= v6 then
			if p15.Parent ~= l__Backpack__12 then
				local v83 = #u10;
				local v84 = 1 - 1;
				while true do
					if u10[v84].tool == p15 then
						u10[v84].tool = nil;
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
		end;
		adjust();
	end;
end;
l__UserInputService__3.InputBegan:Connect(onKeyPress);
v6.ChildAdded:Connect(handleAddition);
v6.ChildRemoved:Connect(handleRemoval);
l__Backpack__12.ChildAdded:Connect(handleAddition);
l__Backpack__12.ChildRemoved:Connect(handleRemoval);
setup();
u2.ce.ToggleInventory.Event:Connect(function(p16)
	u1 = p16;
	if u1 == true then
		l__Hotbar__7:TweenPosition(UDim2.new(0.5, 0, 1, -10), "InOut", "Quad", 1, true);
		return;
	end;
	l__Hotbar__7:TweenPosition(UDim2.new(0.5, 0, 2, 0), "InOut", "Quad", 1, true);
	l__Humanoid__3:UnequipTools();
end);
