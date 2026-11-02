--credit to prince games studio
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local PlayerStateClient = require(ReplicatedStorage.ClientModules.PlayerStateClient)
local LocalPlayer = Players.LocalPlayer
local t = {
	Raccoon = "Raccoons"
}
local t2 = {}

local function getPetNameFromTool(p1) --[[ getPetNameFromTool | Line: 53 | Upvalues: t2 (copy) ]]
	if p1:GetAttribute("PetId") ~= nil then
		return nil
	end

	for v1, v2 in t2 do
		local v3 = p1:GetAttribute(v2)

		if type(v3) == "string" and v3 ~= "" then
			return v3
		end
	end

	return nil
end

local t3 = {
	StartOrder = 5
}
local v1 = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local t4 = {}
local t5 = {}

local function setUiEnabled(p1) --[[ setUiEnabled | Line: 94 | Upvalues: v1 (ref) ]]
	if not v1 then
		return
	end

	v1.Enabled = p1
end

local function getInventoryCount(p1) --[[ getInventoryCount | Line: 100 | Upvalues: t (copy), PlayerStateClient (copy) ]]
	local v1 = t[p1]

	if not v1 then
		return 0
	end

	local v2 = PlayerStateClient:GetLocalReplica()

	if not (v2 and v2.Data) then
		return 0
	end

	local Inventory = v2.Data.Inventory

	if type(Inventory) ~= "table" then
		return 0
	end

	local v3 = Inventory[v1]

	if type(v3) == "table" then
		return tonumber(v3[p1]) or 0
	end

	return 0
end

local function getFollowerCount(p1) --[[ getFollowerCount | Line: 118 | Upvalues: PlayerStateClient (copy) ]]
	local v1 = PlayerStateClient:GetLocalReplica()

	if not (v1 and v1.Data) then
		return 0
	end

	local Inventory = v1.Data.Inventory

	if type(Inventory) ~= "table" then
		return 0
	end

	local Pets = Inventory.Pets

	if type(Pets) == "table" then
		return tonumber(Pets[p1]) or 0
	end

	return 0
end

local function refreshUnequipVisibility() --[[ refreshUnequipVisibility | Line: 128 | Upvalues: v4 (ref), v6 (ref), PlayerStateClient (copy), t4 (copy) ]]
	if not v4 then
		return
	end

	if not v6 then
		v4.Visible = false

		return
	end

	local v1 = v6
	local v2 = PlayerStateClient:GetLocalReplica()
	local v3

	if v2 and v2.Data then
		local Inventory = v2.Data.Inventory

		if type(Inventory) == "table" then
			local Pets = Inventory.Pets

			v3 = type(Pets) == "table" and tonumber(Pets[v1]) or 0
		else
			v3 = 0
		end
	else
		v3 = 0
	end

	v4.Visible = (if v3 > 0 then v3 else t4[v6] or 0) > 0
end

local function refreshEquipVisibility() --[[ refreshEquipVisibility | Line: 147 | Upvalues: v3 (ref), v6 (ref), t (copy), PlayerStateClient (copy) ]]
	if not v3 then
		return
	end

	if not v6 then
		v3.Visible = false

		return
	end

	local v2 = v6
	local v32 = t[v2]
	local v4

	if v32 then
		local v5 = PlayerStateClient:GetLocalReplica()

		if v5 and v5.Data then
			local Inventory = v5.Data.Inventory

			if type(Inventory) == "table" then
				local v62 = Inventory[v32]

				v4 = type(v62) == "table" and tonumber(v62[v2]) or 0
			else
				v4 = 0
			end
		else
			v4 = 0
		end
	else
		v4 = 0
	end

	v3.Visible = if v4 > 0 then true else false
end

