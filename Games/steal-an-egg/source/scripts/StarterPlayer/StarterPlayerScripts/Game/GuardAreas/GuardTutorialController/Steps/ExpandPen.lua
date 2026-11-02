-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

require(ReplicatedStorage.Library.Client.GuardTutorialPresentationComponent)
require(script.Parent.Types.Interface)

local SurfaceGuiButton = require(ReplicatedStorage.Library.Client.UI.SurfaceGuiButton)
local v1 = Color3.fromRGB(255, 255, 255)
local t = {
	StepId = "ExpandPen"
}

local function shouldPresent(p1) --[[ shouldPresent | Line: 31 ]]
	return p1:CanAffordFirstBaseExpansion() and not p1:IsLocalPlayerInGameplay()
end

function t.IsSatisfied(p1) --[[ IsSatisfied | Line: 39 ]]
	return p1:HasFinishedFirstBaseExpansion()
end
function t.Bind(p1, p2) --[[ Bind | Line: 43 | Upvalues: t (copy), RunService (copy) ]]
	local v1 = 0
	local v2 = false

	local function refresh() --[[ refresh | Line: 47 | Upvalues: v2 (ref), t (ref), p1 (copy), p2 (copy) ]]
		if not v2 and t.IsSatisfied(p1) then
			v2 = true
			p2()
		end
	end

	local v3 = p1.Changed:Connect(refresh)
	local v4 = RunService.Heartbeat:Connect(function(p12) --[[ Line: 56 | Upvalues: v1 (ref), v2 (ref), t (ref), p1 (copy), p2 (copy) ]]
		v1 = v1 + p12

		if not (v1 >= 0.1) then
			return
		end

		v1 = 0

		if v2 then
			return
		end

		if not t.IsSatisfied(p1) then
			return
		end

		v2 = true
		p2()
	end)

	task.defer(refresh)

	return function() --[[ Line: 65 | Upvalues: v3 (copy), v4 (copy) ]]
		v3:Disconnect()
		v4:Disconnect()
	end
end
function t.Present(p1, p2) --[[ Present | Line: 71 | Upvalues: t (copy), SurfaceGuiButton (copy), v1 (copy), RunService (copy) ]]
	local v12 = 0
	local v2 = false
	local v3 = false
	local v4 = nil

	local function clear() --[[ clear | Line: 80 | Upvalues: v2 (ref), v3 (ref), v4 (ref), p1 (copy) ]]
		if v2 then
			v2 = false
			v3 = false
			v4 = nil
			p1:ClearAll()
		end
	end

	local function refresh() --[[ refresh | Line: 90 | Upvalues: t (ref), p2 (copy), v2 (ref), v3 (ref), v4 (ref), p1 (copy), SurfaceGuiButton (ref), v1 (ref) ]]
		if not t.IsSatisfied(p2) then
			local v12 = p2
			local v22 = v12:CanAffordFirstBaseExpansion()

			if if v22 then not v12:IsLocalPlayerInGameplay() else v22 then
				local v42 = p2:GetPlotUpgradeSignTarget()

				if v42 == nil then
					if v2 then
						v2 = false
						v3 = false
						v4 = nil
						p1:ClearAll()
					end
				else
					if v2 and v4 == v42 then
						if v3 then
							return
						end

						local v5 = SurfaceGuiButton.Get(v42, "FirstUpgrade")

						if v5 == nil then
							return
						end

						p1:ShowTap(v5, true)
					else
						v2 = true
						v4 = v42
						p1:ShowAnimatedMessage("Upgrade your Pen!", v1)
						p1:ShowBeam(v42.Position + Vector3.new(0, -1, 0))

						local v6 = SurfaceGuiButton.Get(v42, "FirstUpgrade")

						if v6 == nil then
							return
						end

						p1:ShowTap(v6, true)
					end

					v3 = true
				end

				return
			end
		end

		if v2 then
			v2 = false
			v3 = false
			v4 = nil
			p1:ClearAll()
		end
	end

	local v5 = p2.Changed:Connect(refresh)
	local v6 = RunService.Heartbeat:Connect(function(p1) --[[ Line: 124 | Upvalues: v12 (ref), refresh (copy) ]]
		v12 = v12 + p1

		if not (v12 >= 0.1) then
			return
		end

		v12 = 0
		refresh()
	end)

	refresh()

	return function() --[[ Line: 133 | Upvalues: v5 (copy), v6 (copy), v2 (ref), v3 (ref), v4 (ref), p1 (copy) ]]
		v5:Disconnect()
		v6:Disconnect()

		if v2 then
			v2 = false
			v3 = false
			v4 = nil
			p1:ClearAll()
		end
	end
end

return t