local PillSample = script.Parent.Parent.Parent:WaitForChild("Sample")
local ToolSample = script.Parent:WaitForChild("SCP-500-01")
script.Parent.MouseClick:connect(function(plr)
	local Backpack = plr:FindFirstChild("Backpack")
	if Backpack then
		local Tool = ToolSample:Clone()
		local Pill = PillSample:Clone()
		Pill.CanCollide = false
		Pill.Anchored = false
		Pill.Name = "Handle"
		Pill.Parent = Tool
		Tool.Parent = Backpack
	end
end)