local function refreshButtonVisibility() --[[ refreshButtonVisibility | Line: 156 | Upvalues: v3 (ref), v6 (ref), t (copy), PlayerStateClient (copy), v4 (ref), t4 (copy) ]]
	if v3 and v6 then
		local v2 = v6
		local v32 = t[v2]
		local v42

		if v32 then
			local v5 = PlayerStateClient:GetLocalReplica()

			if v5 and v5.Data then
				local Inventory = v5.Data.Inventory

				if type(Inventory) == "table" then
					local v62 = Inventory[v32]

					v42 = type(v62) == "table" and tonumber(v62[v2]) or 0
				else
					v42 = 0
				end
			else
				v42 = 0
			end
		else
			v42 = 0
		end

		v3.Visible = if v42 > 0 then true else false
	elseif v3 then
		v3.Visible = false
	end

	if not v4 then
		return
	end

	if not v6 then
		v4.Visible = false

		return
	end

	local v9 = v6
	local v10 = PlayerStateClient:GetLocalReplica()
	local v11

	if v10 and v10.Data then
		local Inventory = v10.Data.Inventory

		if type(Inventory) == "table" then
			local Pets = Inventory.Pets

			v11 = type(Pets) == "table" and tonumber(Pets[v9]) or 0
		else
			v11 = 0
		end
	else
		v11 = 0
	end

	v4.Visible = (if v11 > 0 then v11 else t4[v6] or 0) > 0
end

local function setHeldPetTool(p1) --[[ setHeldPetTool | Line: 161 | Upvalues: v5 (ref), v6 (ref), getPetNameFromTool (copy), v1 (ref), v3 (ref), t (copy), PlayerStateClient (copy), v4 (ref), t4 (copy) ]]
	v5 = p1
	v6 = if p1 then getPetNameFromTool(p1) else nil

	if v6 then
		if v1 then
			v1.Enabled = true
		end

		if v3 and v6 then
			local v32 = v6
			local v42 = t[v32]
			local v52

			if v42 then
				local v62 = PlayerStateClient:GetLocalReplica()

				if v62 and v62.Data then
					local Inventory = v62.Data.Inventory

					if type(Inventory) == "table" then
						local v7 = Inventory[v42]

						v52 = type(v7) == "table" and tonumber(v7[v32]) or 0
					else
						v52 = 0
					end
				else
					v52 = 0
				end
			else
				v52 = 0
			end

			v3.Visible = if v52 > 0 then true else false
		elseif v3 then
			v3.Visible = false
		end

		if not v4 then
			return
		end

		if not v6 then
			v4.Visible = false

			return
		end

		local v10 = v6
		local v11 = PlayerStateClient:GetLocalReplica()
		local v122

		if v11 and v11.Data then
			local Inventory = v11.Data.Inventory

			if type(Inventory) == "table" then
				local Pets = Inventory.Pets

				v122 = type(Pets) == "table" and tonumber(Pets[v10]) or 0
			else
				v122 = 0
			end
		else
			v122 = 0
		end

		v4.Visible = (if v122 > 0 then v122 else t4[v6] or 0) > 0
	else
		if not v1 then
			return
		end

		v1.Enabled = false
	end
end

local function isPetTool(p1) --[[ isPetTool | Line: 173 | Upvalues: getPetNameFromTool (copy) ]]
	if not p1:IsA("Tool") then
		return false
	end

	return getPetNameFromTool(p1) ~= nil
end

