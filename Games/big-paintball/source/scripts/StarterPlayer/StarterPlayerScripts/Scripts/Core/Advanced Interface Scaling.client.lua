-- OneX Was Here

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local u1 = {};
function ScaleElement(p1)
	if p1 then
		if p1.Parent then
			if not u1[p1] then
				return;
			end;
		else
			return;
		end;
	else
		return;
	end;
	local v2 = u1[p1];
	local v3 = 1 - (1 - (v1.Variables.ResolutionScale and 1)) * 0.65;
	if p1.ClassName == "UIStroke" then
		p1.Thickness = v2 * v3;
		return true;
	end;
	if p1.ClassName ~= "ImageLabel" then
		if p1.ClassName == "ImageButton" then
			if p1.ScaleType == Enum.ScaleType.Slice then
				p1.SliceScale = v2 * v3;
				return true;
			end;
		end;
	elseif p1.ScaleType == Enum.ScaleType.Slice then
		p1.SliceScale = v2 * v3;
		return true;
	end;
	if p1.ClassName == "UIPadding" then

	elseif p1.ClassName == "UIListLayout" then
		p1.Padding = UDim.new(p1.Padding.Scale, v2.Offset * v3);
		return true;
	elseif p1.ClassName == "UIGridLayout" then
		p1.CellPadding = UDim2.new(p1.CellPadding.X.Scale, v2.X.Scale * v3, p1.CellPadding.Y.Scale, v2.Y.Offset * v3);
		return true;
	else
		return;
	end;
	p1.PaddingTop = UDim.new(p1.PaddingTop.Scale, v2.PaddingTop.Offset * v3);
	p1.PaddingBottom = UDim.new(p1.PaddingBottom.Scale, v2.PaddingBottom.Offset * v3);
	p1.PaddingLeft = UDim.new(p1.PaddingLeft.Scale, v2.PaddingLeft.Offset * v3);
	p1.PaddingRight = UDim.new(p1.PaddingRight.Scale, v2.PaddingRight.Offset * v3);
	return true;
end;
function ScaleAll()
	local v4 = 0;
	for v5, v6 in pairs(u1) do
		if (v4 + 1) % 100 == 0 then
			v1.RenderStepped();
		end;
		if not ScaleElement(v5) then
			u1[v5] = nil;
		end;	
	end;
