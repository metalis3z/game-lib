local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v5 = {};
local v7 = require(l_ReplicatedStorage_0.Packages.Trove);
local v8 = require(l_ReplicatedStorage_0.Packages.Observers);
local v9 = require(l_ReplicatedStorage_0.Packages.CreateTween);
local v10 = require(script.Parent.Parent);
local l_Name_0 = script.Name;
local v12 = v7.new();

v5.OnStart = function(_)
	assert((v10:GetActiveEventData(l_Name_0)));
	v12:Add(v8.observeTag("SammyBaseStep", function(v14)
		local v15 = v14:GetAttribute("Index") or 0;
		local l_Position_0 = v14.Position;
		v14.Position = v14.Position + Vector3.new(-(v15 % 1 * 2 - 1) * 2, 0, 0);
		v9(v14, TweenInfo.new(0.5), {
			Transparency = 0, 
			Position = l_Position_0
		});
		return nil;
	end));
	
	v12:Add(v8.observeTag("HideInSammysBase", function(v17)
		local l_Parent_0 = v17.Parent;
		v17.Parent = script;
		return function()
			pcall(function()
				v17.Parent = l_Parent_0;
			end);
		end;
	end, {
		workspace, 
		script
	}));
end;

v5.OnStop = function(_)
	v12:Destroy();
end;

v5.OnLoad = function(_)
end;

return v5;