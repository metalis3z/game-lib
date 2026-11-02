local module = {}
module.__index = module

local groupService = game:GetService("GroupService")

local Authorize = require(script.Parent.Authorize)

local function IfAuthorized(plr)
	if Authorize.Teams[plr.Team.Name] then
		return true
	end
	local plrGroups = groupService:GetGroupsAsync(plr.UserId)
	for i,v in pairs(plrGroups) do
		if Authorize.GroupRank[v.Id] then
			if plr:GetRankInGroup(v.Id) >= Authorize.GroupRank[v.Id] then
				return true
			end
		end
	end
	for i,v in pairs(plr.Backpack:GetChildren()) do
		if Authorize.Tools[v.Name] then
			return true
		end
	end
	for i,v in pairs(plr.Character:GetChildren()) do
		if Authorize.Tools[v.Name] then
			return true
		end
	end	
	return false
end

function module.Interact(plr)
	if (plr.Character.HumanoidRootPart.Position - script.Parent.Parent.PrimaryPart.Position).magnitude <= 15 then
		local Authorized = IfAuthorized(plr)
		if Authorized == false then
			return
		end
		if script.Parent.Cooldown.Value == false then
			if script.Parent.IsOpened.Value == false then
				script.Parent.IsOpened.Value = true
				script.Parent.Cooldown.Value = true
				wait(1.25)
				script.Parent.Cooldown.Value = false
				local counter = 0
				repeat
					wait(1)
					counter = counter + 1
				until counter == 10 or script.Parent.IsOpened.Value == false
			elseif script.Parent.IsOpened.Value == true then
				script.Parent.Cooldown.Value = true
				script.Parent.IsOpened.Value = false
				wait(1.25)
				script.Parent.Cooldown.Value = false
			end
		end
	end
end


return module