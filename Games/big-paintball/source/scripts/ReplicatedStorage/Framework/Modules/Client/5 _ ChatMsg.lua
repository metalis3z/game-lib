-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = {};
local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
function v1.New(p1, p2, p3, p4)
	p2 = p2 or Color3.new(0.2, 0.2, 0.2);
	p3 = p3 or Enum.Font.GothamSemibold;
	p4 = p4 or Enum.FontSize.Size18;
	game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
		Text = p1, 
		Color = p2, 
		Font = p3, 
		FontSize = p4
	});
end;
u1.Network.Fired("Chat Msg"):Connect(function(...)
	v1.New(...);
end);
return v1;
