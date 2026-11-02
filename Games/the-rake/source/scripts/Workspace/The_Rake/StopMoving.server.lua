local Rake = script.Parent
local Configuration = Rake.Configuration

while true do
	wait()
	if workspace.StopMoving.Value == true then
		Configuration.WalkSpeed.Value = 0
		Configuration.RunSpeed.Value = 0
	end
end