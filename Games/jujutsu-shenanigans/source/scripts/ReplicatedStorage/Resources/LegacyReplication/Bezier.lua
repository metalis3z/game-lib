-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
B = function(v1, v2, v3)
	local function v4(v5)
		if v5 == 0 then
			return 1;
		else
			return v5 * v4(v5 - 1);
		end;
	end;
	local v6 = v1 == 0 and 1 or v1 * v4(v1 - 1);
	local v7 = v2 == 0 and 1 or v2 * v4(v2 - 1);
	local v8 = v1 - v2;
	return v6 / (v7 * (v8 == 0 and 1 or v8 * v4(v8 - 1))) * v3 ^ v2 * (1 - v3) ^ (v1 - v2);
end;
v0.new = function(...)
	local v9 = setmetatable({}, v0);
	local v10 = {
		...
	};
	v9.Points = {};
	v9.LengthIterations = 1000;
	v9.LengthIndeces = {};
	v9.Length = 0;
	v9._connections = {};
	for v11, v12 in pairs(v10) do
		if typeof(v12) == "CFrame" then
			v12 = v12.Position;
			v10[v11] = v12;
		end;
		if not (typeof(v12) ~= "Vector3") or typeof(v12) == "Instance" and v12:IsA("BasePart") then
			v9:AddBezierPoint(v12);
		else
			error("The Bezier.new() constructor only takes in Vector3s and BaseParts as inputs!");
		end;
	end;
	return v9;
end;
v0.AddBezierPoint = function(v13, v14, v15)
	if not (not (v14 and typeof(v14) == "Instance") or not v14:IsA("BasePart")) or typeof(v14) == "Vector3" then
		local v16 = {
			Type = typeof(v14) == "Vector3" and "StaicPoint" or "BasePartPoint", 
			Point = v14
		};
		if v16.Type == "BasePartPoint" then
			local v17 = nil;
			local v18 = nil;
			v17 = v14.Changed:Connect(function(v19)
				if v19 == "Position" then
					v13:UpdateLength();
				end;
			end);
			do
				local l_v17_0 = v17;
				v18 = v14.AncestryChanged:Connect(function(_, v22)
					if v22 == nil then
						local v23 = table.find(v13.Points, v16);
						if v23 then
							table.remove(v13.Points, v23);
						end;
						l_v17_0:Disconnect();
						l_v17_0:Disconnect();
					end;
				end);
				if not v13._connections[v14] then
					v13._connections[v14] = {};
				end;
				table.insert(v13._connections[v14], l_v17_0);
				table.insert(v13._connections[v14], v18);
			end;
		end;
		if v15 and type(v15) == "number" then
			table.insert(v13.Points, v15, v16);
		elseif not v15 then
			table.insert(v13.Points, v16);
		elseif type(v15) ~= "number" then
			error("Bezier:AddBezierPoint() only accepts an integer as the second argument!");
		end;
		v13:UpdateLength();
		return ;
	else
		error("Bezier:AddBezierPoint() only accepts a Vector3 or BasePart as the first argument!");
		return ;
	end;
end;
v0.ChangeBezierPoint = function(v24, v25, v26)
	if type(v25) ~= "number" then
		error("Bezier:ChangeBezierPoint() only accepts a number index as the first argument!");
	end;
	if not (not (v26 and typeof(v26) == "Instance") or not v26:IsA("BasePart")) or typeof(v26) == "Vector3" then
		local v27 = v24.Points[v25];
		if v27 then
			v27.Type = typeof(v26) == "Vector3" and "StaicPoint" or "BasePartPoint";
			v27.Point = v26;
			v24:UpdateLength();
			return ;
		else
			error("Did not find BezierPoint at index " .. tostring(v25));
			return ;
		end;
	else
		error("Bezier:ChangeBezierPoint() only accepts a Vector3 or BasePart as the second argument!");
		return ;
	end;
end;
v0.GetAllPoints = function(v28)
	local v29 = #v28.Points;
	local v30 = {};
	for v31 = 1, v29 do
		table.insert(v30, v28:GetPoint(v31));
	end;
	return v30;
end;
v0.GetPoint = function(v32, v33)
	local l_Points_0 = v32.Points;
	if l_Points_0[v33] then
		return typeof(l_Points_0[v33].Point) == "Vector3" and l_Points_0[v33].Point or l_Points_0[v33].Point.Position;
	else
		error("Did not find a BezierPoint at index " .. tostring(v33) .. "!");
		return ;
	end;
end;
v0.RemoveBezierPoint = function(v35, v36)
	if v35.Points[v36] then
		local v37 = table.remove(v35.Points, v36);
		if typeof(v37.Point) == "Instance" and v37.Point:IsA("BasePart") then
			for _, v39 in pairs(v35._connections[v37.Point]) do
				if v39.Connected then
					v39:Disconnect();
				end;
			end;
			v35._connections[v37.Point] = nil;
		end;
		v35:UpdateLength();
	end;
