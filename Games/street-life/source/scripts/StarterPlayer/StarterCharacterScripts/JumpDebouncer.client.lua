if not game:IsLoaded() then game.Loaded:Wait() end task.wait(1)

sp = script.Parent

debouncetime = 2

local h = sp:WaitForChild("Humanoid")
local lastjump = time()

h.JumpPower = 0

h.Changed:connect(function(prop)
	if prop and prop == "Jump" and h.Jump then
		local currenttime = time()
		if lastjump + debouncetime > currenttime then
			h.Jump = false
		else
			lastjump = currenttime
		end
	end
end)