local Seat = script.Parent
local PlaneTool = Seat.Plane
local PlaneMain = Seat.Parent.Parent
local Customize = PlaneMain.Customize
local Crashed = PlaneMain.Crashed
local Origin = PlaneMain.Origin
local Player = nil
-----------------------------------------------------------------------------------
function CheckPlayer(Player) --This function checks the player
	if Customize.GroupSpecific.Value then --If the GroupSpecific value is true...
		if (not Player:IsInGroup(Customize.GroupSpecific.GroupID.Value)) then --If the player is not part of the group...
			return false
		end
	end
	return true
end

function CreateWarning(Player)
	local RbxGui = assert(LoadLibrary("RbxGui"))
	local Screen = Instance.new("ScreenGui")
	Screen.Name = "NotInGroupGui"
	local Gui = RbxGui.CreateStyledMessageDialog(
		"You are not in this plane's group!",
		Player.Name..", you are not a part of the group that this plane is in! Please exit the plane!",
		"Confirm",
		{
			{
				Text = "OK";
				Function = function()
					if Screen.Parent then Screen:Destroy() end
				end
			}
		}
	)
	Gui.Parent = Screen
	Screen.Parent = Player.PlayerGui
	return Screen
end

function GivePlaneTool(Child) --This function puts the tool in the player by using the "SeatWeld"
	if Child.Name == "SeatWeld" then
		Player = game.Players:GetPlayerFromCharacter(Child.Part1.Parent) --This gets the Player
		if Player then
			local Check = CheckPlayer(Player)
			if Check then
				PlaneMain.Parent = Player.Character --This makes the plane a part of the Player's Character
				Plane = PlaneTool:clone()
				Plane.Parent = Player.Backpack
				Plane.Main.Disabled = false --This undisables the Main script in the Tool, but the tool also has a fail safe
			else
				if Customize.GroupSpecific.KillOnEnter.Value then
					wait(0.1)
					if Player.Character then
						Player.Character.Humanoid.Health = 0
					end
				else
					local Gui = CreateWarning(Player)
					delay(7,function()
						if Gui.Parent then Gui:Destroy() end
					end)
				end
			end
		end
	end
end

function RemovePlaneTool() --This function removes the tool
	if Player and Player.PlayerGui:findFirstChild("NotInGroupGui") then
		Player.PlayerGui["NotInGroupGui"]:Destroy()
	end
	if Plane then
		Plane.Deselect0.Value = Plane.ToolSelect.Value --This makes the Deselect0 value on the plane tool true, which forces deselection
		wait(0.01) --This gives the tool enough time to activate the function
		Plane:remove() --This removes the plane tool
		if Player.Character.Humanoid.Health <= 0 then --If the Player dies...
			PlaneMain:BreakJoints() --These 3 lines break the plane and remove it after 5 seconds
			Crashed.Value = true
			delay(5,function() PlaneMain:Destroy() end)
		elseif Player.Character.Humanoid.Health > 0 then --If you just jump out of the seat without deselecting the tool...
			PlaneMain.Parent = Origin.Value --This puts the plane back into the Planekit folder
		end
	end
end
Seat.ChildAdded:connect(GivePlaneTool) --This activates the "GivePlaneTool" function when you sit on the seat
Seat.ChildRemoved:connect(RemovePlaneTool) --This activates the "RemovePlaneTool" function when you get off the seat