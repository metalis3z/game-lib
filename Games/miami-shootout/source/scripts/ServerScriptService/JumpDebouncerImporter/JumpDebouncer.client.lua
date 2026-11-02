sp = script.Parent

debouncetime = 2 -- 2 second waittime between each jumps

local h = sp:WaitForChild("Humanoid")
local lastjump = time()

h.JumpPower = 36

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
