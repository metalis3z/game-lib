repeat wait() until script.Parent.Welded.Value --This line makes the plane invulnerable to weapons when it is still welding
wait(0.1)
local Plane = script.Parent --Lines 3 - 10 set variables
local AutoCrash = Plane.AutoCrash
local Ejected = Plane.Ejected
local Engine = Plane.MainParts.Engine
local CanCrash = Plane.Customize.CanCrash
local Force = CanCrash.Force
local Crashed = Plane.Crashed
local Parts = {}
--------------------------------------------------------------------------
function Explode() --This function makes the plane explode
	if Crashed.Value == false then
		Crashed.Value = true
		Plane:BreakJoints()
		local Explosion = Instance.new("Explosion")
		Explosion.Parent = game.Workspace
		Explosion.Position = Engine.Position
		Explosion.BlastRadius = Plane:GetModelSize().magnitude --This makes the BlastRadius the size of the plane
		Explosion.BlastPressure = 200000
		if Engine:findFirstChild("Thrust") then Engine.Thrust:remove() end
		if Engine:findFirstChild("Direction") then Engine.Direction:remove() end
		coroutine.resume(coroutine.create(function()
			wait(5)
			Plane:Destroy()
		end))
	end
end

function GetPlaneParts(Model) --This function gets all the parts on the plane
	for _,v in pairs(Model:GetChildren()) do
		if (v:IsA("BasePart")) then
			table.insert(Parts,v) --This inserts all the parts into the "Parts" table
		end
		GetPlaneParts(v)
	end
end

function onAutoCrash() --This function is activated when the AutoCrash value becomes true
	if AutoCrash.Value == true then
		Plane:BreakJoints()
		Explode()
		Engine.Thrust:remove()
		Engine.Direction:remove()
	end
end

function DetectExplosions(Object) --This is a function that I created which detects explosions in the workspace
	if Object.ClassName == "Explosion" then --If the object detected was an explosion...
		if Object.BlastPressure > 0 then
			Object.Hit:connect(function(HitPart,Distance)
				if HitPart == Engine then
					if Crashed.Value == false then
						Explode()
					end
				end
			end)
		end
	end
end

GetPlaneParts(Plane) --This activates the "GetPlaneParts" function
for _,v in pairs(Parts) do --This gets all the parts in the "Parts" table
	v.Touched:connect(function(Object) --This is activated if any of the bricks are touched
		if (not Ejected.Value) then
			if CanCrash.Value == true then
				if Crashed.Value == false then
					if (not Object:IsDescendantOf(Plane)) then
						if Object.CanCollide == true
						and Object.Transparency ~= 1 then --This prevents your from crashing because your flares hit you
							if (Object:findFirstChild("PlaneTag") and Object.PlaneTag.Value ~= Plane)
							or (not Object:findFirstChild("PlaneTag")) then
								if ((Engine.Velocity.magnitude) >= Force.Value) then --If that part is going faster than the Force speed...
									local Player = game.Players:GetPlayerFromCharacter(Plane.Parent)
									local PlaneTool = Player.Backpack:findFirstChild("Plane")
									if PlaneTool then
										PlaneTool.Deselect0.Value = true
									end
									wait(0.01)
									Explode()
								end
							end
						end
					end
				end
			end
		elseif Ejected.Value then
			if Crashed.Value == false then
				if (not Object:IsDescendantOf(Plane)) then
					if Object.CanCollide and Object.Transparency ~= 1 then
						local PlaneTag = Object:findFirstChild("PlaneTag")
						if (PlaneTag and PlaneTag.Value ~= Plane) or (not PlaneTag) then
							if Object.Parent.Name ~= "EjectorSeat" then
								if (not game:GetService("Players"):GetPlayerFromCharacter(Object.Parent)) then
									local Player = game.Players:GetPlayerFromCharacter(Plane.Parent)
									local PlaneTool = Player.Backpack:findFirstChild("Plane")
									if PlaneTool then
										PlaneTool.Deselect0.Value = true
									end
									wait(0.01)
									Explode()
								end
							end
						end
					end
				end
			end
		end
	end)
end
game.Workspace.DescendantAdded:connect(DetectExplosions) --The detect explosions is a childadded function
AutoCrash.Changed:connect(onAutoCrash) --Pretty self explanatory. When the AutoCrash value is changed, the "onAutoCrash" function is activated