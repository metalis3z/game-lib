-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = game:GetService("RunService")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Players")
local v_u_4 = game:GetService("TestService")
local v_u_5 = v1:IsServer()
if v_u_5 then
	v_u_5 = game:GetService("ServerScriptService")
end
local v_u_6 = require(v_u_2.Modules.Network)
local v_u_7 = getfenv().version()
local v_u_8 = require(script.Logo)
local v_u_9 = table.freeze({
	[(not workspace:GetAttribute("Testing")) and game.PlaceId or 0] = "PROD",
	[workspace:GetAttribute("Testing") and game.PlaceId or 0] = "INDEV",
})
local v_u_10 = table.insert
local v_u_11 = os.clock
local v_u_12 = v1:IsClient()
local v_u_13 = v1:IsServer()
local v_u_14 = 0
local v_u_15 = {}
local v_u_16 = 0
local v_u_17 = ""
local v_u_18 = {}
v_u_18.__index = v_u_18
local function v_u_20(p19)
	warn((("[%*]: %*"):format(script, p19)))
end
local function v_u_25(p_u_21, p_u_22, ...)
	-- upvalues: (copy) v_u_20
	assert(p_u_21, "bad moduleInfo, must be a table")
	--local v23, v24 = pcall(function(...)
		-- upvalues: (copy) p_u_21, (copy) p_u_22
		if p_u_21[p_u_22] then
			return p_u_21[p_u_22](p_u_21, ...)
		end
	--end, ...)
	--if not v23 then
	--	v_u_20((("Failed to call :%*() due to: %*"):format(p_u_22, v24)))
	--end
	--return v24