end;
v0.UpdateLength = function(v40)
	local l_v40_AllPoints_0 = v40:GetAllPoints();
	local l_LengthIterations_0 = v40.LengthIterations;
	if #l_v40_AllPoints_0 < 2 then
		return 0, {
			{
				0, 
				0, 
				0
			}, 
			{
				0, 
				0, 
				0
			}
		};
	else
		local v43 = 0;
		local v44 = {};
		for v45 = 1, l_LengthIterations_0 do
			local v46 = v40:CalculateDerivativeAt((v45 - 1) / (l_LengthIterations_0 - 1));
			v43 = v43 + v46.Magnitude * (1 / l_LengthIterations_0);
			table.insert(v44, {
				(v45 - 1) / (l_LengthIterations_0 - 1), 
				v43, 
				v46
			});
		end;
		v40.Length = v43;
		v40.LengthIndeces = v44;
		return ;
	end;
end;
v0.CalculatePositionAt = function(v47, v48)
	if type(v48) ~= "number" then
		error("Bezier:CalculatePositionAt() only accepts a number, got " .. tostring(v48) .. "!");
	end;
	if #v47.Points > 0 then
		local l_v47_AllPoints_0 = v47:GetAllPoints();
		local v50 = #l_v47_AllPoints_0;
		local v51 = nil;
		v51 = Vector3.new();
		for v52 = 1, v50 do
			local v53 = l_v47_AllPoints_0[v52];
			v51 = v51 + B(v50 - 1, v52 - 1, v48) * v53;
		end;
		return v51;
	else
		error("Bezier:CalculatePositionAt() only works if there is at least 1 BezierPoint!");
		return ;
	end;
end;
v0.CalculatePositionRelativeToLength = function(v54, v55)
	if type(v55) ~= "number" then
		error("Bezier:CalculatePositionRelativeToLength() only accepts a number, got " .. tostring(v55) .. "!");
	end;
	if #v54.Points > 0 then
		local l_Length_0 = v54.Length;
		local l_LengthIndeces_0 = v54.LengthIndeces;
		local _ = v54.LengthIterations;
		if #v54:GetAllPoints() > 1 then
			local v59 = l_Length_0 * v55;
			local v60 = nil;
			local v61 = nil;
			for v62, v63 in ipairs(l_LengthIndeces_0) do
				if v59 - v63[2] <= 0 then
					v60 = v62;
					v61 = v63;
					break;
				elseif v62 == #l_LengthIndeces_0 then
					v60 = v62;
					v61 = v63;
					break;
				end;
			end;
			local v64 = nil;
			local v65 = nil;
			if l_LengthIndeces_0[v60 - 1] then
				v64 = v54:CalculatePositionAt(l_LengthIndeces_0[v60 - 1][1]);
				v65 = v54:CalculatePositionAt(v61[1]);
			else
				v64 = v54:CalculatePositionAt(v61[1]);
				v65 = v54:CalculatePositionAt(l_LengthIndeces_0[v60 + 1][1]);
			end;
			local v66 = (v61[2] - v59) / (v65 - v64).Magnitude;
			return v64 + (v65 - v64) * (1 - v66);
		else
			return v54:CalculatePositionAt(0);
		end;
	else
		error("Bezier:CalculatePositionRelativeToLength() only works if there is at least 1 BezierPoint!");
		return ;
	end;
end;
v0.CalculateDerivativeAt = function(v67, v68)
	if type(v68) ~= "number" then
		error("Bezier:CalculateDerivativeAt() only accepts a number, got " .. tostring(v68) .. "!");
	end;
	if #v67.Points > 1 then
		local l_v67_AllPoints_0 = v67:GetAllPoints();
		local v70 = #l_v67_AllPoints_0;
		local _ = v70 - 1;
		local v72 = nil;
		v72 = Vector3.new();
		for v73 = 1, v70 - 1 do
			local v74 = l_v67_AllPoints_0[v73 + 1];
			local v75 = l_v67_AllPoints_0[v73];
			local v76 = (v70 - 1) * (v74 - v75);
			v72 = v72 + B(v70 - 2, v73 - 1, v68) * v76;
		end;
		return v72;
	else
		error("Bezier:CalculateDerivativeAt() only works if there are at least 2 BezierPoints!");
		return ;
	end;
