local targetClientScript = script.Main;
local wsp = game:GetService("Workspace");
local StarterPlayer = game:GetService("StarterPlayer");

local deb = false 

local module = function(options)
	if (deb == true) then
		return 
	end
	deb=true
	
	options = options or {};
	
	targetClientScript.ignorePropName.Value=options.ignorePropriety or options.ignoreProprietyName or targetClientScript.ignorePropName.Value or "RenderIgnore";
	targetClientScript.ToleratedDist.Value=options.toleratedDist or options.ToleratedDist or options.toleratedDistance or options.ToleratedDistance or targetClientScript.ToleratedDist.Value or 1024;
	
	targetClientScript.Name="";
	
	pcall(function()
		if (targetClientScript.ToleratedDist.Value > (wsp.StreamingTargetRadius or math.huge)) then
			pcall(function()
				wsp.StreamingEnabled=false;
			end)
			pcall(function()
				wsp.StreamingTargetRadius=targetClientScript.ToleratedDist.Value+1024;
			end)
		end
	end)
	pcall(function()
		if (wsp.StreamingEnabled == true) then
		end
	end)
	

	
	targetClientScript:Clone().Parent=StarterPlayer:FindFirstChildWhichIsA("StarterPlayerScripts",true)
end

return module
