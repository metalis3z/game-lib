-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw
local v0 = {};
local v1 = require(game.ReplicatedStorage.Database.Sync);
local function v10(v2, v3) --[[ Line: 5 ]] --[[ Name: applyEffect ]]
    if not game.ServerScriptService:FindFirstChild("GameScript") then
        return;
    else
        local v4 = require(game.ReplicatedStorage.Database.Sync.Effects);
        if v4[v2] ~= nil and v2 ~= "None" and v2 ~= "Dual" then
            local l_FirstChild_0 = game.ServerStorage.Database.Effects:FindFirstChild(v2);
            if l_FirstChild_0 then
                for _, v7 in pairs(l_FirstChild_0:GetChildren()) do
                    v7:Clone().Parent = v3.Handle;
                end;
                return;
            else
                local l_status_0, l_result_0 = pcall(function() --[[ Line: 17 ]]
                    -- upvalues: v4 (copy), v2 (copy), v3 (copy)
                    require(v4[v2].KnifeModule)(v3);
                end);
                if not l_status_0 then
                    warn("Error loading effect: " .. tostring(l_result_0));
                end;
            end;
        end;
        return;
    end;
end;
function GetSyncData(DataType)
	if DataType == "Weapons" then DataType = "Item" end
	return require(game.ReplicatedStorage.Database.Sync:FindFirstChild(DataType))
