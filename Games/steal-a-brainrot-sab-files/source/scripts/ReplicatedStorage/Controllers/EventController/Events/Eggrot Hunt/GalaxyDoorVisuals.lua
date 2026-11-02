
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Observers = require(ReplicatedStorage.Packages.Observers)
local TweenPivot = require(ReplicatedStorage.Shared.TweenPivot)
local Trove = require(ReplicatedStorage.Packages.Trove)
local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local tweenInfo2 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local color3 = Color3.fromRGB(0, 255, 0)
local color3_2 = Color3.fromRGB(255, 255, 255)
local t1 = {
	Start = function(_)
		local v12 = Trove.new()

		v12:Add(Observers.observeTag("EggrotGalaxyDoor", function(p2)
			if not p2:IsA("Model") then
				return nil
			end

			local v14 = Trove.new()
			local Pivot = p2:GetPivot()
			local v16 = Pivot - Vector3.new(0, p2:GetExtentsSize().Y * 1.5, 0)
			local u17 = nil

			local function animateTo(cFrame: CFrame)
				local v25 = u17

				if v25 then
					v25:Cancel()
				end

				local v26 = TweenPivot(p2, tweenInfo, cFrame)

				u17 = v26
				v26:Play()
			end
			local function onChanged()
				local v27 = if p2:GetAttribute("GalaxyDoorOpen") ~= true then Pivot else v16
				local v28 = u17

				if v28 then
					v28:Cancel()
				end

				local v29 = TweenPivot(p2, tweenInfo, v27)

				u17 = v29
				v29:Play()
			end

			if p2:GetAttribute("GalaxyDoorOpen") == true then
				p2:PivotTo(v16)
			end

			v14:Add(p2:GetAttributeChangedSignal("GalaxyDoorOpen"):Connect(onChanged))

			return function()
				local v30 = u17

				if v30 then
					v30:Cancel()
				end

				p2:PivotTo(Pivot)
				v14:Destroy()
			end
		end, { workspace }))
		v12:Add(Observers.observeTag("EggrotGalaxyNeon", function(p3)
			if not p3:IsA("BasePart") then
				return nil
			end

			local v21 = Trove.new()
			local u22 = nil

			local function onChanged()
				local v31 = u22

				if v31 then
					v31:Cancel()
				end

				local v32 = if p3:GetAttribute("GalaxyPadOccupied") ~= true then color3_2 else color3
				local tween = TweenService:Create(p3, tweenInfo2, {
					Color = v32
				})

				u22 = tween
				tween:Play()
			end

			p3.Color = if p3:GetAttribute("GalaxyPadOccupied") ~= true then color3_2 else color3
			v21:Add(p3:GetAttributeChangedSignal("GalaxyPadOccupied"):Connect(onChanged))

			return function()
				local v34 = u22

				if v34 then
					v34:Cancel()
				end

				p3.Color = color3_2
				v21:Destroy()
			end
		end, { workspace }))

		return function()
			v12:Destroy()
		end
	end
}

return table.freeze(t1)
