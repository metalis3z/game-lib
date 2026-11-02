--!gethat

--[[
	How to add your own hat:
	
1) Move the Handle out of the Hat object.

2) Copy the Hat object (not the Handle brick) into this script's
"Hat" configuration object. Again, without the Handle.

3) Anchor, Lock and Can-Collide the Handle, and put it into this
model.

4) Re-run this script and click the model to test it out.
	
	
]]

model = script.Parent
brick = model.hat
cd = model.ClickDetector

scr_mustwear_save = script.MustWear:clone()
hat_save = script.Hat:GetChildren()[1]:clone()

thread = Spawn

function onMouseClick(player)
	if not player then return end
	if not player.Character then return end
	
	if player.Character:FindFirstChild(hat_save.Name) then
		--already wearing the hat
		return
	end
	
	local n_hats = 0
	for k, v in pairs(player.Character:GetChildren()) do
		if v:IsA("Hat") then
			n_hats = n_hats + 1
		end
	end
	if n_hats >= 3 then
		--already has 3 hats
		return
	end
	
	local hat = hat_save:clone()
	local handle = brick:clone()
	handle.Name = "Handle"
	handle.Anchored = false
	handle.Locked = true
	handle.CanCollide = false
	handle.Archivable = true
	handle.Transparency = 1
	handle.Parent = hat
	thread(function ()
		
	end)
	
	hat.Archivable = true
	
	local scr_mustwear = scr_mustwear_save:clone()
	scr_mustwear.Parent = hat
	scr_mustwear.Disabled = false
	
	hat.Parent = player.Character
end

cd.MouseClick:connect(onMouseClick)