end
local function v25(Player, Character, ItemName, ItemType)
	local LowerTorso = Character:WaitForChild("LowerTorso", 10)
	if not LowerTorso then return end

	local UpperTorso = Character:WaitForChild("UpperTorso", 10)
	if not UpperTorso then return end

	local ItemsDB = GetSyncData("Item")
	local ItemTemplate = game.ServerStorage.Database.Item[ItemName] or game.ServerStorage.Default[ItemType]
	if not ItemTemplate then return end

	local ItemClone = ItemTemplate:Clone()

	if ItemType == "Knife" then
		local EquippedEffect = Player:GetAttribute("EquippedEffect")
		if EquippedEffect then
			pcall(function()
				require(game.ServerStorage.Database.Effects[EquippedEffect])(ItemClone)
			end)
		end
	end
	if ItemType == "Gun" then
		local Handle = ItemClone:FindFirstChild("Handle")
		if not Handle then return end
		Handle.CanCollide = false
		Handle.Massless = true
		Handle.CFrame = UpperTorso.CFrame

		local Weld = Instance.new("Weld")
		Weld.Part0 = UpperTorso
		Weld.Part1 = Handle
		local GunRotation = ItemsDB[ItemName] and ItemsDB[ItemName]["Angles"]
		if GunRotation then
			Weld.C0 = CFrame.new(1.26,-1.5,0.2) * CFrame.Angles(GunRotation.X, GunRotation.Y, GunRotation.Z)
		else
			Weld.C0 = CFrame.new(1.26,-1.5,0.2) * CFrame.Angles(math.rad(150),0,0)
		end
		Weld.C1 = CFrame.new()
		Weld.Parent = UpperTorso

		Handle.Name = "GunDisplay"
		Handle.Parent = Character
		ItemClone:Destroy()
		return Handle
	end

	local function dAngles(Data)
		return CFrame.Angles(Data.X,Data.Y,Data.Z)
	end

	local function dOffset(Data)
		return CFrame.new(Data.X,Data.Y,Data.Z)
	end
	for _, part in ipairs(ItemClone:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CanCollide = false
			part.Massless = true
			part.CanTouch = false
			part.CanQuery = false
			part.CustomPhysicalProperties = PhysicalProperties.new(0.001, 0, 0)
		end
	end
	local Handle = ItemClone:FindFirstChild("Handle")
	if not Handle then return end
	Handle.CanCollide = false
	Handle.Massless = true
	Handle.CFrame = UpperTorso.CFrame
	local HasRadio, CanUseRadio = _G.CheckRadio(Player)
	local UseRadio = (HasRadio and CanUseRadio)
	local RotationData = ItemsDB[ItemName] and ItemsDB[ItemName]["Angles"]
	local PositionData = ItemsDB[ItemName] and ItemsDB[ItemName]["Offset"]
	local RadioRotation = ItemsDB[ItemName] and ItemsDB[ItemName]["RadioAngles"]
	local RadioOffset = ItemsDB[ItemName] and ItemsDB[ItemName]["RadioOffset"]

	local DefaultRotation, DefaultPosition

	if not UseRadio then
		DefaultRotation = (RotationData and dAngles(RotationData)) or CFrame.Angles(-math.pi/2, math.pi/4, math.pi/2)
		DefaultPosition = (PositionData and dOffset(PositionData)) or CFrame.new(-0.1, 0, 0.5)
	else
		DefaultPosition = (RadioOffset and dOffset(RadioOffset)) or CFrame.new(-1.2, -1.3, 0.25)
		DefaultRotation = (RadioRotation and dAngles(RadioRotation)) 
			or ((RotationData and CFrame.Angles(math.rad(-60), 0, math.rad(180)) * dAngles(RotationData)) 
				or CFrame.Angles(math.rad(-60), 0, math.rad(180)))
	end
	local Weld = Instance.new("Weld")
	Weld.Part0 = UpperTorso
	Weld.Part1 = Handle
	Weld.C0 = DefaultPosition * DefaultRotation
	Weld.C1 = CFrame.new()
	Weld.Parent = UpperTorso
	Handle.Name = ItemType.."Display"
	Handle.Parent = Character
	ItemClone:Destroy()

	return Handle
end

local function v38(v26, v27) --[[ Line: 80 ]] --[[ Name: attachRadio ]]
    -- upvalues: v1 (copy)
    if not _G.CheckRadio(v26) then
        return;
    else
        local l_v26_Attribute_0 = v26:GetAttribute("EquippedRadio");
        if not l_v26_Attribute_0 then
            return;
        else
            local l_FirstChild_1 = game.ServerStorage.Database.Radios:FindFirstChild(l_v26_Attribute_0);
            local v30 = nil;
            if l_FirstChild_1 then
                v30 = l_FirstChild_1:Clone();
            end;
            if not v30 then
                return;
            else
                if not v30 then
                    v30 = game.ServerStorage.Default.Radio:Clone();
                end;
                local v31 = v1.Radios[l_v26_Attribute_0];
                local l_UpperTorso_0 = v27.UpperTorso;
                local l_Offset_0 = v31.Offset;
                local l_Rotation_0 = v31.Rotation;
                v30.Anchored = false;
                v30.CanCollide = false;
                v30.Massless = true;
                v30.CustomPhysicalProperties = PhysicalProperties.new(0.001, 0, 0);
                v30.Material = "SmoothPlastic";
                v30.Name = "Radio";
                local v35 = Instance.new("Weld", l_UpperTorso_0);
                v35.Part0 = l_UpperTorso_0;
                v35.Part1 = v30;
                v35.C0 = CFrame.new(l_Offset_0.X, l_Offset_0.Y - 0.2, l_Offset_0.Z) * CFrame.Angles(l_Rotation_0.X, l_Rotation_0.Y, l_Rotation_0.Z);
                v30.Parent = v27;
                for _, v37 in v30:GetChildren() do
                    if v37:IsA("BasePart") then
                        v37.CanCollide = false;
                        v37.Massless = true;
                        v37.CustomPhysicalProperties = PhysicalProperties.new(1.0E-4, 0, 0);
                    end;
                end;
                return;
            end;
        end;
    end;
end;
v0.AttachItems = function(_, v40, v41) --[[ Line: 130 ]] --[[ Name: AttachItems ]]
    -- upvalues: v38 (copy), v25 (copy)
    local v42 = v40:GetAttribute("EquippedKnife") or "DefaultKnife";
    local v43 = v40:GetAttribute("EquippedGun") or "DefaultGun";
    script.KnifeBack:Clone().Parent = v41.UpperTorso;
    script.KnifeBelt:Clone().Parent = v41.LowerTorso;
    script.GunBelt:Clone().Parent = v41.LowerTorso;
    v38(v40, v41);
    v25(v40, v41, v42, "Knife");
    v25(v40, v41, v43, "Gun");
end;
return v0;