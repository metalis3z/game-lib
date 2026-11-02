-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local PlayerMorphCommand = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("PlayerMorphCommand")
local AdminPanel = script:FindFirstAncestor("AdminPanel")
local AdminCooldownClient = require(AdminPanel:WaitForChild("AdminCooldownClient"))
local v1 = script.Parent.Parent
local MorphName = v1:FindFirstChild("MorphName")
local ChatName = v1:FindFirstChild("ChatName")
local Verified = v1:FindFirstChild("Verified")
local Spawn = v1:FindFirstChild("Spawn")
local Unmorph = v1:FindFirstChild("Unmorph")
local v2 = nil

local function showNotif(p1, p2) --[[ showNotif | Line: 16 | Upvalues: v2 (ref) ]]
	if not v2 then
		local AdminPanel = script:FindFirstAncestor("AdminPanel")
		local v1 = if AdminPanel then AdminPanel:FindFirstChild("NotifModule") else AdminPanel

		if v1 then
			local ok, result = pcall(require, v1)

			if ok then
				v2 = result
			end
		end
	end

	if not v2 then
		return
	end

	v2(p1, p2 ~= false)
end

local v3 = false

local function trim(p1) --[[ trim | Line: 27 ]]
	if typeof(p1) == "string" then
		return p1:gsub("^%s+", ""):gsub("%s+$", "")
	end

	return ""
end

local function buildPayload() --[[ buildPayload | Line: 32 | Upvalues: MorphName (copy), ChatName (copy), Verified (copy) ]]
	local t = {
		Action = "Apply"
	}
	local v1

	if MorphName then
		local Text = MorphName.Text

		v1 = if typeof(Text) == "string" then Text:gsub("^%s+", ""):gsub("%s+$", "") else ""

		if not v1 then
			v1 = ""
		end
	else
		v1 = ""
	end

	t.MorphName = v1

	local v3

	if ChatName then
		local Text = ChatName.Text

		v3 = if typeof(Text) == "string" then Text:gsub("^%s+", ""):gsub("%s+$", "") else ""

		if not v3 then
			v3 = ""
		end
	else
		v3 = ""
	end

	t.ChatName = v3

	local v5

	if Verified then
		local Text = Verified.Text

		v5 = if typeof(Text) == "string" then Text:gsub("^%s+", ""):gsub("%s+$", "") else ""

		if not v5 then
			v5 = ""
		end
	else
		v5 = ""
	end

	t.Verified = v5

	return t
end

if Spawn then
	Spawn.MouseButton1Click:Connect(function() --[[ Line: 42 | Upvalues: v3 (ref), buildPayload (copy), showNotif (copy), AdminCooldownClient (copy), PlayerMorphCommand (copy) ]]
		if v3 then
			return
		end

		local v1 = buildPayload()

		if v1.MorphName == "" and (v1.ChatName == "" and v1.Verified == "") then
			showNotif("Fill at least one field", false)

			return
		end

		if AdminCooldownClient:Try("PlayerMorph") then
			v3 = true
			PlayerMorphCommand:FireServer(v1)
			task.delay(0.3, function() --[[ Line: 55 | Upvalues: v3 (ref) ]]
				v3 = false
			end)
		end
	end)
end

if Unmorph then
	Unmorph.MouseButton1Click:Connect(function() --[[ Line: 60 | Upvalues: v3 (ref), PlayerMorphCommand (copy), MorphName (copy), ChatName (copy), Verified (copy) ]]
		if v3 then
			return
		end

		v3 = true
		PlayerMorphCommand:FireServer({
			Action = "Reset"
		})

		if MorphName then
			MorphName.Text = ""
		end

		if ChatName then
			ChatName.Text = ""
		end

		if not Verified then
			task.delay(0.3, function() --[[ Line: 68 | Upvalues: v3 (ref) ]]
				v3 = false
			end)

			return
		end

		Verified.Text = ""
		task.delay(0.3, function() --[[ Line: 68 | Upvalues: v3 (ref) ]]
			v3 = false
		end)
	end)
end

PlayerMorphCommand.OnClientEvent:Connect(function(p1) --[[ Line: 72 | Upvalues: showNotif (copy) ]]
	if typeof(p1) ~= "table" then
		return
	end

	if typeof(p1.message) ~= "string" then
		return
	end

	if p1.success == false then
		warn("[PlayerMorph] " .. p1.message)
		showNotif(p1.message, false)

		return
	end

	print("[PlayerMorph] " .. p1.message)
	showNotif(p1.message, true)
end)