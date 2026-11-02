local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("CollectionService")
local v_u_3 = game:GetService("TweenService")
game:GetService("RunService")
game:GetService("Lighting")
game:GetService("Players")
require(v1.Shared.EventTypes)
local v4 = {}
require(v1.Controllers.AnimalController)
local v_u_5 = require(v1.Controllers.SoundController)
local v_u_6 = require(v1.Controllers.EventController)
require(v1.Controllers.CycleController)
local v_u_7 = require(v1.Utils.TimeUtils)
local v_u_8 = require(v1.Packages.Observers)
local v_u_9 = require(v1.Packages.Trove)
local v_u_10 = require(v1.Packages.Timer)
local v11 = require(v1.Packages.Net)
local v_u_12 = require(v1.Shared.VFX)
local v_u_13 = v11:RemoteEvent("EventService/Bubblegum/RollAnimation")
local v_u_14 = v11:RemoteEvent("EventService/Bubblegum/EmitBurst")
local v_u_15 = script.Name
local v_u_16 = v_u_9.new()
function v4.OnStart(_)
	local v_u_17 = v_u_6:GetActiveEventData(v_u_15)
	assert(v_u_17)
	v_u_16:Add(v_u_8.observeTag("BubblegumMachine", function(p_u_18)
		return v_u_8.observeAttribute(p_u_18, "Hidden", function(p19)
			if p19 then
				return nil
			end
			local v_u_20 = p_u_18.Tank.BillboardGui.DisplayText
			local v21 = v_u_9.new()
			local v_u_22 = {}
			for _, v23 in v_u_2:GetTagged("BubbleGumProgress") do
				if v23:IsA("BasePart") and not v_u_22[v23] then
					v_u_22[v23] = {
						["Position"] = v23.Position
					}
				end
			end
			v_u_12.emit(p_u_18.Vfx.Goal)
			v21:Add(task.spawn(function()
				v_u_5:PlaySound("Sounds.Sfx.Bubblegum Machine.Apply", p_u_18.Goal.Position)
			end))
			v21:Add(task.spawn(function()
				v_u_5:PlaySound("Sounds.Sfx.Bubblegum Machine.Deactivation", p_u_18.Goal.Position)
			end))
			v21:Add(v_u_10.Simple(1, function()
				local v24 = v_u_17.endsAt - workspace:GetServerTimeNow()
				local v25 = math.max(v24, 0)
				v_u_20.Text = v_u_7:E(v25)
				if v_u_22 then
					local v26 = v25 / 600
					local v27 = math.clamp(v26, 0, 1)
					local v28 = math.lerp(0, 7.3, v27)
					for v29, v30 in v_u_22 do
						local v31 = (v28 - 7.3) / 2
						local v32 = v29.Size.X
						local v33 = v29.Size.Y
						v29.Size = Vector3.new(v32, v33, v28)
						v29.Position = v30.Position + Vector3.new(0, 0, 1) * v31
					end
				end
			end, true))
			return v21:WrapClean()
		end)
	end))
end
function v4.OnStop(_)
	v_u_16:Destroy()
end
function v4.OnLoad(_)
	v_u_14.OnClientEvent:Connect(function(p34)
		if not p34:GetAttribute("Hidden") then
			v_u_12.emit(p34.Vfx.bubblegumburst)
		end
	end)
	v_u_13.OnClientEvent:Connect(function(p35)
		local v_u_36 = Instance.new("NumberValue")
		for _, v_u_37 in { p35.Circle1, p35.Circle2 } do
			v_u_36.Changed:Connect(function(p38)
				v_u_37.CFrame = CFrame.new(v_u_37.CFrame.Position) * CFrame.Angles(0, -1.5707963267948966, p38)
			end)
		end
		local v39 = v_u_3:Create(v_u_36, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["Value"] = 6.283185307179586
		})
		v39.Completed:Once(function()
			v_u_36:Destroy()
		end)
		v39:Play()
	end)
end
return v4