--[[
  Angelus Decompiles
  Owner: Chlorls & imoRR

  Includes: Script & GUI
  StarterGui: >>> DELETE ME <<< Delete This Gui
  Discord: discord.gg/nDWm6PkFrT
--]]

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = require(v1.Packages.Observers)
local v_u_4 = require(v1.Packages.Spr)
local v5 = v2.LocalPlayer.PlayerGui
local v6 = {}
local v_u_7 = workspace.CurrentCamera
local v_u_8 = v5:WaitForChild("DuelsMachinePrompt").DuelsMachinePrompt
local v_u_9 = {}
local function v_u_14()
	-- upvalues: (copy) v_u_8, (copy) v_u_9, (copy) v_u_4
	local v10 = v_u_8.AbsoluteSize.Y
	if v10 > 0 then
		local v11 = 0.01
		for _, v12 in v_u_9 do
			if v12.frame then
				local v13 = v12.frame.AbsoluteSize.Y
				v_u_4.target(v12.frame, 1, 5, {
					["Position"] = UDim2.fromScale(1, 1 - v11)
				})
				v11 = v11 + (v13 / v10 + 0.01)
			end
		end
	end
end
function v6.Add(_, p_u_15)
	-- upvalues: (copy) v_u_9, (copy) v_u_8, (copy) v_u_14, (copy) v_u_4
	local v_u_16 = false
	local v_u_17 = {
		["frame"] = p_u_15
	}
	local v18 = v_u_9
	table.insert(v18, v_u_17)
	p_u_15.Parent = v_u_8
	p_u_15.Position = UDim2.fromScale(1.3, 1)
	v_u_14()
	return function()
		-- upvalues: (ref) v_u_16, (ref) v_u_9, (copy) v_u_17, (ref) v_u_4, (copy) p_u_15, (ref) v_u_14
		if v_u_16 then
			return
		else
			v_u_16 = true
			local v19 = table.find(v_u_9, v_u_17)
			if v19 then
				table.remove(v_u_9, v19)
				v_u_4.target(p_u_15, 1, 5, {
					["Position"] = UDim2.fromScale(1, 1.2)
				})
				task.delay(1, function()
					-- upvalues: (ref) p_u_15
					p_u_15:Destroy()
				end)
				v_u_14()
			end
		end
	end
end
function v6.Start(_)
	-- upvalues: (copy) v_u_8, (copy) v_u_3, (copy) v_u_7, (copy) v_u_14
	local v_u_20 = nil
	local function v_u_21()
		-- upvalues: (ref) v_u_20, (ref) v_u_8
		if v_u_20 then
			v_u_8.AnchorPoint = Vector2.new(0.5, 1)
			v_u_8.Position = UDim2.fromScale(0.5, 1) + UDim2.fromOffset(0, v_u_20.Position.Y.Offset)
		else
			v_u_8.AnchorPoint = Vector2.new(0.5, 0.5)
			v_u_8.Position = UDim2.fromScale(0.5, 1)
		end
	end
	v_u_3.observeTag("JumpButton", function(p_u_22)
		-- upvalues: (ref) v_u_20, (copy) v_u_21
		v_u_20 = p_u_22
		local v_u_23 = p_u_22:GetPropertyChangedSignal("Position"):Connect(v_u_21)
		v_u_21()
		return function()
			-- upvalues: (copy) v_u_23, (ref) v_u_20, (copy) p_u_22, (ref) v_u_21
			v_u_23:Disconnect()
			if v_u_20 == p_u_22 then
				v_u_20 = nil
				v_u_21()
			end
		end
	end)
	local v_u_24 = nil
	v_u_7:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		-- upvalues: (ref) v_u_24, (ref) v_u_14
		if v_u_24 and coroutine.status(v_u_24) == "suspended" then
			task.cancel(v_u_24)
		end
		v_u_24 = task.delay(0.1, function()
			-- upvalues: (ref) v_u_24, (ref) v_u_14
			v_u_24 = nil
			v_u_14()
		end)
	end)
end
return v6