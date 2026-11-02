-- Decompiled with the Synapse X Luau decompiler.

game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
local l__LocalPlayer__1 = game.Players.LocalPlayer;
local v2 = workspace:WaitForChild(l__LocalPlayer__1.Name);
local l__Frame__3 = script.Parent.Frame;
local l__Template__4 = l__Frame__3.Template;
local v5 = {
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
local l__Humanoid__1 = v2:WaitForChild("Humanoid");
function handleEquip(p1)
	if p1 then
		if p1.Parent ~= v2 then

		else
			l__Humanoid__1:UnequipTools();
			return;
		end;
	else
		return;
	end;
	l__Humanoid__1:EquipTool(p1);
end;
local u2 = { v5.One, v5.Two, v5.Three, v5.Four, v5.Five, v5.Six, v5.Seven, v5.Eight, v5.Nine, v5.Zero };
local l__Size__3 = l__Template__4.Size;
local u4 = {
	x = 15, 
	y = 5
};
function create()
	local v6 = #u2;
	local v7 = v6 * l__Size__3.X.Offset + (v6 + 1) * u4.x;
	local v8 = l__Size__3.Y.Offset + 2 * u4.y;
	l__Frame__3.Size = UDim2.new(0, v7, 0, v8);
	l__Frame__3.Position = UDim2.new(0.5, -(v7 / 2), 1, -(v8 + u4.y * 2));
	l__Frame__3.Visible = true;
	local v9 = #u2;
	local v10 = 1 - 1;
	while true do
		local v11 = u2[v10];
		local v12 = l__Template__4:Clone();
		v12.Parent = l__Frame__3;
		v12.Label.Text = v11.txt;
		v12.Name = v11.txt;
		v12.Visible = true;
		v12.Position = UDim2.new(0, (v10 - 1) * l__Size__3.X.Offset + u4.x * v10, 0, u4.y);
		v12.ImageTransparency = 0.7;
		local l__tool__13 = v11.tool;
		if l__tool__13 then
			v12.Tool.Image = l__tool__13.TextureId;
		end;
		v12.Tool.MouseButton1Down:Connect(function()
			local v14, v15, v16 = pairs(v5);
			while true do
				local v17, v18 = v14(v15, v16);
				if v17 then

				else
					break;
				end;
				v16 = v17;
				if v18.txt == v12.Name then
					handleEquip(v18.tool);
				end;			
			end;
		end);
		if 0 <= 1 then
			if v10 < v9 then

			else
				break;
			end;
		elseif v9 < v10 then

		else
			break;
		end;
		v10 = v10 + 1;	
	end;
	l__Template__4:Destroy();
end;
local l__Backpack__5 = l__LocalPlayer__1.Backpack;
function setup()
	local v19 = l__Backpack__5:GetChildren();
	local v20 = #v19;
	local v21 = 1 - 1;
	while true do
		if v19[v21]:IsA("Tool") then
			local v22 = #u2;
			local v23 = 1 - 1;
			while true do
				local v24 = u2[v23];
				if not v24.tool then
					v24.tool = v19[v23];
					break;
				end;
				if 0 <= 1 then
					if v23 < v22 then

					else
						break;
					end;
				elseif v22 < v23 then

				else
					break;
				end;
				v23 = v23 + 1;			
			end;
		end;
		if 0 <= 1 then
			if v21 < v20 then

			else
				break;
			end;
		elseif v20 < v21 then

		else
			break;
		end;
		v21 = v21 + 1;	
	end;
	create();
end;
function adjust()
	local v25, v26, v27 = pairs(v5);
	while true do
		local v28 = nil;
		local v29, v30 = v25(v26, v27);
		if v29 then

		else
			break;
		end;
		v27 = v29;
		local l__tool__31 = v30.tool;
		v28 = l__Frame__3:FindFirstChild(v30.txt);
		if l__tool__31 then
			v28.Tool.Image = l__tool__31.TextureId;
			if l__tool__31.Parent == v2 then
				v28.ImageTransparency = 0.2;
			else
				v28.ImageTransparency = 0.7;
			end;
		else
			v28.Tool.Image = "";
			v28.ImageTransparency = 0.7;
		end;	
	end;
end;
local l__UserInputService__6 = game:GetService("UserInputService");
function onKeyPress(p2)
	local v32 = v5[p2.KeyCode.Name];
	if v32 then
		if l__UserInputService__6:GetFocusedTextBox() == nil then
			handleEquip(v32.tool);
		end;
	end;
end;
function handleAddition(p3)
	if p3:IsA("Tool") then
		local v33 = true;
		local v34, v35, v36 = pairs(v5);
		while true do
			local v37, v38 = v34(v35, v36);
			if v37 then

			else
				break;
			end;
			v36 = v37;
			local l__tool__39 = v38.tool;
			if l__tool__39 then
				if l__tool__39 == p3 then
					v33 = false;
				end;
			end;		
		end;
		if v33 then
			local v40 = #u2;
			local v41 = 1 - 1;
			while true do
				if not u2[v41].tool then
					u2[v41].tool = p3;
					break;
				end;
				if 0 <= 1 then
					if v41 < v40 then

					else
						break;
					end;
				elseif v40 < v41 then

				else
					break;
				end;
				v41 = v41 + 1;			
			end;
		end;
		adjust();
	end;
end;
function handleRemoval(p4)
	if p4:IsA("Tool") then
		if p4.Parent ~= v2 then
			if p4.Parent ~= l__Backpack__5 then
				local v42 = #u2;
				local v43 = 1 - 1;
				while true do
					if u2[v43].tool == p4 then
						u2[v43].tool = nil;
						break;
					end;
					if 0 <= 1 then
						if v43 < v42 then

						else
							break;
						end;
					elseif v42 < v43 then

					else
						break;
					end;
					v43 = v43 + 1;				
				end;
			end;
		end;
		adjust();
	end;
end;
l__UserInputService__6.InputBegan:Connect(onKeyPress);
v2.ChildAdded:Connect(handleAddition);
v2.ChildRemoved:Connect(handleRemoval);
l__Backpack__5.ChildAdded:Connect(handleAddition);
l__Backpack__5.ChildRemoved:Connect(handleRemoval);
setup();
