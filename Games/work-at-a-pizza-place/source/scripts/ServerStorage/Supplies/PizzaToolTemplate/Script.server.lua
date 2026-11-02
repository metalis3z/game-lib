--if another player picks up the pizza during the tutorial, give it to the persion in the tutorial
local Handle = script.Parent.Handle
script.Parent.Equipped:connect(function()
	local player = game.Players:GetPlayerFromCharacter(script.Parent.Parent)
	if player and Handle:FindFirstChild("Tutorial") and Handle.Tutorial.Value and Handle.Tutorial.Value ~= player then
		wait()
		script.Parent.Parent = Handle.Tutorial.Value.Character
	end
end)