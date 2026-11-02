local v1 = {}

function v1.AnimateItemIconIntoInventory(p14, p15, p16)
	local v21 = p14:Clone();
	local l__X__22 = p14.AbsoluteSize.X;
	local l__Y__23 = p14.AbsoluteSize.Y;
	v21.Size = UDim2.new(0, l__X__22, 0, l__Y__23);
	v21.BackgroundTransparency = 1;
	v21.Position = UDim2.new(0, p14.AbsolutePosition.X + l__X__22 / 2, 0, p14.AbsolutePosition.Y + l__Y__23 / 2);
	v21.AnchorPoint = Vector2.new(0.5, 0.5);
	v21.ZIndex = 10;
	v21.Parent = p16;
	spawn(function()
		v21:TweenSizeAndPosition(UDim2.new(0, 25, 0, 25), UDim2.new(0, p15.AbsolutePosition.X + p15.AbsoluteSize.X / 2 - 3, 0, p15.AbsolutePosition.Y + p15.AbsoluteSize.Y / 2 - 20), "InOut", "Sine", 0.5);
		wait(0.5);
		v21:Destroy();
	end);
end;
return v1;