end;
local l__Scale9Slice__2 = v1.Settings.Scale9Slice;
local l__ScaleStrokes__3 = v1.Settings.ScaleStrokes;
local l__ScalePadding__4 = v1.Settings.ScalePadding;
local l__ScaleLists__5 = v1.Settings.ScaleLists;
local l__ScaleGrids__6 = v1.Settings.ScaleGrids;
function AddUIElement(p2)
	if u1[p2] then
		return;
	end;
	if l__Scale9Slice__2 then
		if p2.ClassName == "UIStroke" then
			u1[p2] = p2.Thickness;
		elseif l__ScaleStrokes__3 then
			if p2.ClassName ~= "ImageLabel" then
				if p2.ClassName == "ImageButton" then
					if p2.ScaleType == Enum.ScaleType.Slice then
						u1[p2] = p2.SliceScale;
					elseif l__ScalePadding__4 then
						if p2.ClassName == "UIPadding" then
							u1[p2] = {
								PaddingTop = p2.PaddingTop, 
								PaddingBottom = p2.PaddingBottom, 
								PaddingLeft = p2.PaddingLeft, 
								PaddingRight = p2.PaddingRight
							};
						elseif l__ScaleLists__5 then
							if p2.ClassName == "UIListLayout" then
								u1[p2] = p2.Padding;
							elseif l__ScaleGrids__6 then
								if p2.ClassName == "UIGridLayout" then
									u1[p2] = p2.CellPadding;
								end;
							end;
						elseif l__ScaleGrids__6 then
							if p2.ClassName == "UIGridLayout" then
								u1[p2] = p2.CellPadding;
							end;
						end;
					elseif l__ScaleLists__5 then
						if p2.ClassName == "UIListLayout" then
							u1[p2] = p2.Padding;
						elseif l__ScaleGrids__6 then
							if p2.ClassName == "UIGridLayout" then
								u1[p2] = p2.CellPadding;
							end;
						end;
					elseif l__ScaleGrids__6 then
						if p2.ClassName == "UIGridLayout" then
							u1[p2] = p2.CellPadding;
						end;
					end;
				elseif l__ScalePadding__4 then
					if p2.ClassName == "UIPadding" then
						u1[p2] = {
							PaddingTop = p2.PaddingTop, 
							PaddingBottom = p2.PaddingBottom, 
							PaddingLeft = p2.PaddingLeft, 
							PaddingRight = p2.PaddingRight
						};
					elseif l__ScaleLists__5 then
						if p2.ClassName == "UIListLayout" then
							u1[p2] = p2.Padding;
						elseif l__ScaleGrids__6 then
							if p2.ClassName == "UIGridLayout" then
								u1[p2] = p2.CellPadding;
							end;
						end;
					elseif l__ScaleGrids__6 then
						if p2.ClassName == "UIGridLayout" then
							u1[p2] = p2.CellPadding;
						end;
					end;
				elseif l__ScaleLists__5 then
					if p2.ClassName == "UIListLayout" then
						u1[p2] = p2.Padding;
					elseif l__ScaleGrids__6 then
						if p2.ClassName == "UIGridLayout" then
							u1[p2] = p2.CellPadding;
						end;
					end;
				elseif l__ScaleGrids__6 then
					if p2.ClassName == "UIGridLayout" then
						u1[p2] = p2.CellPadding;
					end;
				end;
			elseif p2.ScaleType == Enum.ScaleType.Slice then
				u1[p2] = p2.SliceScale;
			elseif l__ScalePadding__4 then
				if p2.ClassName == "UIPadding" then
					u1[p2] = {
						PaddingTop = p2.PaddingTop, 
						PaddingBottom = p2.PaddingBottom, 
						PaddingLeft = p2.PaddingLeft, 
						PaddingRight = p2.PaddingRight
					};
				elseif l__ScaleLists__5 then
					if p2.ClassName == "UIListLayout" then
						u1[p2] = p2.Padding;
					elseif l__ScaleGrids__6 then
						if p2.ClassName == "UIGridLayout" then
							u1[p2] = p2.CellPadding;
						end;
					end;
				elseif l__ScaleGrids__6 then
					if p2.ClassName == "UIGridLayout" then
						u1[p2] = p2.CellPadding;
					end;
				end;
			elseif l__ScaleLists__5 then
				if p2.ClassName == "UIListLayout" then
					u1[p2] = p2.Padding;
				elseif l__ScaleGrids__6 then
					if p2.ClassName == "UIGridLayout" then
						u1[p2] = p2.CellPadding;
					end;
				end;
			elseif l__ScaleGrids__6 then
				if p2.ClassName == "UIGridLayout" then
					u1[p2] = p2.CellPadding;
				end;
			end;
		elseif l__ScalePadding__4 then
			if p2.ClassName == "UIPadding" then
				u1[p2] = {
					PaddingTop = p2.PaddingTop, 
					PaddingBottom = p2.PaddingBottom, 
					PaddingLeft = p2.PaddingLeft, 
					PaddingRight = p2.PaddingRight
				};
			elseif l__ScaleLists__5 then
				if p2.ClassName == "UIListLayout" then
					u1[p2] = p2.Padding;
				elseif l__ScaleGrids__6 then
					if p2.ClassName == "UIGridLayout" then
						u1[p2] = p2.CellPadding;
					end;
				end;
			elseif l__ScaleGrids__6 then
				if p2.ClassName == "UIGridLayout" then
					u1[p2] = p2.CellPadding;
				end;
			end;
		elseif l__ScaleLists__5 then
			if p2.ClassName == "UIListLayout" then
				u1[p2] = p2.Padding;
			elseif l__ScaleGrids__6 then
				if p2.ClassName == "UIGridLayout" then
					u1[p2] = p2.CellPadding;
				end;
			end;
		elseif l__ScaleGrids__6 then
			if p2.ClassName == "UIGridLayout" then
				u1[p2] = p2.CellPadding;
			end;
		end;
	elseif l__ScaleStrokes__3 then
		if p2.ClassName ~= "ImageLabel" then
			if p2.ClassName == "ImageButton" then
				if p2.ScaleType == Enum.ScaleType.Slice then
					u1[p2] = p2.SliceScale;
				elseif l__ScalePadding__4 then
					if p2.ClassName == "UIPadding" then
						u1[p2] = {
							PaddingTop = p2.PaddingTop, 
							PaddingBottom = p2.PaddingBottom, 
							PaddingLeft = p2.PaddingLeft, 
							PaddingRight = p2.PaddingRight
						};
					elseif l__ScaleLists__5 then
						if p2.ClassName == "UIListLayout" then
							u1[p2] = p2.Padding;
						elseif l__ScaleGrids__6 then
							if p2.ClassName == "UIGridLayout" then
								u1[p2] = p2.CellPadding;
							end;
						end;
					elseif l__ScaleGrids__6 then
						if p2.ClassName == "UIGridLayout" then
							u1[p2] = p2.CellPadding;
						end;
					end;
				elseif l__ScaleLists__5 then
					if p2.ClassName == "UIListLayout" then
						u1[p2] = p2.Padding;
					elseif l__ScaleGrids__6 then
						if p2.ClassName == "UIGridLayout" then
							u1[p2] = p2.CellPadding;
						end;
					end;
				elseif l__ScaleGrids__6 then
					if p2.ClassName == "UIGridLayout" then
						u1[p2] = p2.CellPadding;
					end;
				end;
			elseif l__ScalePadding__4 then
				if p2.ClassName == "UIPadding" then
					u1[p2] = {
						PaddingTop = p2.PaddingTop, 
						PaddingBottom = p2.PaddingBottom, 
						PaddingLeft = p2.PaddingLeft, 
						PaddingRight = p2.PaddingRight
					};
				elseif l__ScaleLists__5 then
					if p2.ClassName == "UIListLayout" then
						u1[p2] = p2.Padding;
					elseif l__ScaleGrids__6 then
						if p2.ClassName == "UIGridLayout" then
							u1[p2] = p2.CellPadding;
						end;
					end;
				elseif l__ScaleGrids__6 then
					if p2.ClassName == "UIGridLayout" then
						u1[p2] = p2.CellPadding;
					end;
				end;
			elseif l__ScaleLists__5 then
				if p2.ClassName == "UIListLayout" then
					u1[p2] = p2.Padding;
				elseif l__ScaleGrids__6 then
					if p2.ClassName == "UIGridLayout" then
						u1[p2] = p2.CellPadding;
					end;
				end;
			elseif l__ScaleGrids__6 then
				if p2.ClassName == "UIGridLayout" then
					u1[p2] = p2.CellPadding;
				end;
			end;
		elseif p2.ScaleType == Enum.ScaleType.Slice then
			u1[p2] = p2.SliceScale;
		elseif l__ScalePadding__4 then
			if p2.ClassName == "UIPadding" then
				u1[p2] = {
					PaddingTop = p2.PaddingTop, 
					PaddingBottom = p2.PaddingBottom, 
					PaddingLeft = p2.PaddingLeft, 
					PaddingRight = p2.PaddingRight
				};
			elseif l__ScaleLists__5 then
				if p2.ClassName == "UIListLayout" then
					u1[p2] = p2.Padding;
				elseif l__ScaleGrids__6 then
					if p2.ClassName == "UIGridLayout" then
						u1[p2] = p2.CellPadding;
					end;
				end;
			elseif l__ScaleGrids__6 then
				if p2.ClassName == "UIGridLayout" then
					u1[p2] = p2.CellPadding;
				end;
			end;
		elseif l__ScaleLists__5 then
			if p2.ClassName == "UIListLayout" then
				u1[p2] = p2.Padding;
			elseif l__ScaleGrids__6 then
				if p2.ClassName == "UIGridLayout" then
					u1[p2] = p2.CellPadding;
				end;
			end;
		elseif l__ScaleGrids__6 then
			if p2.ClassName == "UIGridLayout" then
				u1[p2] = p2.CellPadding;
			end;
		end;
	elseif l__ScalePadding__4 then
		if p2.ClassName == "UIPadding" then
			u1[p2] = {
				PaddingTop = p2.PaddingTop, 
				PaddingBottom = p2.PaddingBottom, 
				PaddingLeft = p2.PaddingLeft, 
				PaddingRight = p2.PaddingRight
			};
		elseif l__ScaleLists__5 then
			if p2.ClassName == "UIListLayout" then
				u1[p2] = p2.Padding;
			elseif l__ScaleGrids__6 then
				if p2.ClassName == "UIGridLayout" then
					u1[p2] = p2.CellPadding;
				end;
			end;
		elseif l__ScaleGrids__6 then
			if p2.ClassName == "UIGridLayout" then
				u1[p2] = p2.CellPadding;
			end;
		end;
	elseif l__ScaleLists__5 then
		if p2.ClassName == "UIListLayout" then
			u1[p2] = p2.Padding;
		elseif l__ScaleGrids__6 then
			if p2.ClassName == "UIGridLayout" then
				u1[p2] = p2.CellPadding;
			end;
		end;
	elseif l__ScaleGrids__6 then
		if p2.ClassName == "UIGridLayout" then
			u1[p2] = p2.CellPadding;
		end;
	end;
	if u1[p2] then
		ScaleElement(p2);
	end;
