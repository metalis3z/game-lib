--Variables--
local Brick = script.Parent
--End--

--Code--
local function PlayerTouched(Part)
	local Parent = Part.Parent
	if game.Players:GetPlayerFromCharacter(Parent) then
		while true do
			wait(0.1)
			Parent.Humanoid:TakeDamage(1)
		end
	end
end

Brick.Touched:connect(PlayerTouched)