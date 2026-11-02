local Plane = script.Parent --Lines 1-4 set variables
local Engine = Plane.MainParts.Engine
local Welded = Plane.Welded
local Parts = {}
function GetParts(Model) --This function gets all the parts in the plane
	for i,v in pairs(Model:GetChildren()) do --This is a shorter way of getting all the children in a specific area
		if ((v:IsA("BasePart")) and v ~= Engine) then
			table.insert(Parts,v) --This inserts the parts into the "Parts" table
		end
		GetParts(v)
	end
end
function WeldParts() --This function welds the parts together. It's not as complicated as it looks
	GetParts(Plane)
	for i,v in pairs(Parts) do --This gets all the parts in the "Parts" table
		local Weld = Instance.new("Weld") --This makes the weld
		Weld.Name = "MainWeld"
		Weld.Part0 = Engine --This makes whatever brick the "v" variable is attach to the Engine
		Weld.Part1 = v
		Weld.C0 = Engine.CFrame:inverse()
		Weld.C1 = v.CFrame:inverse()
		Weld.Parent = v
	end
	wait(1)
	Engine.Anchored = false
	for i,v in pairs(Parts) do --This unanchors the bricks after 1 second
		v.Anchored = false
		Welded.Value = true
	end
end
WeldParts() --This activates the weld function