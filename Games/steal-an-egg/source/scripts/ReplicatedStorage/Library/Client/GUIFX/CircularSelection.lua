-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local Library = ReplicatedStorage:WaitForChild("Library")
local Assets = ReplicatedStorage:WaitForChild("Assets")
local Functions = require(Library.Functions)
local Variables = require(Library.Variables)
local CreateDial = require(script.Parent.CreateDial)
local ConsoleCmds = require(Library.Client.ConsoleCmds)
local t2 = {
	Normal = { "rbxassetid://13744994506", "rbxassetid://13745368416" },
	Huge = { "rbxassetid://15276476580", "rbxassetid://15276518483" }
}
local t3 = { 0.2, Enum.EasingStyle.Circular, Enum.EasingDirection.Out }

local function getDialQuantity(p1) --[[ getDialQuantity | Line: 45 ]]
	return p1:GetAttribute("Quantity") or 0
end

local function isDialTracking(p1) --[[ isDialTracking | Line: 49 ]]
	return p1:GetAttribute("Tracking") == true
end

local function isSelectionShowing(p1) --[[ isSelectionShowing | Line: 53 ]]
	return p1:GetAttribute("Showing") == true
end

task.spawn(function() --[[ Line: 57 | Upvalues: ContentProvider (copy), t2 (copy) ]]
	ContentProvider:PreloadAsync(t2.Normal)
	ContentProvider:PreloadAsync(t2.Huge)
end)
function t.Add(p1, p2, p3, p4, p5, p6) --[[ Add | Line: 62 | Upvalues: Assets (copy), Functions (copy), t3 (copy), Variables (copy), t2 (copy), CreateDial (copy), UserInputService (copy), ConsoleCmds (copy), GuiService (copy) ]]
	local v1 = p2 or 1
	local v2 = p3 or 1
	local t = {
		selected = false,
		selectable = true,
		quantity = 0
	}
	local v3 = false
	local v4 = Assets.UI.Items.Select:Clone()

	v4.Parent = p1

	local t4 = {}
	local v5 = nil
	local v6 = nil
	local v7 = nil
	local v8 = nil
	local v9 = nil
	local v10 = false

	local function updateCallback(p1) --[[ updateCallback | Line: 95 | Upvalues: v3 (ref), v5 (ref), t (copy), v8 (ref), p4 (copy) ]]
		if v3 then
			return
		end

		if v5 then
			t.quantity = v5:GetAttribute("Quantity") or 0
		elseif t.selected then
			t.quantity = 1
		else
			t.quantity = 0
		end

		if p1 or t.quantity == v8 then
			return
		end

		task.spawn(function() --[[ Line: 109 | Upvalues: p4 (ref), t (ref) ]]
			p4(t)
		end)
		v8 = t.quantity
	end

	local function updateSelectionVisual() --[[ updateSelectionVisual | Line: 116 | Upvalues: v3 (ref), v4 (copy), t (copy), Functions (ref), t3 (ref), Variables (ref), p6 (copy), t2 (ref) ]]
		if v3 then
			return
		end

		v4.Visible = t.selected

		if t.selected then
			local v1 = v4:GetAttribute("Showing") == true

			if not v1 then
				v4:SetAttribute("Showing", true)
				v4.Size = UDim2.fromScale(1.2, 1.2)
				Functions.Tween(v4, {
					Size = UDim2.fromScale(1, 1)
				}, t3)
				task.spawn(function() --[[ Line: 130 | Upvalues: Variables (ref), v4 (ref), p6 (ref), t2 (ref), t (ref) ]]
					if Variables.Mobile then
						v4.Image = p6 and t2.Huge[1] or t2.Normal[1]

						local v3 = v4:Clone()

						v3.Size = UDim2.fromScale(1, 1)
						v3.Position = UDim2.fromScale(0.5, 0.5)
						v3.AnchorPoint = Vector2.new(0.5, 0.5)
						v3.Image = p6 and t2.Huge[2] or t2.Normal[2]
						v3.Visible = false
						v3.Parent = v4.Parent
						v4.Destroying:Connect(function() --[[ Line: 142 | Upvalues: v3 (copy) ]]
							if not v3 then
								return
							end

							v3:Destroy()
						end)

						while t.selected and v4.Parent do
							if not (v4:GetAttribute("Showing") == true) then
								break
							end

							local v6 = if os.clock() % 1 > 0.5 then true else false

							v3.Visible = v6
							v4.Visible = not v6
							task.wait()
						end

						if v3 then
							v3:Destroy()
						end
					else
						while t.selected and v4.Parent do
							if not (v4:GetAttribute("Showing") == true) then
								break
							end

							local v8 = os.clock() % 1 > 0.5

							if p6 then
								v4.Image = v8 and t2.Huge[1] or t2.Huge[2]
							else
								v4.Image = v8 and t2.Normal[1] or t2.Normal[2]
							end

							task.wait()
						end
					end
				end)

				return
			end
		end

		if t.selected then
			return
		end

		v4:SetAttribute("Showing", false)
	end

	local function bindDialSignals() --[[ bindDialSignals | Line: 179 | Upvalues: v5 (ref), updateCallback (copy), p5 (copy), t (copy), updateSelectionVisual (copy), v6 (ref) ]]
		local v1 = v5

		assert(v1, "CircularSelection.bindDialSignals requires an active dial GUI")
		v1:GetAttributeChangedSignal("Quantity"):Connect(function() --[[ Line: 183 | Upvalues: updateCallback (ref), p5 (ref), t (ref), updateSelectionVisual (ref) ]]
			updateCallback(not p5)

			if t.quantity < 1 then
				t.selected = false
			else
				t.selected = true
			end

			updateSelectionVisual()
		end)
		v1:GetAttributeChangedSignal("Tracking"):Connect(function() --[[ Line: 195 | Upvalues: p5 (ref), v1 (copy), updateCallback (ref) ]]
			if p5 then
				return
			end

			if v1:GetAttribute("Tracking") == true then
				return
			end

			updateCallback()
		end)
		v1.Destroying:Connect(function() --[[ Line: 201 | Upvalues: v5 (ref), v6 (ref), t (ref), updateSelectionVisual (ref), p5 (ref), updateCallback (ref) ]]
			local v1 = v5

			v5 = nil
			v6 = nil
			t.selected = false
			updateSelectionVisual()

			if not v1 then
				return
			end

			if not (v1:GetAttribute("Tracking") == true) or p5 then
				return
			end

			updateCallback()
		end)
	end

	local function createDial() --[[ createDial | Line: 214 | Upvalues: CreateDial (ref), p1 (copy), v1 (copy), v2 (copy), v5 (ref), v6 (ref), v7 (ref), v3 (ref), bindDialSignals (copy), updateCallback (copy), p5 (copy) ]]
		local v12, v22, v32 = CreateDial(p1, v1, v2)

		v5 = v12
		v6 = v22
		v7 = v32
		v12:SetAttribute("IsLocked", v3)
		bindDialSignals()
		updateCallback(not p5)
	end

	local function setSelected(p12) --[[ setSelected | Line: 224 | Upvalues: v3 (ref), t (copy), v5 (ref), v6 (ref), updateSelectionVisual (copy), updateCallback (copy), v1 (copy), CreateDial (ref), p1 (copy), v2 (copy), v7 (ref), bindDialSignals (copy), p5 (copy) ]]
		if v3 then
			return
		end

		if t.selected == false and not t.selectable then
			return
		end

		if p12 == nil then
			if v5 and t.quantity < 1 then
				t.selected = false

				local v12 = v6

				assert(v12, "CircularSelection expected destroyDial when closing an active dial")
				v12()
				v5 = nil
				v6 = nil
				updateSelectionVisual()
				updateCallback()

				return
			end

			if not (v5 or v1 <= 1) then
				t.selected = true
				updateSelectionVisual()

				local v22, v32, v4 = CreateDial(p1, v1, v2)

				v5 = v22
				v6 = v32
				v7 = v4
				v22:SetAttribute("IsLocked", v3)
				bindDialSignals()
				updateCallback(not p5)

				return
			end

			if v1 == 1 then
				t.selected = not t.selected
				updateSelectionVisual()
				updateCallback()
			end
		else
			t.selected = p12

			if v5 and not t.selected then
				local v52 = v6

				assert(v52, "CircularSelection expected destroyDial when deselecting an active dial")
				v52()
				v5 = nil
				v6 = nil
			end

			updateSelectionVisual()
			updateCallback()
		end
	end

	local function handlePress() --[[ handlePress | Line: 273 | Upvalues: v3 (ref), v9 (ref), t (copy), setSelected (copy) ]]
		if v3 then
			return
		end

		v9 = if t.selected then tick() or nil else nil
		setSelected(nil)
	end

	local function handleRelease() --[[ handleRelease | Line: 282 | Upvalues: v3 (ref), v9 (ref), t (copy), v5 (ref), v6 (ref), updateSelectionVisual (copy), updateCallback (copy) ]]
		if v3 then
			return
		end

		if not (v9 and (tick() - v9 <= 0.15 and t.selected)) then
			return
		end

		if v3 then
			return
		end

		if t.selected == false and not t.selectable then
			return
		end

		t.selected = false

		if v5 and not t.selected then
			local v1 = v6

			assert(v1, "CircularSelection expected destroyDial when deselecting an active dial")
			v1()
			v5 = nil
			v6 = nil
		end

		updateSelectionVisual()
		updateCallback()
	end

	local function setSelectable(p1) --[[ setSelectable | Line: 292 | Upvalues: v3 (ref), t (copy), setSelected (copy) ]]
		if v3 then
			return
		end

		t.selectable = p1

		if not p1 then
			t.quantity = 0
		end

		if not t.selected or p1 then
			return
		end

		setSelected(nil)
	end

	local function cleanup() --[[ cleanup | Line: 308 | Upvalues: t4 (copy), v5 (ref), v6 (ref), v4 (copy) ]]
		for i, v in ipairs(t4) do
			v:Disconnect()
		end

		if not v5 then
			v4:Destroy()

			return
		end

		local v1 = v6

		assert(v1, "CircularSelection expected destroyDial during cleanup")
		v1()
		v4:Destroy()
	end

	local function cancelSelection() --[[ cancelSelection | Line: 322 | Upvalues: t (copy), v3 (ref), v5 (ref), v6 (ref), updateSelectionVisual (copy), updateCallback (copy), p1 (copy) ]]
		if not t.selected then
			return
		end

		if not v3 and (t.selected ~= false or t.selectable) then
			t.selected = false

			if v5 and not t.selected then
				local v1 = v6

				assert(v1, "CircularSelection expected destroyDial when deselecting an active dial")
				v1()
				v5 = nil
				v6 = nil
			end

			updateSelectionVisual()
			updateCallback()
		end

		local v2 = p1:FindFirstAncestorOfClass("ScrollingFrame")

		if not v2 then
			return
		end

		v2.ScrollingEnabled = true
	end

	local function setLocked(p1) --[[ setLocked | Line: 333 | Upvalues: v3 (ref), v5 (ref) ]]
		v3 = p1

		if not v5 then
			return
		end

		v5:SetAttribute("IsLocked", p1)
	end

	local function setQuantity(p12, p2) --[[ setQuantity | Line: 341 | Upvalues: v3 (ref), t (copy), v5 (ref), v6 (ref), updateSelectionVisual (copy), updateCallback (copy), v1 (copy), CreateDial (ref), p1 (copy), v2 (copy), v7 (ref), bindDialSignals (copy), p5 (copy) ]]
		if p2 then
			if not v3 and (t.selected ~= false or t.selectable) then
				t.selected = true

				if v5 and not t.selected then
					local v12 = v6

					assert(v12, "CircularSelection expected destroyDial when deselecting an active dial")
					v12()
					v5 = nil
					v6 = nil
				end

				updateSelectionVisual()
				updateCallback()
			end

			if v5 then
				v5:SetAttribute("Quantity", p12)
				updateSelectionVisual()
				updateCallback()
			elseif v1 > 1 then
				local v22, v32, v4 = CreateDial(p1, v1, v2)

				v5 = v22
				v6 = v32
				v7 = v4
				v22:SetAttribute("IsLocked", v3)
				bindDialSignals()
				updateCallback(not p5)
			end
		end

		if not v7 then
			return
		end

		v7(p12)
	end

	if Variables.Console or Variables.Mobile then
		if Variables.Mobile then
			local v11 = nil
			local v12 = nil

			local function f13(p1) --[[ Line: 366 | Upvalues: v11 (ref), v12 (ref), Functions (ref), v3 (ref), v9 (ref), t (copy), setSelected (copy) ]]
				if p1.UserInputType ~= Enum.UserInputType.Touch or p1.UserInputState ~= Enum.UserInputState.Begin then
					return
				end

				if v11 then
					v11()
					v11 = nil
				end

				v12 = tick()
				v11 = Functions.IntendedTouch(p1, function() --[[ Line: 377 | Upvalues: v11 (ref), v3 (ref), v9 (ref), t (ref), setSelected (ref) ]]
					v11 = nil

					if v3 then
						return
					end

					v9 = if t.selected then tick() or nil else nil
					setSelected(nil)
				end, 0.05)
			end

			table.insert(t4, p1.InputBegan:Connect(f13))

			local function f14() --[[ Line: 391 | Upvalues: v11 (ref), v12 (ref), v3 (ref), v9 (ref), t (copy), setSelected (copy), v5 (ref), v6 (ref), updateSelectionVisual (copy), updateCallback (copy) ]]
				if v11 then
					v11()
					v11 = nil

					if v12 and tick() - v12 < 0.05 then
						v12 = nil

						if not v3 then
							v9 = if t.selected then tick() or nil else nil
							setSelected(nil)
						end

						if not v3 and (v9 and (tick() - v9 <= 0.15 and (t.selected and (not v3 and (t.selected ~= false or t.selectable))))) then
							t.selected = false

							if v5 and not t.selected then
								local v2 = v6

								assert(v2, "CircularSelection expected destroyDial when deselecting an active dial")
								v2()
								v5 = nil
								v6 = nil
							end

							updateSelectionVisual()
							updateCallback()
						end
					end
				end

				v12 = nil

				if v3 or not (v9 and (tick() - v9 <= 0.15 and t.selected)) then
					return
				end

				if v3 then
					return
				end

				if t.selected == false and not t.selectable then
					return
				end

				t.selected = false

				if v5 and not t.selected then
					local v32 = v6

					assert(v32, "CircularSelection expected destroyDial when deselecting an active dial")
					v32()
					v5 = nil
					v6 = nil
				end

				updateSelectionVisual()
				updateCallback()
			end

			table.insert(t4, p1.MouseButton1Up:Connect(f14))
		elseif Variables.Console then
			local function f15(p12) --[[ Line: 425 | Upvalues: ConsoleCmds (ref), p1 (copy), GuiService (ref), v10 (ref), v3 (ref), v9 (ref), t (copy), setSelected (copy) ]]
				if not ConsoleCmds.ElementIsVisibleOnScreen(p1) then
					return
				end

				if GuiService.SelectedObject ~= p1 then
					return
				end

				if v10 then
					return
				end

				if p12.KeyCode ~= Enum.KeyCode.ButtonA then
					return
				end

				v10 = true

				if v3 then
					return
				end

				v9 = if t.selected then tick() or nil else nil
				setSelected(nil)
			end

			table.insert(t4, UserInputService.InputBegan:Connect(f15))

			local function f16(p12) --[[ Line: 453 | Upvalues: ConsoleCmds (ref), p1 (copy), GuiService (ref), v10 (ref), v3 (ref), v9 (ref), t (copy), v5 (ref), v6 (ref), updateSelectionVisual (copy), updateCallback (copy) ]]
				if not ConsoleCmds.ElementIsVisibleOnScreen(p1) then
					return
				end

				if GuiService.SelectedObject ~= p1 then
					return
				end

				if not v10 then
					return
				end

				if p12.KeyCode ~= Enum.KeyCode.ButtonA then
					return
				end

				v10 = false

				if v3 then
					return
				end

				if not (v9 and (tick() - v9 <= 0.15 and t.selected)) then
					return
				end

				if v3 then
					return
				end

				if t.selected == false and not t.selectable then
					return
				end

				t.selected = false

				if v5 and not t.selected then
					local v1 = v6

					assert(v1, "CircularSelection expected destroyDial when deselecting an active dial")
					v1()
					v5 = nil
					v6 = nil
				end

				updateSelectionVisual()
				updateCallback()
			end

			table.insert(t4, UserInputService.InputEnded:Connect(f16))
		end
	else
		table.insert(t4, p1.MouseButton1Down:Connect(handlePress))
		table.insert(t4, p1.MouseButton1Up:Connect(handleRelease))
	end

	return cleanup, cancelSelection, setSelectable, setLocked, setQuantity
end

return t