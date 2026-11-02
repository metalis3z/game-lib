-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Player = require(ReplicatedStorage.Library.Player)
local PlotCmds = require(ReplicatedStorage.Library.Client.PlotCmds)

require(ReplicatedStorage.Library.Types.Plots)

local Streamable = require(ReplicatedStorage.Library.Modules.Packages.Streamable).Streamable
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local PlotSignHomeButtonFade = require(script.Parent.Parent.Parent.GUI.PlotSignHomeButtonFade)
local LocalPlayer = Players.LocalPlayer
local v1 = Trove.new()
local t = {}
local t2 = {}

local function clearRemotePlotSignBinding(p1) --[[ clearRemotePlotSignBinding | Line: 36 | Upvalues: t2 (copy) ]]
	local v1 = t2[p1]

	if v1 ~= nil then
		v1:Destroy()
	end
end

local function bindRemotePlotSign(p1, p2) --[[ bindRemotePlotSign | Line: 45 | Upvalues: t2 (copy), LocalPlayer (copy), Players (copy), PlotCmds (copy), Trove (copy), Streamable (copy), t (copy) ]]
	local v1 = t2[p1]

	if v1 ~= nil then
		v1:Destroy()
	end

	if p2 == nil or p2 == LocalPlayer.UserId then
		return
	end

	local v2 = Players:GetPlayerByUserId(p2)

	if v2 == nil then
		return
	end

	local v3 = PlotCmds.GetPlotData(v2)

	if v3 ~= nil then
		local v4 = Trove.new()

		t2[p1] = v4
		v4:Add(function() --[[ Line: 64 | Upvalues: t2 (ref), p1 (copy), v4 (copy) ]]
			if t2[p1] ~= v4 then
				return
			end

			t2[p1] = nil
		end)

		local v5 = Streamable.new(v3.PlotFolder, "PlotSign")

		v4:Add(function() --[[ Line: 71 | Upvalues: v5 (copy) ]]
			v5:Destroy()
		end)
		v4:Add(v5:Observe(function(p12, p2) --[[ Line: 74 | Upvalues: Streamable (ref), v3 (copy), t (ref), p1 (copy) ]]
			local v1 = Streamable.new(p12, "PlayerPlotSign")

			p2:Add(function() --[[ Line: 76 | Upvalues: v1 (copy) ]]
				v1:Destroy()
			end)
			p2:Add(v1:Observe(function(p12) --[[ Line: 79 | Upvalues: v3 (ref), t (ref), p1 (ref) ]]
				assert(p12:IsA("BillboardGui"), "PlayerPlotSign must be a BillboardGui")

				local t2 = {
					PetArea = v3.PetArea,
					PlayerPlotSign = p12
				}

				t[p1] = t2

				return function() --[[ Line: 88 | Upvalues: t (ref), p1 (ref), t2 (copy), p12 (copy) ]]
					if t[p1] == t2 then
						t[p1] = nil
					end

					if p12.Parent == nil then
						return
					end

					p12.AlwaysOnTop = false
				end
			end))
		end))
	end
end

