local l_RunService_0 = game:GetService("RunService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v2 = true;
local v3 = {
    Red = Color3.fromRGB(255, 0, 0), 
    Yellow = Color3.fromRGB(255, 255, 0), 
    Green = Color3.fromRGB(0, 255, 0), 
    Cyan = Color3.fromRGB(0, 255, 255), 
    Blue = Color3.fromRGB(0, 0, 255), 
    Purple = Color3.fromRGB(255, 0, 255)
};
local v4 = {
    Color3.fromRGB(255, 0, 0), 
    Color3.fromRGB(255, 255, 0), 
    Color3.fromRGB(0, 255, 0), 
    Color3.fromRGB(0, 255, 255), 
    Color3.fromRGB(0, 0, 255), 
    Color3.fromRGB(255, 0, 255)
};
local v5 = {};
local function _(v6, v7, v8)
    return v6 + (v7 - v6) * v8;
end;
TimeLerp = function(v10, v11, v12, v13)
    local v14 = math.min(v12 / v13, 1);
    return v10 + (v11 - v10) * v14;
end;
local function v17(v15)
    v15:SetAttribute("ChromaLayer", v15.Texture);
    local l_v15_Attribute_0 = v15:GetAttribute("StaticLayer");
    if l_v15_Attribute_0 then
        v15.Color3 = Color3.fromRGB(255, 255, 255);
        v15.Texture = l_v15_Attribute_0;
        return;
    else
        v15.Color3 = Color3.fromRGB(255, 255, 255);
        v15.Texture = "rbxassetid://18363392181";
        return;
    end;
end;
local function _(v18)
    local l_v18_Attribute_0 = v18:GetAttribute("ChromaLayer");
    if l_v18_Attribute_0 then
        v18.Color3 = Color3.fromRGB(255, 0, 0);
        v18.Texture = l_v18_Attribute_0;
    end;
end;
local function v24()
    for v21, _ in v5 do
        if v21:IsA("Decal") then
            local l_v21_Attribute_0 = v21:GetAttribute("ChromaLayer");
            if l_v21_Attribute_0 then
                v21.Color3 = Color3.fromRGB(255, 0, 0);
                v21.Texture = l_v21_Attribute_0;
            end;
        end;
    end;
end;
local function v27()
    for v25, _ in v5 do
        if v25:IsA("Decal") then
            v17(v25);
        end;
    end;
end;
local function _(v28)
    return {
        R = v28.R * 255, 
        G = v28.G * 255, 
        B = v28.B * 255
    };
end;
GetColorDistance = function(v30, v31)
    local v32 = v30.R - v31.R;
    local v33 = v30.G - v31.G;
    local v34 = v30.B - v31.B;
    return (math.sqrt(v32 * v32 + v33 * v33 + v34 * v34));
end;
local function v37(v35)
    local v36 = v5[v35];
    return {
        R = 0, 
        B = 0, 
        G = 0, 
        R = TimeLerp(v36.StartColor.R, v36.TargetColor.R, os.clock() - v36.StartTime, 1), 
        G = TimeLerp(v36.StartColor.G, v36.TargetColor.G, os.clock() - v36.StartTime, 1), 
        B = TimeLerp(v36.StartColor.B, v36.TargetColor.B, os.clock() - v36.StartTime, 1)
    };
end;
local function _(v38, v39, v40)
    local v41 = v5[v38];
    local v42 = v3[v40];
    v41.StartColor = v39;
    v41.TargetColor = {
        R = v42.R * 255, 
        G = v42.G * 255, 
        B = v42.B * 255
    };
    v41.StartTime = os.clock();
    v41.State = v40;
end;
local function v44()
    v2 = not v2;
    if v2 then
        v24();
        return;
    else
        v27();
        return;
    end;
end;
local function v46(v45)
	if not v45:IsA("Decal") and not v45:IsA("Fire") and not v45:IsA("Part") and not v45:IsA("MeshPart") then
		return;
	elseif v5[v45] then
		return;
	else
		if not v2 and v45:IsA("Decal") then
			v17(v45);
		end;
		local startColor = v45:IsA("Decal") and Color3.fromRGB(255, 0, 0) or v45.Color
		v5[v45] = {
			Index = 1,
			StartColor = {
				R = startColor.R * 255,
				G = startColor.G * 255,
				B = startColor.B * 255
			},
			TargetColor = {
				R = startColor.R * 255,
				G = startColor.G * 255,
				B = startColor.B * 255
			},
			OriginalColor = startColor,
			StartTime = os.clock(),
			State = "Red"
		};
	end;
end

local function v48(v47)
    if not v47:IsA("Decal") and not v47:IsA("Fire") then
        return;
    else
        v5[v47] = nil;
        return;
    end;
end;
local v49 = os.clock();
local changeInterval = 0.6
local function v55(_)
	if not v2 then
		return;
	elseif os.clock() - v49 < 0.0333 then
		return;
	else
		v49 = os.clock();
		for v51, v52 in v5 do
			local isChromaPart = l_CollectionService_0:HasTag(v51, "ChromaPart")
			local v53 = nil
			if isChromaPart then
				if not v52.LastChangeTime then
					v52.LastChangeTime = 0
				end
				if os.clock() - v52.LastChangeTime >= changeInterval then
					local randomIndex = math.random(1, #v4)
					local newColor = v4[randomIndex]
					v53 = {
						R = newColor.R * 255,
						G = newColor.G * 255,
						B = newColor.B * 255
					}
					v52.StartColor = v53
					v52.TargetColor = v53
					v52.StartTime = os.clock()
					v52.LastChangeTime = os.clock()
					v52.Index = randomIndex
				else
					v53 = v52.StartColor
				end
			else
				v53 = v37(v51)
				if GetColorDistance(v53, v52.TargetColor) <= 1 then
					v52.Index = (v52.Index % #v4) + 1
					v52.StartColor = v53
					local v54 = v4[v52.Index]
					v52.TargetColor = {
						R = v54.R * 255,
						G = v54.G * 255,
						B = v54.B * 255
					}
					v52.StartTime = os.clock()
				end
			end
			if v51:IsA("Decal") then
				v51.Color3 = Color3.fromRGB(v53.R, v53.G, v53.B)
			elseif v51:IsA("Fire") then
				v51.Color = Color3.fromRGB(v53.R, v53.G, v53.B)
			elseif v51:IsA("Part") or v51:IsA("MeshPart") then
				v51.Color = Color3.fromRGB(v53.R, v53.G, v53.B)
			end
		end
	end
end


for _, v57 in l_CollectionService_0:GetTagged("ChromaDecal") do
    v46(v57);
end;
for _, v59 in l_CollectionService_0:GetTagged("ChromaFire") do
    v46(v59);
end;
for _, v61 in l_CollectionService_0:GetTagged("ChromaPart") do
	v46(v61);
end;
l_CollectionService_0:GetInstanceRemovedSignal("ChromaPart"):Connect(v48);
l_CollectionService_0:GetInstanceRemovedSignal("ChromaDecal"):Connect(v48);
l_CollectionService_0:GetInstanceRemovedSignal("ChromaFire"):Connect(v48);
l_CollectionService_0:GetInstanceAddedSignal("ChromaFire"):Connect(v46);
l_CollectionService_0:GetInstanceAddedSignal("ChromaDecal"):Connect(v46);
l_CollectionService_0:GetInstanceAddedSignal("ChromaPart"):Connect(v46);
script:WaitForChild("ToggleChromas").Event:Connect(v44);
l_RunService_0.PostSimulation:Connect(v55);