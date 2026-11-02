-- Auto Updating Character Made BY loldog75
local Players = game:GetService("Players")
local updatetime = script.Parent.Configuration.UpdateTime.Value;
local userid = script.Parent.Configuration.UserId.Value;
local ShowName = script.Parent.Configuration.ShowName
local Name = Players:GetNameFromUserIdAsync(userid)

while wait() do
	script.Parent.Humanoid:ApplyDescription(Players:GetHumanoidDescriptionFromUserId(userid))
	if ShowName.Value == true then
		local name = Players:GetNameFromUserIdAsync(userid)
		script.Parent.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer;
		script.Parent.Humanoid.DisplayName = name
	end
	if userid ~= nil or userid <= 1 then return end
	
	if updatetime ~= nil or updatetime <= 1 then return end
	task.wait(updatetime)
end