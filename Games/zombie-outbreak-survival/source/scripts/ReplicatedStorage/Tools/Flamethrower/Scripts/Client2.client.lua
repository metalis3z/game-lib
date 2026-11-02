local player = game.Players.LocalPlayer
local ft = script.Parent.Parent
local remotes = ft:WaitForChild("Remotes")
local Debris = game:GetService("Debris")

local firing = false
local cooled = true

function fire()
	if cooled and not firing then
		cooled = false
		firing = true
		remotes.Fire:InvokeServer()
		repeat
			if not firing then
				remotes.StopFire:InvokeServer()
			end
			wait(0.5)
		until cooled
	end
end

function stopFire()
	firing = false
	wait(0.5)
	remotes.StopFire:InvokeServer()
	wait(1)
	cooled = true
end

function equipped()
	remotes.GenerateNozzle:FireServer()
end

function unequipped()
	remotes.StopFire:InvokeServer()
end

ft.Equipped:Connect(equipped)
ft.Unequipped:Connect(unequipped)
ft.Activated:Connect(fire)
ft.Deactivated:Connect(stopFire)