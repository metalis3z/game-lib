
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Shared.VirtualInstance)

local ServerData = require(ReplicatedStorage.Datas.ServerData)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local t1 = {
	AnimalOverhead = script.AnimalOverhead,
	CashPad = script.CashPad
}
local t2 = {
	[t1.AnimalOverhead] = {
		PhysicalSize = Vector3.new(15, 5, 0.10000000149011612),
		Ranges = {
			Close = {
				Distance = not ServerData.IsTsunamiServer() and 40 or 120,
				px = not ServerData.IsTsunamiServer() and 340 or 480
			},
			Standard = {
				Distance = not ServerData.IsTsunamiServer() and 80 or 240,
				px = not ServerData.IsTsunamiServer() and 220 or 340
			},
			Far = {
				Distance = 1e999,
				px = 10
			}
		}
	},
	[t1.CashPad] = {
		PhysicalSize = Vector3.new(5, 3, 0.10000000149011612),
		Ranges = {
			Close = {
				Distance = 40,
				px = 200
			},
			Standard = {
				Distance = 80,
				px = 100
			},
			Far = {
				Distance = 1e999,
				px = 10
			}
		}
	}
}

for _, v9 in t2 do
	local v10 = v9.PhysicalSize.Y / v9.PhysicalSize.X

	for _, v12 in v9.Ranges do
		v12.size = Vector2.new(v12.px, v12.px * v10)
	end
end

local _ = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local vector3 = Vector3.new(0, 1, 0)
local vector3_2 = Vector3.new(0, 0, 1)
local vector3_3 = Vector3.new(0, 0, 0)
local t3 = {}
local t4 = {}
local t5 = {}
local t6 = {}

return {
	GuiTemplates = t1,
	createFastOverhead = function(t7: {[any]: any})
		local v28 = if not t7.adornee:IsA("BasePart") then if not t7.adornee:IsA("Attachment") then error(`invalid adornee "{ t7.adornee }"`) else "Attachment" else "BasePart"
			local v29 = t2[t7.guiTemplate]
			local clone = script.FastOverheadTemplate:Clone()

			clone.CFrame = CFrame.new(0, 10000, 0)
			clone.Size = v29.PhysicalSize
			clone.Parent = workspace.Debris

			local __foh_transform = clone.__foh_transform

			if FFlags:GetInstant("FastOverhead.UseMotor6D", true) then
				__foh_transform.Part0 = workspace.Terrain
				__foh_transform.Part1 = clone
				clone.Anchored = false
			else
				__foh_transform:Destroy()
				__foh_transform = nil
			end

			local clone2 = t7.guiTemplate:Clone()

			clone2.Adornee = clone
			clone2.MaxDistance = v29.Ranges.Standard.Distance * 0.9
			clone2.Parent = clone

			local t8 = {
				adorneePosition = Vector3.new(0, 10000, 0),
				lastPositionCheck = -1,
				part = clone,
				motor6D = __foh_transform,
				gui = clone2,
				adornee = t7.adornee,
				adorneeType = v28,
				studsOffsetY = t7.studsOffsetY or 2.5,
				guiTemplate = t7.guiTemplate
			}

			table.insert(t3, t8)
			t4[clone2] = t8

			local u34 = nil
			local u35 = false

			local function cleanup()
				if u35 then
					return
				end

				u35 = true
				clone:Destroy()

				local v43 = table.find(t3, t8)

				if v43 then
					table.remove(t3, v43)
				end

				t4[clone2] = nil

				if u34 then
					u34:Disconnect()
					u34 = nil
				end
			end

			u34 = clone2.Destroying:Connect(cleanup)

			return clone2, cleanup
		end,
		setStudsOffsetY = function(p1, n1: number)
			local v39 = t4[p1]

			if v39 then
				v39.studsOffsetY = n1
			end
		end,
		Start = function(_)
			local function updatePositionsAndResolution()
				for _, v45 in t3 do
					local adornee = v45.adornee
					local adorneeType = v45.adorneeType
					local v48 = if adorneeType ~= "BasePart" then if adorneeType ~= "Attachment" then nil else adornee.WorldPosition else adornee.Position

						v45.adorneePosition = v48

						local Magnitude = (vector3_3 - v48).Magnitude
						local Ranges = t2[v45.guiTemplate].Ranges

						if Magnitude < Ranges.Close.Distance then
							v45.gui.CanvasSize = Ranges.Close.size
						elseif Magnitude < Ranges.Standard.Distance then
							v45.gui.CanvasSize = Ranges.Standard.size
						else
							v45.gui.CanvasSize = Ranges.Far.size
						end
					end
				end
				local function updateOverheads()
					for _, v52 in t3 do
						local v53 = v52.adorneePosition + vector3 * v52.studsOffsetY
						local v54 = CFrame.lookAlong(v53, -vector3_2)

						if v52.motor6D then
							v52.motor6D.Transform = v54
						elseif v54 ~= v52.lastCFrame then
							table.insert(t5, v52.part)
							table.insert(t6, v54)
							v52.lastCFrame = v54
						end
					end

					if #t5 > 0 then
						workspace:BulkMoveTo(t5, t6, Enum.BulkMoveMode.FireCFrameChanged)
						table.clear(t5)
						table.clear(t6)
					end
				end

				RunService.Stepped:Connect(function(_)
					local CurrentCameraCFrame = CurrentCamera.CFrame

					vector3_2 = CurrentCameraCFrame.LookVector
					vector3 = CurrentCameraCFrame.UpVector
					vector3_3 = CurrentCameraCFrame.Position
					updatePositionsAndResolution()
					updateOverheads()
				end)
			end
}
