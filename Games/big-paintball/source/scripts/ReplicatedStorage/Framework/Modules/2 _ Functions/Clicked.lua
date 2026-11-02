--jixx was here

local u1 = nil;
coroutine.wrap(function()
	u1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
end)();
local u2 = {};
function Create(p1, p2)
	p2 = string.lower(p2);
	if p2 ~= "mouse1down" then
		if p2 ~= "mouse1up" then
			if p2 ~= "mouse1click" then
				if p2 ~= "mouse2down" then
					if p2 ~= "mouse2up" then
						if p2 ~= "mouse2click" then
							return u1.Print("_L.Functions.Clicked - \"" .. p2 .. "\" is an invalid event type. Check spelling!", true);
						end;
					end;
				end;
			end;
		end;
	end;
	if u2[p1] then
		if u2[p1][p2] then
			return u2[p1][p2];
		end;
	end;
	if not u2[p1] then
		u2[p1] = {};
	end;
	local v1 = Instance.new("BindableEvent");
	u2[p1][p2] = v1;
	return v1;
end;
function Fire(p3)
	local l__Target__2 = u1.Player.Get("Mouse").Target;
	local v3 = true;
	if l__Target__2.ClassName ~= "Folder" then
		v3 = l__Target__2.ClassName == "Model";
	end;
	if l__Target__2 then
		if l__Target__2.Parent then
			for v4, v5 in pairs(u2) do
				local v9 = true;
				if v4.ClassName ~= "Folder" then
					v9 = v4.ClassName == "Model";
				end;
				if v3 or v9 then
					if not l__Target__2:IsDescendantOf(v4) then
						if l__Target__2 == v4 then
							if v5[p3] then
								v5[p3]:Fire();
								return;
							end;
						end;
					elseif v5[p3] then
						v5[p3]:Fire();
						return;
					end;
				elseif l__Target__2 == v4 then
					if v5[p3] then
						v5[p3]:Fire();
						return;
					end;
				end;			
			end;
		end;
	end;
end;
local u3 = false;
function Init()
	u3 = true;
	local v10 = u1.Player.Get("Mouse");
	v10.Button1Down:Connect(function()
		Fire("mouse1down");
		v10.Button1Up:Wait();
		Fire("mouse1click");
	end);
	v10.Button1Up:Connect(function()
		Fire("mouse1up");
	end);
	v10.Button2Down:Connect(function()
		Fire("mouse2down");
		v10.Button2Up:Wait();
		Fire("mouse2click");
	end);
	v10.Button2Up:Connect(function()
		Fire("mouse2up");
	end);
end;
coroutine.wrap(function()
	while true do
		wait(5);
		for v11, v12 in pairs(u2) do
			if not v11 or not v11.Parent or u1.Functions.DictionaryLength(v12) == 0 then
				u2[v11] = nil;
			end;
			wait();
		end;	
	end;
end)();
return function(p4, p5)
	if not u3 then
		Init();
	end;
	p5 = p5 and "mouse1click";
	return Create(p4, p5);
end;
