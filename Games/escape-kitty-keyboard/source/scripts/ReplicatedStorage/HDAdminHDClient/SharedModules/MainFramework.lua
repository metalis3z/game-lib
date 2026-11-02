

local v1 = script
local v2 = require(v1.Reference)
local v3 = v2.getObject()
local v4
if v3 then
	v4 = v3.Value
else
	v4 = v3
end
if v4 and v4 ~= v1 then
	warn("Two HD Admin applications attempted to initialize. Consider deleting one.")
	return require(game:GetService("ReplicatedStorage"):WaitForChild("HDAdminSetup")):GetMain()
end
if not v3 then
	v2.addToReplicatedStorage()
end
local u9 = setmetatable({}, {
	["__index"] = function(p5, p6) 
		local v7, v8 = pcall(game.GetService, game, p6:sub(1, 1):upper() .. p6:sub(2))
		if v7 then
			p5[p6] = v8
			return v8
		end
	end
})
function u9.Initialize(_, p10, p11) 

	if u9.alreadyInitialized then
		return
	end
	u9.alreadyInitialized = true
	u9.rs = game:GetService("ReplicatedStorage")
	u9.ss = game:GetService("ServerStorage")
	u9.sss = game:GetService("ServerScriptService")
	if p10 == "Server" then
		u9.mainModule = script:FindFirstAncestor("MainModule")
		u9.server = u9.mainModule.HDServer
		u9.client = u9.mainModule.HDClient
		u9.workspaceFolder = Instance.new("Folder")
		u9.workspaceFolder.Name = "HDAdminWorkspaceFolder"
		u9.workspaceFolder.Parent = workspace
		local v12 = u9.server.Assets:WaitForChild("SettingsCopy", 1000)
		if v12 then
			u9.settings = require(v12)
		end
		local v13 = require(p11:FindFirstChild("Settings", true))
		if v13 then
			for v14, v15 in pairs(v13) do
				local v16 = false
				if typeof(v15) == "table" then
					for v17, _ in pairs(v15) do
						v16 = tonumber(v17) == nil and true or v16
						break
					end
				end
				if v16 then
					local v18 = u9.settings[v14]
					if typeof(v18) ~= "table" then
						v18 = {}
						u9.settings[v14] = v18
					end
					for v19, v20 in pairs(v15) do
						v18[v19] = v20
					end
				else
					u9.settings[v14] = v15
				end
			end
		end
		local v21 = p11:FindFirstChild("CustomFeatures", true)
		local v22 = p11:FindFirstChild("Config")
		if v22 then
			if not v21 then
				v21 = Instance.new("Configuration")
				v21.Name = "CustomFeatures"
				v21.Parent = p11
			end
			local v23 = v22:FindFirstChild("Commands")
			if v23 then
				for _, v24 in pairs(v23:GetChildren()) do
					local v25 = v24.Name
					local v26 = v21:FindFirstChild(v25)
					if not v26 then
						v26 = Instance.new("Folder")
						v26.Name = v25
						v26.Parent = v21
					end
					local v27 = v26:FindFirstChild("Modules")
					if not v27 then
						v27 = Instance.new("Folder")
						v27.Name = "Modules"
						v27.Parent = v26
					end
					local v28 = v25 == "Client" and "ClientCommands" or "Commands"
					local v29 = v24:Clone()
					v29.Name = v28
					v29.Parent = v27
				end
			end
		end
		local function v40(p30, p31) 

			local v32 = string.lower(p31 == "Client" and p31 and p31 or "Server")
			local v33 = p30.Name
			local v34 = u9[v32]:FindFirstChild(v33)
			if v34 and (v33 ~= "client" and v33 ~= "server") then
				for _, v35 in pairs(p30:GetChildren()) do
					local v36 = v34:FindFirstChild(v35.Name)
					if v36 and not v36:IsA("ModuleScript") then
						v36:Destroy()
					end
					local v37 = v35.Name
					local v38 = v37 == "ClientCommands"
					if v36 and (v37 == "Commands" or v38) then
						local v39 = Instance.new("ObjectValue")
						v39.Name = "CommandsToMerge"
						v39.Value = v35
						v39.Parent = v36
						if v38 then
							v35.Name = "CustomClientCommands"
							v35.Parent = v34
						end
					else
						v35.Parent = v34
					end
				end
			end
		end
		if p11 then
			p11 = p11:FindFirstChild("Core")
		end
		if p11 then
			local v41 = p11:FindFirstChildOfClass("PackageLink")
			local v42 = p11:FindFirstChild("MainModule")
			if v41 and (v42 and #v42:GetChildren() > 0) then
				workspace:GetAttribute("HD")
			end
		end
		if v21 then
			for _, v43 in pairs(v21:GetChildren()) do
				v40(v43)
				local v44 = v43.Name
				for _, v45 in pairs(v43:GetChildren()) do
					v40(v45, v44)
				end
			end
		end
		local u46 = {
			["HDClient"] = u9.rs,
			["HDServer"] = u9.ss
		}
		local u47 = {
			["HDAdminStarterCharacter"] = u9.starterPlayer.StarterCharacterScripts,
			["HDAdminInterface"] = u9.starterGui,
			["Preload"] = u9.replicatedFirst
		}
		local function v52(p48) 

			local v49 = p48.Name
			local v50 = u46[v49] or u47[v49]
			if v50 and not v50:FindFirstChild(v49) then
				if u46[v49] then
					p48.Name = "HDAdmin" .. v49
					p48.Parent = v50
					return
				end
				if u47[v49] then
					local v51 = p48:Clone()
					v51.Parent = v50
					if v51:IsA("LocalScript") then
						v51.Disabled = false
					end
				end
			end
		end
		for _, v53 in pairs(u9.mainModule:GetChildren()) do
			v52(v53)
			for _, v54 in pairs(v53:GetChildren()) do
				v52(v54)
				for _, v55 in pairs(v54:GetChildren()) do
					v52(v55)
				end
			end
		end
		local v56 = u9.server.Assets.SetupQuickJoiners
		for _, v57 in pairs(u9.players:GetChildren()) do
			v56:Clone().Parent = v57.PlayerGui
		end
		task.defer(function()

			local v58 = Instance.new("Folder")
			v58.Name = "HDAdminMapBackup"
			v58.Parent = u9.ss
			u9.client.Signals.Initialized.Event:Wait()
			if u9.settings.AutoSaveMap == true then
				u9:GetModule("cf"):SaveMap()
			end
		end)
	elseif p10 == "Client" then
		u9.client = u9.rs:WaitForChild("HDAdminHDClient")
		for _, _ in pairs(u9.client:GetChildren()) do

		end
		u9.workspaceFolder = workspace:WaitForChild("HDAdminWorkspaceFolder")
		u9.player = game:GetService("Players").LocalPlayer
		u9.playerGui = u9.player:WaitForChild("PlayerGui")
		u9.gui = u9.playerGui:WaitForChild("HDAdminInterface", 1000)
		local v59 = u9
		local v60 = u9.gui
		if v60 then
			v60 = u9.gui:WaitForChild("MainFrame", 1000)
		end
		v59.mainFrame = v60
		u9.templates = u9.gui:WaitForChild("Templates")
		u9.warnings = u9.gui.MainFrame:WaitForChild("Warnings")
		u9.camera = workspace.CurrentCamera
		task.wait()
		u9.tablet = false
		if u9.guiService:IsTenFootInterface() then
			u9.device = "Console"
		elseif u9.userInputService.TouchEnabled and not u9.userInputService.MouseEnabled then
			u9.device = "Mobile"
		else
			u9.device = "Computer"
		end
		if u9.gui.AbsoluteSize.Y < 1 then
			repeat
				wait()
			until u9.gui.AbsoluteSize.Y > 0
		end
		if u9.device == "Mobile" then
			local v61 = u9.gui.AbsoluteSize.X
			local v62 = u9.gui.AbsoluteSize.Y
			if math.min(v61, v62) >= 650 then
				u9.tablet = true
			end
		end
		local v63 = nil
		for _ = 1, 50 do
			local v64
			v64, v63 = pcall(function()

				return u9.client.Signals.RetrieveData:InvokeServer()
			end)
			if v64 and v63 then
				break
			end
			wait(1)
		end
		for v65, v66 in pairs(v63) do
			u9[v65] = v66
		end
	end
	os.date("*t", os.time())
	u9.hdAdminCoreName = "System"
	u9.modules = {}
	u9.coreFolder = u9[string.lower(p10)]
	u9.moduleGroup = u9.coreFolder.Modules
	u9.sharedModules = u9.client.SharedModules
	u9.signals = u9.client.Signals
	u9.audio = u9.client.Audio
	local u67 = {}
	function u9.GetModule(_, p68) 

		if not u9.modules[p68] then
			local v69 = {
				["name"] = p68,
				["addedSignal"] = Instance.new("BindableEvent")
			}
			u67[#u67 + 1] = v69
			v69.addedSignal.Event:Wait()
		end
		return u9.modules[p68]
	end
	function u9.loadModule(p70) 

		if not u9.modules[p70] then
			local v71 = {
				["name"] = p70,
				["addedSignal"] = Instance.new("BindableEvent")
			}
			u67[#u67 + 1] = v71
			v71.addedSignal.Event:Wait()
		end
		return u9.modules[p70]
	end
	local u72 = {}
	for v73, v74 in pairs({
		["cf"] = { "ClientCoreFunctions", "SharedCoreFunctions", "ServerCoreFunctions" },
		["API"] = { "ClientAPI", "ServerAPI", "SharedAPI" }
	}) do
		for _, v75 in pairs(v74) do
			u72[v75] = v73
		end
	end
	local u76 = false
	local u77 = Instance.new("BindableEvent")
	local function v78() 

		if not u76 then
			u76 = true
			u77:Fire()
			u77:Destroy()
		end
	end
	task.delay(10, v78)
	local u79 = 0
	local function v108(p80, u81) 

		for _, u82 in pairs(p80:GetDescendants()) do
			if u82:IsA("ModuleScript") and u82.Name ~= script.Name then
				u79 = u79 + 1
				task.defer(function()

					local v83 = u82.Name
					local v84 = u72[v83] or v83
					local v85, v86 = pcall(function()

						return require(u82)
					end)
					if v85 then
						if u81[v84] then
							local v87 = u81[v84]
							for v88, v89 in pairs(v86) do
								if tonumber(v88) then
									table.insert(v87, v89)
								else
									v87[v88] = v89
								end
							end
						else
							local v90 = u82:FindFirstChild("CommandsToMerge")
							if v90 then
								local v91 = u82.Name == "Commands"
								local v92 = require(v90.Value)
								local v93 = {}
								for v96, v95 in v86 do
									if v91 then
										local v96 = v95.Name or v96
									end
									local v97 = tostring(v96):lower()
									local v98 = {}
									if typeof(v98) == "table" then
										for _, v99 in v98 do
											v93[tostring(v99):lower()] = v95
										end
									end
									v93[v97] = v95
								end
								for v102, v101 in v92 do
									if v91 then
										local v102 = v101.Name or v102
									end
									local v103 = v93[tostring(v102):lower()]
									if v103 then
										for v104, v105 in pairs(v101) do
											v103[v104] = v105
										end
									elseif v91 then
										table.insert(v86, v101)
									else
										v86[v102] = v101
									end
								end
							end
							u81[v84] = v86
							for v106 = #u67, 1, -1 do
								local v107 = u67[v106]
								if v107 and v107.name == v84 then
									table.remove(u67, v106)
									v107.addedSignal:Fire()
								end
							end
						end
					else
						warn("HD Admin Module Error | " .. u82.Name .. " | " .. tostring(v86))
					end
					u79 = u79 - 1
					if u79 == 0 and not u76 then
						u76 = true
						u77:Fire()
						u77:Destroy()
					end
				end)
			end
		end
	end
	require(script.MainVariables):SetupMainVariables(p10)
	v108(u9.moduleGroup, u9.modules)
	v108(u9.sharedModules, u9.modules)
	if not u76 then
		u77.Event:Wait()
	end
	if p10 == "Server" then
		u9.server.Assets:WaitForChild("HDAdminSetup").Parent = u9.rs
		if not u9.ownerName then
			u9.ownerName = u9:GetModule("cf"):GetName(u9.ownerId)
		end
		u9:GetModule("CommandHandler"):Setup()
		u9:GetModule("LoaderHandler"):Setup()
	end
	u9.initialized = true
	u9.client.Signals.Initialized:Fire()
end
function u9.CheckInitialized(_) 

	if not u9.initialized then
		script.Parent.Parent:WaitForChild("Signals"):WaitForChild("Initialized").Event:Wait()
	end
	return u9
end
_G.HDAdminMain = u9
return u9