end;
local u7 = { "Chat", "TouchGui" };
function InitScreen(p3)
	if p3.ClassName ~= "ScreenGui" then
		if p3.ClassName ~= "BillboardGui" then
			if p3.ClassName ~= "SurfaceGui" then
				return;
			end;
		end;
	end;
	if v1.Functions.SearchArray(u7, p3.Name) then
		return;
	end;
	for v10, v11 in ipairs(p3:GetDescendants()) do
		if not v11:IsA("GuiObject") then
			if v11:IsA("UIComponent") then
				AddUIElement(v11);
			end;
		else
			AddUIElement(v11);
		end;	
	end;
	p3.DescendantAdded:Connect(function(p4)
		if not p4:IsA("GuiObject") then
			if p4:IsA("UIComponent") then
				AddUIElement(p4);
			end;
		else
			AddUIElement(p4);
		end;
	end);
end;
local u8 = v1.Player.Get("PlayerGui");
function Init()
	for v13, v14 in ipairs(u8:GetChildren()) do
		coroutine.wrap(function()
			InitScreen(v14);
		end)();	
	end;
	u8.ChildAdded:Connect(function(p5)
		InitScreen(p5);
	end);
end;
Init();
v1.Signal.Fired("Resolution Changed"):Connect(function()
	wait();
	ScaleAll();
end);
