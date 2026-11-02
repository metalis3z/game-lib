-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local _ = game:GetService("Debris");
local v3 = require(l_ReplicatedStorage_0.Controllers.TsunamiEventController);
local v4 = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v5 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v6 = require(l_ReplicatedStorage_0.Datas.ServerData);
local v7 = require(l_ReplicatedStorage_0.Shared.VFX);
local function v8() --[[ Line: 18 ]]

end;
local function v13(v9, v10) --[[ Line: 20 ]] --[[ Name: resizeEffects ]]
	local l_Parent_0 = v9.Parent;
	local l_Model_0 = Instance.new("Model");
	v9.Parent = l_Model_0;
	l_Model_0:ScaleTo(v10);
	v9.Parent = l_Parent_0;
	l_Model_0:Destroy();
end;
local function v18(v14) --[[ Line: 29 ]] --[[ Name: getAnimalModel ]]
	-- upvalues: v6 (copy), v3 (copy), v4 (copy)
	if v6.IsTsunamiServer() then
		local _, v16 = v3:GetBrainrotCFrame(v14);
		if not v16 then
			return nil;
		else
			return v16;
		end;
	else
		local v17 = v4:GetAnimals()[v14];
		if not v17 then
			return nil;
		else
			return v17.AnimalModel;
		end;
	end;
end;
local function v24(v19) --[[ Line: 47 ]] --[[ Name: getAnimalRootPart ]]
	-- upvalues: v6 (copy), v3 (copy), v4 (copy)
	local v20;
	if v6.IsTsunamiServer() then
		local _, v22 = v3:GetBrainrotCFrame(v19);
		v20 = v22 or nil;
	else
		local v23 = v4:GetAnimals()[v19];
		v20 = if not v23 then nil else v23.AnimalModel;
	end;
	if not v20 then
		return nil;
	else
		return v20.PrimaryPart;
	end;
end;
local function v32(v25, v26) --[[ Line: 56 ]] --[[ Name: getAnimalCFrame ]]
	-- upvalues: v6 (copy), v3 (copy), v4 (copy)
	local v27 = nil;
	local v28 = nil;
	if v6.IsTsunamiServer() then
		local l_v3_BrainrotCFrame_2, v30 = v3:GetBrainrotCFrame(v25);
		if not l_v3_BrainrotCFrame_2 or not v30 then
			return CFrame.identity;
		else
			v28 = v30;
			v27 = l_v3_BrainrotCFrame_2 * CFrame.new(0, v30:GetExtentsSize().Y * 0.5, 0);
		end;
	else
		local v31 = v4:GetAnimals()[v25];
		if not v31 then
			return CFrame.identity;
		else
			v28 = v31.AnimalModel;
			assert(v28);
			v27 = v28:GetPivot() * CFrame.new(0, v28:GetExtentsSize().Y * 0.5, 0);
		end;
	end;
	if not v27 or not v28 then
		return CFrame.identity;
	elseif v26 and v26.top then
		return v27 * CFrame.new(0, v28:GetExtentsSize().Y * 0.5, 0);
	else
		if v26 and v26.bottom then
			v27 = v27 * CFrame.new(0, -v28:GetExtentsSize().Y * 0.5, 0);
		end;
		return v27;
	end;
end;
return {
	getAnimalModel = v18, 
	getAnimalCFrame = v32, 
	getAnimalPosition = function(v33, v34) --[[ Line: 90 ]] --[[ Name: getAnimalPosition ]]
		-- upvalues: v6 (copy), v3 (copy), v4 (copy)
		local v35 = nil;
		local v36 = nil;
		if v6.IsTsunamiServer() then
			local l_v3_BrainrotCFrame_3, v38 = v3:GetBrainrotCFrame(v33);
			if not l_v3_BrainrotCFrame_3 or not v38 then
				return (Vector3.new(0, 0, 0, 0));
			else
				v36 = v38;
				v35 = l_v3_BrainrotCFrame_3.Position + Vector3.new(0, v38:GetExtentsSize().Y * 0.5, 0);
			end;
		else
			local v39 = v4:GetAnimals()[v33];
			if not v39 then
				return (Vector3.new(0, 0, 0, 0));
			else
				v35 = v39.AnimalModel:GetPivot().Position;
				v36 = v39.AnimalModel;
			end;
		end;
		if not v35 or not v36 then
			return (Vector3.new(0, 0, 0, 0));
		elseif v34 and v34.top then
			return v35 + Vector3.new(0, v36:GetExtentsSize().Y * 0.5, 0);
		else
			if v34 and v34.bottom then
				v35 = v35 - Vector3.new(0, v36:GetExtentsSize().Y * 0.5, 0);
			end;
			return v35;
		end;
	end, 
	getAnimalRootPart = v24, 
	playBurst = function(v40, v41, v42, v43) --[[ Line: 127 ]] --[[ Name: playBurst ]]
		-- upvalues: v6 (copy), v3 (copy), v4 (copy), v32 (copy), v8 (copy), v7 (copy), v5 (copy)
		local v44 = nil;
		local v45 = nil;
		local v46 = nil;
		if typeof(v41) == "string" then
			local v47;
			if v6.IsTsunamiServer() then
				local _, v49 = v3:GetBrainrotCFrame(v41);
				v47 = v49 or nil;
			else
				local v50 = v4:GetAnimals()[v41];
				v47 = if not v50 then nil else v50.AnimalModel;
			end;
			local v51 = v32(v41, v43);
			if not v47 or not v51 then
				return v8;
			else
				v44 = v47;
				v45 = v47.PrimaryPart;
				v46 = v51;
				if not v45 then
					return v8;
				end;
			end;
		elseif typeof(v41) == "CFrame" then
			v46 = v41;
			v45 = nil;
			v44 = workspace;
		elseif typeof(v41) == "Vector3" then
			v46 = CFrame.new(v41);
			v45 = nil;
			v44 = workspace;
		else
			v45 = v41;
			v46 = v41:GetPivot();
			v44 = v41;
		end;
		local v52 = v40:Clone();
		if v43 and v43.modify then
			v52 = v43.modify(v52);
		end;
		v52.CanCollide = false;
		v52.CanTouch = false;
		v52.CanQuery = false;
		v52.CastShadow = false;
		v52:PivotTo(v46);
		if v45 ~= nil then
			v52.Anchored = false;
			local l_WeldConstraint_0 = Instance.new("WeldConstraint");
			l_WeldConstraint_0.Part0 = v52;
			l_WeldConstraint_0.Part1 = v45;
			l_WeldConstraint_0.Parent = v52;
		else
			v52.Anchored = true;
		end;
		v52.Parent = v44;
		v7.emit(v52);
		task.delay(5, function() --[[ Line: 187 ]]
			-- upvalues: v52 (ref)
			v52:Destroy();
		end);
		if v42 ~= nil then
			for _, v55 in v42 do
				v5:PlaySound(v55, v46.Position, false);
			end;
		end;
		return function() --[[ Line: 197 ]]
			-- upvalues: v52 (ref)
			v52:Destroy();
		end;
	end, 
	resizeEffects = v13
};