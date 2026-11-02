local ToleratedDistance = script.ToleratedDist.Value or 1024;
local ignorePropriety = script.ignorePropName.Value or "RenderIgnore";


local Stats = game:GetService("Stats")
local Workspace = game:GetService("Workspace");
local RenderStepped = game:GetService("RunService").RenderStepped;
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;

local dist = Vector3.new(100000,0,0);

local disabledLocation = Instance.new("Model");
disabledLocation.Parent = game:GetService("ReplicatedFirst");
disabledLocation.Name = "UnrenderedParts";

_G.getDisabledLocation = function()
	return disabledLocation;
end

local isGettingAvg = false;



if (not game:IsLoaded()) then
	game.Loaded:Wait()
end

RenderStepped:Connect(function()
	_G.sinceLastStep = (_G.sinceLastStep or 0) + 1
end)

local i = 0;
function call()
	i=i+1;
	
	if (isGettingAvg==true) then
		return
	end
	
	local function runCheck(part)
		if (part:IsA("Terrain")) then
			return;
		end
		
		if (not part:IsA("BasePart")) then
			return;
		end
		
		if (part:IsDescendantOf(Workspace)) then
			if (not part:FindFirstChild("OriginalParent")) then
				local x = Instance.new("ObjectValue");
				x.Name="OriginalParent";
				x.Parent=part;
			end

			part.OriginalParent.Value = part.Parent;
		end
		
		local pos = part.Position
		
		if (part:IsDescendantOf(disabledLocation)) then
			pos=pos-dist
		end
		
		local partDist = LocalPlayer:DistanceFromCharacter(pos);
		
		local function _tmp(part,i)
			local i = (i or 0)+1;
			if (i>50) then 
				return false;
			end
			if (part == game or part == workspace or part == nil) then
				return false;
			end
			if (part:FindFirstChild(ignorePropriety)) then
				if (part:FindFirstChild(ignorePropriety).Value == true) then
					return true;
				end
			end
			
			return false
		end
		
		local ignore = _tmp(part);
		
		if (partDist > ToleratedDistance) then
			if (part:IsDescendantOf(Workspace) and part.Locked == false) then
				if (not ignore) then
					part.Parent=disabledLocation;
					part.Position=part.Position+dist; 
				end
			end
		else
			if (part:IsDescendantOf(disabledLocation)) then
				if (not ignore) then
					part.Parent=part.OriginalParent.Value;
					part.Position=part.Position-dist;
				end
			end
		end
		
		local x = part:FindFirstChild("DistanceFromPlayer")
		
		if (not x) then
			x = Instance.new("NumberValue");
			x.Name="DistanceFromPlayer";
			x.Parent=part;
		end
		
		x.Value=math.floor(partDist*10)/10;
		
		return x.Parent==disabledLocation;
	end
	
	_G.sinceLastStep=0
	for i,o in pairs(Workspace:GetDescendants()) do
		if (math.floor(i/1000)*1000 == i) then
			RenderStepped:Wait()
		end
		runCheck(o)
	end
	
	if ((#disabledLocation:GetChildren() > 100000 and i>=2) or (#disabledLocation:GetChildren() <= 100000)) then 
		local i2 = 0
		for _,o in pairs(disabledLocation:GetChildren()) do 
			if (math.floor(i/1000)*1000 == i) then
				print("wait - "..i)
				RenderStepped:Wait()
			end
			if runCheck(o) == true then
				i2=i2+1
			end
			
			if (i2>=20000) then 
				break;
			end
		end
	end
	if (i>=5) then
		i=0
	end
end

local fps = 0

RenderStepped:Connect(function(step)
	fps=1/step
end)

local lastPos = Vector3.new(0,0,0)

while true do 
	for i=0,30,1 do 
		RenderStepped:Wait();
	end
	
	
	if (fps<=30) then
		for i=0,30,1 do 
			RenderStepped:Wait();
		end
	end
	
	if (not LocalPlayer.Character) then 
		LocalPlayer.CharacterAdded:Wait();
	end
	

	if (#disabledLocation:GetDescendants() > 75000) then
		for i=0,30,1 do
			RenderStepped:Wait();
		end
		
		local currentPos=LocalPlayer.Character.PrimaryPart.Position
		if ((currentPos-lastPos).magnitude < (50)) then 
			for i=0,150,1 do 
				RenderStepped:Wait();
				
				currentPos=LocalPlayer.Character.PrimaryPart.Position 
				
				if ((currentPos-lastPos).magnitude > (50)) then 
					break;
				end
			end
		end
		
		lastPos=currentPos;
	end
	
	
	call()
end