end
function v_u_18.Debug(_, _) end
function v_u_18.LoadModules(_, p26, p_u_27)
	-- upvalues: (copy) v_u_18, (copy) v_u_25, (copy) v_u_11, (ref) v_u_14, (ref) v_u_15, (copy) v_u_10, (ref) v_u_16, (ref) v_u_17
	if v_u_18[p_u_27] then
		for v28, v29 in v_u_18[p_u_27] do
			v_u_25(v29, "Destroy")
			v_u_18[p_u_27][v28] = nil
		end
	end
	local function v_u_50(p30)
		-- upvalues: (ref) v_u_18, (copy) v_u_50, (ref) v_u_11, (copy) p_u_27, (ref) v_u_14, (ref) v_u_15, (ref) v_u_10, (ref) v_u_16
		local v31
		if p30 then
			v31 = p30:IsA("Folder")
		else
			v31 = p30
		end
		assert(v31, "bad moduleFolder, must be Folder.")
		for _, v32 in p30:GetChildren() do
			if not v32:GetAttribute("NoInitializing") then
				if v32:IsA("Folder") then
					local v33 = v_u_18
					local v34 = v32.Parent
					v33:Debug((("Loading directory: %*/%*... [%*]"):format(tostring(v34), tostring(v32), #v32:GetChildren())))
					v_u_50(v32)
					local v35 = v_u_18
					local v36 = v32.Parent
					v35:Debug((("Finished loading directory: %*/%*! [%*]"):format(tostring(v36), tostring(v32), #v32:GetChildren())))
				else
					local v37 = v_u_11()
					local v38, v39 = pcall(require, v32)
					if v38 then
						v_u_18[p_u_27][v32.Name] = v39
						local v40 = v_u_18
						local v41 = v32.Parent
						local v42 = tostring(v41)
						local v43 = tostring(v32)
						local v44 = v_u_11() - v37
						v40:Debug((("--> [\226\156\133] Required %*/%* in %* seconds! [%*]"):format(v42, v43, tostring(v44), v_u_14 + 1)))
					else
						local v45 = v_u_18
						local v46 = v32.Parent
						local v47 = tostring(v46)
						local v48 = tostring(v32)
						local v49 = v_u_11() - v37
						v45:Debug((("--> [\226\157\140] Failed to require %*/%* in %* seconds! [%*]"):format(v47, v48, tostring(v49), v_u_14 + 1)))
					end
					v_u_14 = v_u_14 + 1
					if v_u_11() - v37 > 1 then
						v_u_10(v_u_15, { tostring(v32:GetFullName()), v_u_11() - v37 })
						v_u_16 = v_u_16 + 1
					end
				end
			end
		end
	end
	local function v55(p51)
		-- upvalues: (ref) v_u_18, (copy) p_u_27, (ref) v_u_11, (ref) v_u_25, (ref) v_u_15, (ref) v_u_10, (ref) v_u_16
		for v52, v53 in v_u_18[p_u_27] do
			if v53[p51] then
				v_u_18:Debug((("--> Calling :%*() on %*..."):format(p51, v52)))
				local v54 = v_u_11()
				v_u_25(v53, p51)
				if v_u_11() - v54 > 1 then
					v_u_10(v_u_15, { v52, v_u_11() - v54 })
					v_u_16 = v_u_16 + 1
				end
			end
		end
	end
	v_u_50(p26)
	v55("Init")
	v55("Start")
	v_u_18:Debug((("Finished loading modules in %* [%*]"):format(p_u_27, v_u_14)))
	if #v_u_15 > 0 then
		for v56 = 1, #v_u_15 do
			local v57 = v_u_15[v56]
			v_u_17 = v_u_17 .. ("\n%* loaded after: %* seconds!"):format(v57[1], v57[2])
			v_u_15[v56] = nil
		end
		v_u_15 = {}
	end
end
function v_u_18.Initialize(_)
	-- upvalues: (copy) v_u_18, (copy) v_u_12, (copy) v_u_3, (copy) v_u_13, (copy) v_u_11, (copy) v_u_2, (copy) v_u_5, (ref) v_u_14, (copy) v_u_7, (copy) v_u_9, (ref) v_u_16, (ref) v_u_17, (copy) v_u_4, (copy) v_u_8, (copy) v_u_6
	local v58 = v_u_18
	setmetatable({}, v58)
	if v_u_12 then
		local v59 = v_u_3.LocalPlayer
		v_u_18.Player = v59
		v_u_18.Character = v59.Character or v59.CharacterAdded:Wait()
		v_u_18.PlayerSystems = {}
		v_u_18.CharacterSystems = {}
	end
	v_u_18.Modules = {}
	if v_u_13 then
		v_u_18.ServerSystems = {}
		v_u_18.MiscServerSystems = {}
	end
	local v60 = v_u_11()
	v_u_18:Debug((("Starting to load Aeternus%* systems..."):format(v_u_13 and "Server" or "Client")))
	v_u_18:LoadModules(v_u_2:WaitForChild("Modules"), "Modules")
	if v_u_13 then
		local v61 = v_u_5.Server.Systems
		local v62 = v_u_5.Server.Miscellaneous
		v_u_18:LoadModules(v61, "ServerSystems")
		v_u_18:LoadModules(v62, "MiscServerSystems")
	end
	if v_u_12 then
		local v63 = v_u_2:WaitForChild("Systems")
		local v64 = v63:WaitForChild("Player")
		local v_u_65 = v63:WaitForChild("Character")
		v_u_18:LoadModules(v64, "PlayerSystems")
		v_u_18:LoadModules(v_u_65, "CharacterSystems")
		v_u_18.Player.CharacterAdded:Connect(function(_)
			-- upvalues: (ref) v_u_18, (copy) v_u_65, (ref) v_u_14
			local v66 = v_u_18.Player.PlayerGui:FindFirstChild("TemporaryUI")
			if v66 then
				v66:ClearAllChildren()
			end
			v_u_18.Character = v_u_18.Player.Character
			v_u_18:LoadModules(v_u_65, "CharacterSystems")
			v_u_14 = 0
		end)
	end
	v_u_18.Loaded = true
	local v67 = v_u_2:WaitForChild("VersionInfo")
	v_u_4:Message("\n" .. v_u_8 .. ("\n\n%*\n\n%*\n%*\n%*\n%*\n%*\n%*"):format(("Successfully compiled the Aeternus%* framework!"):format(v_u_13 and "Server" or "Client"), ("Total time to compile: %* seconds"):format((string.format("%.2f", v_u_11() - v60))), ("Total Components loaded: %*"):format(v_u_14), ("Roblox Version: %*"):format(v_u_7), ("Branch: %*"):format(v_u_9[game.PlaceId] or "NOT_FOUND"), v67.Updated.Value == "" and "" or (("Release: %* | %* %*\n"):format(v67.Updated.Value, v67.PlaceVersion.Value, v67.IsOutdated.Value and "(Outdated)" or "(Latest)") or ""), (("There was %* module(s) that went past the threshold %* second(s):%*"):format(v_u_16, 1, v_u_17))))
	v_u_14 = 0
	if v_u_12 then
		task.delay(2.5, function()
			-- upvalues: (ref) v_u_6
			v_u_6:FireServerConnection("PlayerLoaded", "REMOTE_EVENT")
		end)
	end
end
return v_u_18