function t3.Start(p1) --[[ Start | Line: 180 | Upvalues: LocalPlayer (copy), v1 (ref), v2 (ref), v3 (ref), v4 (ref), v6 (ref), Networking (copy), t (copy), PlayerStateClient (copy), t4 (copy), t5 (copy), v5 (ref), getPetNameFromTool (copy) ]]
	local EquipPet = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("EquipPet", 30)

	if not (EquipPet and EquipPet:IsA("ScreenGui")) then
		return
	end

	local Container = EquipPet:WaitForChild("Container", 10)

	if not (Container and Container:IsA("GuiObject")) then
		return
	end

	local EquipButton = Container:WaitForChild("EquipButton", 10)
	local UnequipButton = Container:WaitForChild("UnequipButton", 10)

	if not (EquipButton and EquipButton:IsA("GuiButton")) then
		return
	end

	if not (UnequipButton and UnequipButton:IsA("GuiButton")) then
		return
	end

	v1 = EquipPet
	v2 = Container
	v3 = EquipButton
	v4 = UnequipButton
	EquipPet.Enabled = false
	EquipButton.Visible = false
	UnequipButton.Visible = false
	EquipButton.Activated:Connect(function() --[[ Line: 220 | Upvalues: v6 (ref), Networking (ref) ]]
		if v6 then
			Networking.Pets.RequestEquipByName:Fire(v6)
		end
	end)
	UnequipButton.Activated:Connect(function() --[[ Line: 225 | Upvalues: v6 (ref), Networking (ref) ]]
		if v6 then
			Networking.Pets.RequestUnequipByName:Fire(v6)
		end
	end)
	task.spawn(function() --[[ Line: 235 | Upvalues: Networking (ref), v3 (ref), v6 (ref), t (ref), PlayerStateClient (ref), v4 (ref), t4 (ref), t5 (ref) ]]
		local ok, result = pcall(function() --[[ Line: 236 | Upvalues: Networking (ref) ]]
			return Networking.Pets.GetEquippedPets:Fire()
		end)

		if ok and type(result) == "table" then
			for v1, v2 in result do
				if type(v2) == "table" and (type(v2.Name) == "string" and type(v2.Id) == "string") then
					t4[v2.Name] = (t4[v2.Name] or 0) + 1
					t5[v2.Id] = v2.Name
				end
			end

			if v3 and v6 then
				local v5 = v6
				local v62 = t[v5]
				local v7

				if v62 then
					local v8 = PlayerStateClient:GetLocalReplica()

					if v8 and v8.Data then
						local Inventory = v8.Data.Inventory

						if type(Inventory) == "table" then
							local v9 = Inventory[v62]

							v7 = type(v9) == "table" and tonumber(v9[v5]) or 0
						else
							v7 = 0
						end
					else
						v7 = 0
					end
				else
					v7 = 0
				end

				v3.Visible = if v7 > 0 then true else false
			elseif v3 then
				v3.Visible = false
			end

			if not v4 then
				return
			end

			if not v6 then
				v4.Visible = false

				return
			end

			local v12 = v6
			local v13 = PlayerStateClient:GetLocalReplica()
			local v14

			if v13 and v13.Data then
				local Inventory = v13.Data.Inventory

				if type(Inventory) == "table" then
					local Pets = Inventory.Pets

					v14 = type(Pets) == "table" and tonumber(Pets[v12]) or 0
				else
					v14 = 0
				end
			else
				v14 = 0
			end

			v4.Visible = (if v14 > 0 then v14 else t4[v6] or 0) > 0
		else
			if v3 and v6 then
				local v21 = v6
				local v22 = t[v21]
				local v23

				if v22 then
					local v24 = PlayerStateClient:GetLocalReplica()

					if v24 and v24.Data then
						local Inventory = v24.Data.Inventory

						if type(Inventory) == "table" then
							local v25 = Inventory[v22]

							v23 = type(v25) == "table" and tonumber(v25[v21]) or 0
						else
							v23 = 0
						end
					else
						v23 = 0
					end
				else
					v23 = 0
				end

				v3.Visible = if v23 > 0 then true else false
			elseif v3 then
				v3.Visible = false
			end

			if not v4 then
				return
			end

			if not v6 then
				v4.Visible = false

				return
			end

			local v28 = v6
			local v29 = PlayerStateClient:GetLocalReplica()
			local v30

			if v29 and v29.Data then
				local Inventory = v29.Data.Inventory

				if type(Inventory) == "table" then
					local Pets = Inventory.Pets

					v30 = type(Pets) == "table" and tonumber(Pets[v28]) or 0
				else
					v30 = 0
				end
			else
				v30 = 0
			end

			v4.Visible = (if v30 > 0 then v30 else t4[v6] or 0) > 0
		end
	end)
	Networking.Pets.PetEquipped.OnClientEvent:Connect(function(p1, p2) --[[ Line: 255 | Upvalues: t5 (ref), t4 (ref), v3 (ref), v6 (ref), t (ref), PlayerStateClient (ref), v4 (ref) ]]
		if type(p1) ~= "string" or type(p2) ~= "table" then
			return
		end

		local v1 = p2.Name

		if type(v1) ~= "string" then
			return
		end

		if not t5[p1] then
			t5[p1] = v1
			t4[v1] = (t4[v1] or 0) + 1
		end

		if v3 and v6 then
			local v32 = v6
			local v42 = t[v32]
			local v5

			if v42 then
				local v62 = PlayerStateClient:GetLocalReplica()

				if v62 and v62.Data then
					local Inventory = v62.Data.Inventory

					if type(Inventory) == "table" then
						local v7 = Inventory[v42]

						v5 = type(v7) == "table" and tonumber(v7[v32]) or 0
					else
						v5 = 0
					end
				else
					v5 = 0
				end
			else
				v5 = 0
			end

			v3.Visible = if v5 > 0 then true else false
		elseif v3 then
			v3.Visible = false
		end

		if not v4 then
			return
		end

		if not v6 then
			v4.Visible = false

			return
		end

		local v10 = v6
		local v11 = PlayerStateClient:GetLocalReplica()
		local v12

		if v11 and v11.Data then
			local Inventory = v11.Data.Inventory

			if type(Inventory) == "table" then
				local Pets = Inventory.Pets

				v12 = type(Pets) == "table" and tonumber(Pets[v10]) or 0
			else
				v12 = 0
			end
		else
			v12 = 0
		end

		v4.Visible = (if v12 > 0 then v12 else t4[v6] or 0) > 0
	end)
	Networking.Pets.PetUnequipped.OnClientEvent:Connect(function(p1) --[[ Line: 269 | Upvalues: t5 (ref), t4 (ref), v3 (ref), v6 (ref), t (ref), PlayerStateClient (ref), v4 (ref) ]]
		if type(p1) ~= "string" then
			return
		end

		local v1 = t5[p1]

		if not v1 then
			return
		end

		t5[p1] = nil

		local v2 = (t4[v1] or 0) - 1

		t4[v1] = if v2 > 0 then v2 else nil

		if v3 and v6 then
			local v62 = v6
			local v7 = t[v62]
			local v8

			if v7 then
				local v9 = PlayerStateClient:GetLocalReplica()

				if v9 and v9.Data then
					local Inventory = v9.Data.Inventory

					if type(Inventory) == "table" then
						local v10 = Inventory[v7]

						v8 = type(v10) == "table" and tonumber(v10[v62]) or 0
					else
						v8 = 0
					end
				else
					v8 = 0
				end
			else
				v8 = 0
			end

			v3.Visible = if v8 > 0 then true else false
		elseif v3 then
			v3.Visible = false
		end

		if not v4 then
			return
		end

		if not v6 then
			v4.Visible = false

			return
		end

		local v13 = v6
		local v14 = PlayerStateClient:GetLocalReplica()
		local v15

		if v14 and v14.Data then
			local Inventory = v14.Data.Inventory

			if type(Inventory) == "table" then
				local Pets = Inventory.Pets

				v15 = type(Pets) == "table" and tonumber(Pets[v13]) or 0
			else
				v15 = 0
			end
		else
			v15 = 0
		end

		v4.Visible = (if v15 > 0 then v15 else t4[v6] or 0) > 0
	end)

	local function attachInventoryListener() --[[ attachInventoryListener | Line: 284 | Upvalues: PlayerStateClient (ref), v3 (ref), v6 (ref), t (ref), v4 (ref), t4 (ref) ]]
		local v1 = PlayerStateClient:GetLocalReplica()

		if v1 then
			v1:OnChange(function(p1, p2) --[[ Line: 287 | Upvalues: v3 (ref), v6 (ref), t (ref), PlayerStateClient (ref), v4 (ref), t4 (ref) ]]
				if type(p2) ~= "table" then
					return
				end

				if p2[1] ~= "Inventory" then
					return
				end

				if v3 and v6 then
					local v2 = v6
					local v32 = t[v2]
					local v42

					if v32 then
						local v5 = PlayerStateClient:GetLocalReplica()

						if v5 and v5.Data then
							local Inventory = v5.Data.Inventory

							if type(Inventory) == "table" then
								local v62 = Inventory[v32]

								v42 = type(v62) == "table" and tonumber(v62[v2]) or 0
							else
								v42 = 0
							end
						else
							v42 = 0
						end
					else
						v42 = 0
					end

					v3.Visible = if v42 > 0 then true else false
				elseif v3 then
					v3.Visible = false
				end

				if not v4 then
					return
				end

				if not v6 then
					v4.Visible = false

					return
				end

				local v9 = v6
				local v10 = PlayerStateClient:GetLocalReplica()
				local v11

				if v10 and v10.Data then
					local Inventory = v10.Data.Inventory

					if type(Inventory) == "table" then
						local Pets = Inventory.Pets

						v11 = type(Pets) == "table" and tonumber(Pets[v9]) or 0
					else
						v11 = 0
					end
				else
					v11 = 0
				end

				v4.Visible = (if v11 > 0 then v11 else t4[v6] or 0) > 0
			end)
		end
	end

	if PlayerStateClient:GetLocalReplica() then
		local v12 = PlayerStateClient:GetLocalReplica()

		if v12 then
			v12:OnChange(function(p1, p2) --[[ Line: 287 | Upvalues: v3 (ref), v6 (ref), t (ref), PlayerStateClient (ref), v4 (ref), t4 (ref) ]]
				if type(p2) ~= "table" then
					return
				end

				if p2[1] ~= "Inventory" then
					return
				end

				if v3 and v6 then
					local v2 = v6
					local v32 = t[v2]
					local v42

					if v32 then
						local v5 = PlayerStateClient:GetLocalReplica()

						if v5 and v5.Data then
							local Inventory = v5.Data.Inventory

							if type(Inventory) == "table" then
								local v62 = Inventory[v32]

								v42 = type(v62) == "table" and tonumber(v62[v2]) or 0
							else
								v42 = 0
							end
						else
							v42 = 0
						end
					else
						v42 = 0
					end

					v3.Visible = if v42 > 0 then true else false
				elseif v3 then
					v3.Visible = false
				end

				if not v4 then
					return
				end

				if not v6 then
					v4.Visible = false

					return
				end

				local v9 = v6
				local v10 = PlayerStateClient:GetLocalReplica()
				local v11

				if v10 and v10.Data then
					local Inventory = v10.Data.Inventory

					if type(Inventory) == "table" then
						local Pets = Inventory.Pets

						v11 = type(Pets) == "table" and tonumber(Pets[v9]) or 0
					else
						v11 = 0
					end
				else
					v11 = 0
				end

				v4.Visible = (if v11 > 0 then v11 else t4[v6] or 0) > 0
			end)
		end
	else
		PlayerStateClient:OnLocalReplica(function() --[[ Line: 298 | Upvalues: PlayerStateClient (ref), v3 (ref), v6 (ref), t (ref), v4 (ref), t4 (ref) ]]
			local v1 = PlayerStateClient:GetLocalReplica()

			if v1 then
				v1:OnChange(function(p1, p2) --[[ Line: 287 | Upvalues: v3 (ref), v6 (ref), t (ref), PlayerStateClient (ref), v4 (ref), t4 (ref) ]]
					if type(p2) ~= "table" then
						return
					end

					if p2[1] ~= "Inventory" then
						return
					end

					if v3 and v6 then
						local v2 = v6
						local v32 = t[v2]
						local v42

						if v32 then
							local v5 = PlayerStateClient:GetLocalReplica()

							if v5 and v5.Data then
								local Inventory = v5.Data.Inventory

								if type(Inventory) == "table" then
									local v62 = Inventory[v32]

									v42 = type(v62) == "table" and tonumber(v62[v2]) or 0
								else
									v42 = 0
								end
							else
								v42 = 0
							end
						else
							v42 = 0
						end

						v3.Visible = if v42 > 0 then true else false
					elseif v3 then
						v3.Visible = false
					end

					if not v4 then
						return
					end

					if not v6 then
						v4.Visible = false

						return
					end

					local v9 = v6
					local v10 = PlayerStateClient:GetLocalReplica()
					local v11

					if v10 and v10.Data then
						local Inventory = v10.Data.Inventory

						if type(Inventory) == "table" then
							local Pets = Inventory.Pets

							v11 = type(Pets) == "table" and tonumber(Pets[v9]) or 0
						else
							v11 = 0
						end
					else
						v11 = 0
					end

					v4.Visible = (if v11 > 0 then v11 else t4[v6] or 0) > 0
				end)
			end

			if v3 and v6 then
				local v32 = v6
				local v42 = t[v32]
				local v5

				if v42 then
					local v62 = PlayerStateClient:GetLocalReplica()

					if v62 and v62.Data then
						local Inventory = v62.Data.Inventory

						if type(Inventory) == "table" then
							local v7 = Inventory[v42]

							v5 = type(v7) == "table" and tonumber(v7[v32]) or 0
						else
							v5 = 0
						end
					else
						v5 = 0
					end
				else
					v5 = 0
				end

				v3.Visible = if v5 > 0 then true else false
			elseif v3 then
				v3.Visible = false
			end

			if not v4 then
				return
			end

			if not v6 then
				v4.Visible = false

				return
			end

			local v10 = v6
			local v11 = PlayerStateClient:GetLocalReplica()
			local v12

			if v11 and v11.Data then
				local Inventory = v11.Data.Inventory

				if type(Inventory) == "table" then
					local Pets = Inventory.Pets

					v12 = type(Pets) == "table" and tonumber(Pets[v10]) or 0
				else
					v12 = 0
				end
			else
				v12 = 0
			end

			local v14 = t4[v6] or 0
			local v16 = v4

			v16.Visible = (if v12 > 0 then v12 else v14) > 0
		end)
	end

	local function watchCharacter(p1) --[[ watchCharacter | Line: 307 | Upvalues: v5 (ref), v6 (ref), v1 (ref), v3 (ref), t (ref), PlayerStateClient (ref), v4 (ref), t4 (ref), getPetNameFromTool (ref) ]]
		v5 = nil
		v6 = nil

		if v6 then
			if v1 then
				v1.Enabled = true
			end

			if v3 and v6 then
				local v2 = v6
				local v32 = t[v2]
				local v42

				if v32 then
					local v52 = PlayerStateClient:GetLocalReplica()

					if v52 and v52.Data then
						local Inventory = v52.Data.Inventory

						if type(Inventory) == "table" then
							local v62 = Inventory[v32]

							v42 = type(v62) == "table" and tonumber(v62[v2]) or 0
						else
							v42 = 0
						end
					else
						v42 = 0
					end
				else
					v42 = 0
				end

				v3.Visible = if v42 > 0 then true else false
			elseif v3 then
				v3.Visible = false
			end

			if v4 and v6 then
				local v9 = v6
				local v10 = PlayerStateClient:GetLocalReplica()
				local v11

				if v10 and v10.Data then
					local Inventory = v10.Data.Inventory

					if type(Inventory) == "table" then
						local Pets = Inventory.Pets

						v11 = type(Pets) == "table" and tonumber(Pets[v9]) or 0
					else
						v11 = 0
					end
				else
					v11 = 0
				end

				v4.Visible = if (if v11 > 0 then v11 else t4[v6] or 0) > 0 then true else false
			elseif v4 then
				v4.Visible = false
			end
		elseif v1 then
			v1.Enabled = false
		end

		for v19, v20 in p1:GetChildren() do
			local v17, v18

			if if v20:IsA("Tool") then if getPetNameFromTool(v20) == nil then false else true else false then
				v5 = v20
				v6 = if v20 then getPetNameFromTool(v20) else nil

				if v6 then
					if v1 then
						v1.Enabled = true
					end

					if v3 and v6 then
						local v24 = v6
						local v25 = t[v24]

						if v25 then
							local v26 = PlayerStateClient:GetLocalReplica()

							if v26 and v26.Data then
								local Inventory = v26.Data.Inventory

								if type(Inventory) == "table" then
									local v27 = Inventory[v25]

									v17 = type(v27) == "table" and tonumber(v27[v24]) or 0
								else
									v17 = 0
								end
							else
								v17 = 0
							end
						else
							v17 = 0
						end

						v3.Visible = if v17 > 0 then true else false
					elseif v3 then
						v3.Visible = false
					end

					if v4 and v6 then
						local v30 = v6
						local v31 = PlayerStateClient:GetLocalReplica()

						if v31 and v31.Data then
							local Inventory = v31.Data.Inventory

							if type(Inventory) == "table" then
								local Pets = Inventory.Pets

								v18 = type(Pets) == "table" and tonumber(Pets[v30]) or 0
							else
								v18 = 0
							end
						else
							v18 = 0
						end

						v4.Visible = if (if v18 > 0 then v18 else t4[v6] or 0) > 0 then true else false
					elseif v4 then
						v4.Visible = false
					end
				elseif v1 then
					v1.Enabled = false
				end

				break
			end
		end

		p1.ChildAdded:Connect(function(p1) --[[ Line: 317 | Upvalues: getPetNameFromTool (ref), v5 (ref), v6 (ref), v1 (ref), v3 (ref), t (ref), PlayerStateClient (ref), v4 (ref), t4 (ref) ]]
			if not (if p1:IsA("Tool") then if getPetNameFromTool(p1) == nil then false else true else false) then
				return
			end

			v5 = p1
			v6 = if p1 then getPetNameFromTool(p1) else nil

			if v6 then
				if v1 then
					v1.Enabled = true
				end

				if v3 and v6 then
					local v42 = v6
					local v52 = t[v42]
					local v62

					if v52 then
						local v7 = PlayerStateClient:GetLocalReplica()

						if v7 and v7.Data then
							local Inventory = v7.Data.Inventory

							if type(Inventory) == "table" then
								local v8 = Inventory[v52]

								v62 = type(v8) == "table" and tonumber(v8[v42]) or 0
							else
								v62 = 0
							end
						else
							v62 = 0
						end
					else
						v62 = 0
					end

					v3.Visible = if v62 > 0 then true else false
				elseif v3 then
					v3.Visible = false
				end

				if not v4 then
					return
				end

				if not v6 then
					v4.Visible = false

					return
				end

				local v11 = v6
				local v122 = PlayerStateClient:GetLocalReplica()
				local v13

				if v122 and v122.Data then
					local Inventory = v122.Data.Inventory

					if type(Inventory) == "table" then
						local Pets = Inventory.Pets

						v13 = type(Pets) == "table" and tonumber(Pets[v11]) or 0
					else
						v13 = 0
					end
				else
					v13 = 0
				end

				v4.Visible = (if v13 > 0 then v13 else t4[v6] or 0) > 0
			else
				if not v1 then
					return
				end

				v1.Enabled = false
			end
		end)
		p1.ChildRemoved:Connect(function(p1) --[[ Line: 322 | Upvalues: v5 (ref), v6 (ref), v1 (ref), v3 (ref), t (ref), PlayerStateClient (ref), v4 (ref), t4 (ref) ]]
			if not v5 or p1 ~= v5 then
				return
			end

			v5 = nil
			v6 = nil

			if v6 then
				if v1 then
					v1.Enabled = true
				end

				if v3 and v6 then
					local v2 = v6
					local v32 = t[v2]
					local v42

					if v32 then
						local v52 = PlayerStateClient:GetLocalReplica()

						if v52 and v52.Data then
							local Inventory = v52.Data.Inventory

							if type(Inventory) == "table" then
								local v62 = Inventory[v32]

								v42 = type(v62) == "table" and tonumber(v62[v2]) or 0
							else
								v42 = 0
							end
						else
							v42 = 0
						end
					else
						v42 = 0
					end

					v3.Visible = if v42 > 0 then true else false
				elseif v3 then
					v3.Visible = false
				end

				if not v4 then
					return
				end

				if not v6 then
					v4.Visible = false

					return
				end

				local v9 = v6
				local v10 = PlayerStateClient:GetLocalReplica()
				local v11

				if v10 and v10.Data then
					local Inventory = v10.Data.Inventory

					if type(Inventory) == "table" then
						local Pets = Inventory.Pets

						v11 = type(Pets) == "table" and tonumber(Pets[v9]) or 0
					else
						v11 = 0
					end
				else
					v11 = 0
				end

				v4.Visible = (if v11 > 0 then v11 else t4[v6] or 0) > 0
			else
				if not v1 then
					return
				end

				v1.Enabled = false
			end
		end)
	end

	if LocalPlayer.Character then
		watchCharacter(LocalPlayer.Character)
	end

	LocalPlayer.CharacterAdded:Connect(watchCharacter)
end

return t3