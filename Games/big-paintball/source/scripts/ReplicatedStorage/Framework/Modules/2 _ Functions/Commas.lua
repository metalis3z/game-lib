local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();

function comma_value(amount)
	if type(amount) ~= "number" then
		amount = tonumber(amount)
		if type(amount) ~= "number" then
			amount = 0
		end 
	end
	local NumWithComma = amount
	while true do  
		local formatted, k = string.gsub(NumWithComma, "^(-?%d+)(%d%d%d)", '%1,%2')
		NumWithComma = formatted
		if (k==0) then
			break
		end
	end
	return NumWithComma
end

return comma_value