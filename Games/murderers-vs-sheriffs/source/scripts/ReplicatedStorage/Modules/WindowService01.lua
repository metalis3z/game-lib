local v0 = {};
local v1 = {};
local v2 = {};
local v3 = {};
local function v8() --[[ Line: 9 ]] --[[ Name: updateStack ]]
	for _, v5 in v1 do
		v5.Visible = false;
	end;
	for v6, v7 in v3 do
		v7.Visible = v6 == #v3;
		if v7.Visible and v2[v7] then
			v2[v7]();
		end;
	end;
end;
v0.ToggleFrame = function(_, v10) --[[ Line: 22 ]] --[[ Name: ToggleFrame ]]
	local v11 = v1[v10] or v10;
	if type(v11) == "string" or v11 == nil then
		warn("Frame not found: " .. tostring(v10));
		return;
	else
		if v11.Visible then
			v11.Visible = false;
			v3 = {};
		else
			v3 = {
				v11
			};
			if v2[v11] then
				v2[v11]();
			end;
		end;
		v8();
		return;
	end;
end;
v0.ViewFrame = function(_, v13) --[[ Line: 44 ]] --[[ Name: ViewFrame ]]
	local v14 = v1[v13] or v13;
	if type(v14) == "string" or v14 == nil then
		warn("Frame not found: " .. tostring(v13));
		return;
	else
		v3 = {
			v14
		};
		if v2[v14] then
			v2[v14]();
		end;
		v8();
		return;
	end;
end;
v0.CloseAllFrames = function(_) --[[ Line: 62 ]] --[[ Name: CloseAllFrames ]]
	v3 = {};
	v8();
end;
v0.Back = function(_) --[[ Line: 67 ]] --[[ Name: Back ]]
	if #v3 < 1 then
		return;
	else
		local v17 = #v3;
		v3[v17].Visible = false;
		table.remove(v3, v17);
		v8();
		return;
	end;
end;
v0.AddToStack = function(_, v19) --[[ Line: 80 ]] --[[ Name: AddToStack ]]
	local v20 = v1[v19] or v19;
	if v20 == nil or typeof(v20) == "string" then
		warn("WindowService: Frame not found: " .. tostring(v19));
		return;
	else
		local v21 = table.find(v3, v20);
		if v21 then
			table.remove(v3, v21);
		end;
		table.insert(v3, v20);
		v8();
		return;
	end;
end;
v0.GetFrame = function(_, v23) --[[ Line: 96 ]] --[[ Name: GetFrame ]]
	return v1[v23];
end;
v0.RegisterFrame = function(_, v25, v26, v27) --[[ Line: 100 ]] --[[ Name: RegisterFrame ]]
	if typeof(v25) ~= "Instance" then
		warn("WindowService: First argument must be a GuiObject");
		return;
	elseif not v25:IsA("GuiObject") then
		warn("WindowService: First argument must be a GuiObject");
		return;
	else
		if v1[v26] ~= nil then

		end;
		v1[v26] = v25;
		if v27 then
			v2[v25] = v27;
		end;
		return;
	end;
end;
return v0;