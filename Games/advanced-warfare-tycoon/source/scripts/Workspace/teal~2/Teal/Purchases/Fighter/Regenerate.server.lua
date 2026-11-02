local PlaneClone = script.Parent.Plane:clone() --Lines 1-10 set variables
local Planekit = script.Parent
PlaneClone.Origin.Value = Planekit
script.Parent.Plane.Origin.Value = Planekit
local EnterOnSpawn = Planekit.EnterOnSpawn
local Button = Planekit.Button
local Main = Button.Main
local RegenGui = script.RegenGui
local PlaneClone2 = nil
local Player = nil
local Active = true
--------------------------------------------------------
local RegenTime = 1 --Change this to how long it takes the plane to regen
local WaitTime = 8 --Change this to how much time you have to wait before you can regen another plane
--------------------------------------------------------
function DeleteIdlePlane() --This deletes any planes that aren't currently being used
	for _,v in pairs(Planekit:GetChildren()) do
		if v.Name == "Plane" then
			v:remove()
		end
	end
end

function RegenMain() --This function regens the plane
	PlaneClone2 = PlaneClone:clone()
	PlaneClone2.Parent = Planekit
	PlaneClone2.Origin.Value = Planekit
	PlaneClone2:MakeJoints()
end

function RegeneratePlane(Part) --This is the main regenerating function
	Player = game.Players:GetPlayerFromCharacter(Part.Parent) --This gets the player that touched it
	if Player then
		if Active then
			Active = false
			DeleteIdlePlane() --This activates the "DeleteIdlePlane" function
			for i = 0,1,0.2 do --This makes the button transparent
				Main.Transparency = i
				wait()
			end
			if RegenTime >= 1 then
				RegenGui.Parent = Player.PlayerGui --The regengui will be put into the player if the regentime is more than 1
			end
			wait(RegenTime)
			RegenGui.Parent = script --This puts the gui back in the script
			RegenMain()
			if EnterOnSpawn.Value then --If the EnterOnSpawn value is true...
				coroutine.resume(coroutine.create(function()
					repeat wait() until PlaneClone2.Welded.Value
					onPlaneWelded() --This activates the "onPlaneWelded" function whenever the welded value changes
				end))
			end
			wait(WaitTime)
			for i = 1,0,-0.2 do --This makes the button visible
				Main.Transparency = i
				wait()
			end
			Active = true
		end
	end
end

function onPlaneWelded() --This function put you into the plane seat the moment the plane is welded
	if PlaneClone2 ~= nil then
		if Player then --This checks to make sure there is a player
			if Player.Character:findFirstChild("Torso") then
				Player.Character.Torso.CFrame = PlaneClone2.MainParts.Seat.CFrame
			end
		end
	end
end

for _,v in pairs(Button:GetChildren()) do --This allows you to put as many bricks into the "Button" folder as you want
	if v:IsA("BasePart") then             --Make sure one of the bricks in the "Button" folder is named "Main"
		v.Touched:connect(RegeneratePlane) --This activates the "RegeneratePlane" function when any brick in the "Button" folder is touched
	end
end