local function rebindAllRemotePlotSigns() --[[ rebindAllRemotePlotSigns | Line: 100 | Upvalues: t2 (copy), PlotCmds (copy), bindRemotePlotSign (copy) ]]
	local list = {}

	for k in pairs(t2) do
		list[#list + 1] = k
	end

	for i, v in ipairs(list) do
		local v1 = t2[v]

		if v1 ~= nil then
			v1:Destroy()
		end
	end

	for k, v in pairs(PlotCmds.GetState()) do
		bindRemotePlotSign(k, v)
	end
end

local function updateRemotePlotSigns() --[[ updateRemotePlotSigns | Line: 114 | Upvalues: Player (copy), LocalPlayer (copy), t (copy) ]]
	local v1 = Player.Optional.HumanoidRootPart(LocalPlayer)
	local v2 = if v1 == nil then nil else v1.Position

	for k, v in pairs(t) do
		local v3, v4
		local PlayerPlotSign = v.PlayerPlotSign

		if PlayerPlotSign.Parent ~= nil then
			local PetArea = v.PetArea

			if v2 == nil or PetArea.Parent == nil then
				v3 = false
			else
				local v5 = PetArea.CFrame:PointToObjectSpace(v2)
				local v6 = PetArea.Size * 0.5

				v4 = if math.abs(v5.X) <= v6.X then math.abs(v5.Z) <= v6.Z else false
				v3 = v4
			end

			if PlayerPlotSign.AlwaysOnTop ~= v3 then
				PlayerPlotSign.AlwaysOnTop = v3
			end
		end
	end
end

local function updateYourBaseTracker(p1) --[[ updateYourBaseTracker | Line: 136 | Upvalues: v1 (copy), Streamable (copy), PlotSignHomeButtonFade (copy), LocalPlayer (copy), RunService (copy) ]]
	v1:Clean()

	if p1 then
		local CenterPoint = p1.CenterPoint
		local v12 = Streamable.new(p1.PlotFolder, "PlotSign")

		v1:Add(function() --[[ Line: 144 | Upvalues: v12 (copy) ]]
			v12:Destroy()
		end)
		v1:Add(v12:Observe(function(p1, p2) --[[ Line: 147 | Upvalues: Streamable (ref), PlotSignHomeButtonFade (ref), LocalPlayer (ref), CenterPoint (copy), RunService (ref) ]]
			local v1 = Streamable.new(p1, "SignUI")

			p2:Add(function() --[[ Line: 149 | Upvalues: v1 (copy) ]]
				v1:Destroy()
			end)
			p2:Add(v1:Observe(function(p1) --[[ Line: 152 ]]
				assert(p1:IsA("BillboardGui"), "SignUI must be a BillboardGui")

				local Enabled = p1.Enabled

				p1.Enabled = false

				return function() --[[ Line: 158 | Upvalues: p1 (copy), Enabled (copy) ]]
					if p1.Parent == nil then
						return
					end

					p1.Enabled = Enabled
				end
			end))

			local v2 = Streamable.new(p1, "Attachment")

			p2:Add(function() --[[ Line: 166 | Upvalues: v2 (copy) ]]
				v2:Destroy()
			end)
			p2:Add(v2:Observe(function(p1, p2) --[[ Line: 169 | Upvalues: Streamable (ref), PlotSignHomeButtonFade (ref), LocalPlayer (ref), CenterPoint (ref), RunService (ref) ]]
				local v1 = Streamable.new(p1, "YourBase")

				p2:Add(function() --[[ Line: 171 | Upvalues: v1 (copy) ]]
					v1:Destroy()
				end)
				p2:Add(v1:Observe(function(p1) --[[ Line: 174 | Upvalues: PlotSignHomeButtonFade (ref), p2 (copy), LocalPlayer (ref), CenterPoint (ref), RunService (ref) ]]
					assert(p1:IsA("BillboardGui"), "YourBase must be a BillboardGui")

					local v2 = PlotSignHomeButtonFade.new(p1)

					p2:Add(function() --[[ Line: 177 | Upvalues: v2 (copy) ]]
						v2:Destroy()
					end)

					local function updateDistance() --[[ updateDistance | Line: 181 | Upvalues: LocalPlayer (ref), v2 (copy), p1 (copy), CenterPoint (ref) ]]
						local Character = LocalPlayer.Character
						local v1 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

						if not (v1 and v1:IsA("BasePart")) then
							v2:SetVisible(false)

							return
						end

						p1.MaxDistance = 300
						v2:SetVisible((v1.Position - CenterPoint.Position).Magnitude > 50)
					end

					updateDistance()

					return RunService.Heartbeat:Connect(updateDistance)
				end))
			end))
		end))
	end
end

updateYourBaseTracker(PlotCmds.GetPlotData())
PlotCmds.OnLocalPlotUpdated:Connect(function() --[[ Line: 203 | Upvalues: updateYourBaseTracker (copy), PlotCmds (copy) ]]
	updateYourBaseTracker(PlotCmds.GetPlotData())
end)
rebindAllRemotePlotSigns()
PlotCmds.OnAnyPlotUpdated:Connect(bindRemotePlotSign)
PlotCmds.OnPlotsFolderUpdated:Connect(rebindAllRemotePlotSigns)
Players.PlayerAdded:Connect(rebindAllRemotePlotSigns)
Players.PlayerRemoving:Connect(function(p1) --[[ Line: 211 | Upvalues: PlotCmds (copy), t2 (copy) ]]
	for k, v in pairs(PlotCmds.GetState()) do
		if v == p1.UserId then
			local v1 = t2[k]

			if v1 ~= nil then
				v1:Destroy()
			end
		end
	end
end)
RunService.Heartbeat:Connect(updateRemotePlotSigns)