end;
v0.CalculateDerivativeRelativeToLength = function(v77, v78)
	if type(v78) ~= "number" then
		error("Bezier:CalculateDerivativeRelativeToLength() only accepts a number, got " .. tostring(v78) .. "!");
	end;
	if #v77.Points > 1 then
		local l_Length_1 = v77.Length;
		local l_LengthIndeces_1 = v77.LengthIndeces;
		local _ = v77.LengthIterations;
		local _ = v77:GetAllPoints();
		local v83 = l_Length_1 * v78;
		local v84 = nil;
		local v85 = nil;
		for v86, v87 in ipairs(l_LengthIndeces_1) do
			if v83 - v87[2] <= 0 then
				v84 = v86;
				v85 = v87;
				break;
			elseif v86 == #l_LengthIndeces_1 then
				v84 = v86;
				v85 = v87;
				break;
			end;
		end;
		local v88 = nil;
		local v89 = nil;
		if l_LengthIndeces_1[v84 - 1] then
			v88 = v77:CalculateDerivativeAt(l_LengthIndeces_1[v84 - 1][1]);
			v89 = v77:CalculateDerivativeAt(v85[1]);
		else
			v88 = v77:CalculateDerivativeAt(v85[1]);
			v89 = v77:CalculateDerivativeAt(l_LengthIndeces_1[v84 + 1][1]);
		end;
		local v90 = (v85[2] - v83) / (v89 - v88).Magnitude;
		return v88 + (v89 - v88) * (1 - v90);
	else
		error("Bezier:CalculateDerivativeRelativeToLength() only works if there are at least 2 BezierPoints!");
		return ;
	end;
end;
v0.CreateVector3Tween = function(v91, v92, v93, v94, v95)
	if #v91.Points == 0 then
		error("Bezier:CreateVector3Tween() only works if there is at least 1 BezierPoint in the Bezier!");
	end;
	if typeof(v92) ~= "Instance" and typeof(v92) ~= "table" then
		error("Bezier:CreateVector3Tween() requires an Instance or a table as the first argument!");
	end;
	if typeof(v94) ~= "TweenInfo" then
		error("Bezier:CreateVector3Tween() requires a TweenInfo object as the third argument!");
	end;
	local l_status_0, l_result_0 = pcall(function()
		local v96 = true;
		for _, v98 in pairs(v93) do
			if typeof(v92[v98]) ~= "Vector3" and typeof(v92[v98]) ~= "nil" then
				return false;
			end;
		end;
		return v96;
	end);
	if l_status_0 and l_result_0 then
		local l_TweenService_0 = game:GetService("TweenService");
		local l_NumberValue_0 = Instance.new("NumberValue");
		local v103 = l_TweenService_0:Create(l_NumberValue_0, v94, {
			Value = 1
		});
		local v104 = nil;
		v103.Changed:Connect(function(v105)
			if v105 == "PlaybackState" then
				if v103.PlaybackState == Enum.PlaybackState.Playing then
					v104 = l_NumberValue_0.Changed:Connect(function(v106)
						for _, v108 in pairs(v93) do
							v92[v108] = v95 and v91:CalculatePositionRelativeToLength(v106) or v91:CalculatePositionAt(v106);
						end;
					end);
					return ;
				elseif v104 then
					v104:Disconnect();
					v104 = nil;
				end;
			end;
		end);
		return v103;
	else
		error("Bezier:CreateVector3Tween() requires a matching property table with Vector3 or nil property names for the object as the second argument!");
		return ;
	end;
end;
v0.CreateCFrameTween = function(v109, v110, v111, v112, v113)
	if #v109.Points <= 1 then
		error("Bezier:CreateVector3Tween() only works if there are at least 2 BezierPoints in the Bezier!");
	end;
	if typeof(v110) ~= "Instance" and typeof(v110) ~= "table" then
		error("Bezier:CreateCFrameTween() requires an Instance or a table as the first argument!");
	end;
	if typeof(v112) ~= "TweenInfo" then
		error("Bezier:CreateCFrameTween() requires a TweenInfo object as the third argument!");
	end;
	local l_status_1, l_result_1 = pcall(function()
		local v114 = true;
		for _, v116 in pairs(v111) do
			if typeof(v110[v116]) ~= "CFrame" and typeof(v110[v116]) ~= "nil" then
				return false;
			end;
		end;
		return v114;
	end);
	if l_status_1 and l_result_1 then
		local l_TweenService_1 = game:GetService("TweenService");
		local l_NumberValue_1 = Instance.new("NumberValue");
		local v121 = l_TweenService_1:Create(l_NumberValue_1, v112, {
			Value = 1
		});
		local v122 = nil;
		v121.Changed:Connect(function(v123)
			if v123 == "PlaybackState" then
				if v121.PlaybackState == Enum.PlaybackState.Playing then
					v122 = l_NumberValue_1.Changed:Connect(function(v124)
						for _, v126 in pairs(v111) do
							local v127 = v113 and v109:CalculatePositionRelativeToLength(v124) or v109:CalculatePositionAt(v124);
							local v128 = v113 and v109:CalculateDerivativeRelativeToLength(v124) or v109:CalculateDerivativeAt(v124);
							v110[v126] = CFrame.new(v127, v127 + v128);
						end;
					end);
					return ;
				elseif v122 then
					v122:Disconnect();
					v122 = nil;
				end;
			end;
		end);
		return v121;
	else
		error("Bezier:CreateCFrameTween() requires a matching property table with CFrame or nil property names for the object as the second argument!");
		return ;
	end;
end;
return v0;