-- Decompiled with the Synapse X Luau decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local u1 = require(l__ReplicatedStorage__1.Packages.Fusion);
local u2 = require(l__ReplicatedStorage__1.GiftInbox.Gift);
return function(p1)
	return u1.New("ScrollingFrame")({
		Size = UDim2.fromScale(1, 1), 
		AutomaticCanvasSize = Enum.AutomaticSize.Y, 
		CanvasSize = UDim2.new(), 
		ScrollingDirection = Enum.ScrollingDirection.Y, 
		ScrollBarThickness = 8, 
		BackgroundTransparency = 1, 
		ScrollBarImageColor3 = Color3.fromRGB(197, 197, 197), 
		[u1.Children] = { u1.New("UIListLayout")({
				Padding = UDim.new(0, 10)
			}), u1.New("UIPadding")({
				PaddingLeft = UDim.new(0.05, 0), 
				PaddingRight = UDim.new(0.05, 0)
			}), u1.ComputedPairs(p1.gifts, function(p2, p3)
				local v2 = table.clone(p3);
				v2.layoutOrder = p2;
				return u2(v2);
			end) }
	});
end;
