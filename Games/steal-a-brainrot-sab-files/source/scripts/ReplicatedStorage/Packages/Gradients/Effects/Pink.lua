local v0 = require(script.Parent.Parent.ColorSequenceUtils)

local v1 = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 20, 147)),
	ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 105, 180)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 182, 193)),
	ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 105, 180)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 20, 147))
})

local v2 = 0

return {
	simulate = function(v3) 
		v2 = v2 + v3 * 0.7; 

		return {
			main = v0.calculateColorSequence(v1, v2)
		};
	end, 

	apply = function(v4) 
		local v5 = {};
		local l_UIGradient_0 = v4:FindFirstChildWhichIsA("UIGradient");
		local v7 = if l_UIGradient_0 then l_UIGradient_0.Color else nil;

		if not l_UIGradient_0 then
			local l_UIGradient_1 = Instance.new("UIGradient");
			l_UIGradient_1.Parent = v4;
			table.insert(v5, l_UIGradient_1);
			l_UIGradient_0 = l_UIGradient_1;
		end;

		return {
			main = l_UIGradient_0, 
			cleanup = function() 
				if v7 then
					l_UIGradient_0.Color = v7;
				end;
				for _, v10 in v5 do
					v10:Destroy();
				end;
			end
		};
	end
};