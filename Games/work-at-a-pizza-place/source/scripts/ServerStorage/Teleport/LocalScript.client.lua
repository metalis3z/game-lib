--- SonOfSevenless

local COOLDOWN = 0
local MP = 0



bin = script.Parent

function TryToCast(player)
	-- returns true if player may cast this spell

	-- make sure this player has the wizard board stats
	local stats = player:findFirstChild("leaderstats")
	if stats == nil then return false end
	local mana = stats:findFirstChild("Mana")
	local level = stats:findFirstChild("Level")
	if mana == nil or level == nil then return false end

	if (mana.Value >= MP) then
		mana.Value = mana.Value - MP
		return true
	end

	return false
end




function teleportPlayer(pos)

	local player = game.Players.LocalPlayer
	if player == nil or player.Character == nil then return end

	local char = player.Character.HumanoidRootPart

	sound = Instance.new("Sound")
	sound.SoundId = ""
	sound.Parent = char
	sound.PlayOnRemove = true
	sound:remove()

	char.CFrame = CFrame.new(Vector3.new(pos.x, pos.y + 7, pos.z))


	sound = Instance.new("Sound")
	sound.SoundId = ""
	sound.Parent = char
	sound.PlayOnRemove = true
	sound:remove()

end


enabled = true
function onButton1Down(mouse)
	if not enabled then
		return
	end

	local player = game.Players.LocalPlayer
	if player == nil then return end
	--if TryToCast(player) == false then return end
	

	enabled = false
	mouse.Icon = "rbxasset://textures\\ArrowFarCursor.png"

	-- find the best cf
	local cf = mouse.Hit
	local v = cf.lookVector

	teleportPlayer(cf.p)

	wait(COOLDOWN)
	mouse.Icon = "rbxasset://textures\\ArrowCursor.png"
	enabled = true

end

function onSelected(mouse)
	mouse.Icon = "rbxasset://textures\\ArrowCursor.png"
	mouse.Button1Down:connect(function() onButton1Down(mouse) end)
end

bin.Selected:connect(onSelected)

