-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local t2 = {}

local function infoText(p1, p2) --[[ infoText | Line: 4 ]]
	p1.PushConfig({
		TextColor = p1._config.TextDisabledColor
	})
	p1.Text({ p2 })
	p1.PopConfig()
end

local function helpMarker(p1, p2) --[[ helpMarker | Line: 10 ]]
	p1.PushConfig({
		TextColor = p1._config.TextDisabledColor
	})

	local v1 = p1.Text({ "(?)" })

	p1.PopConfig()
	p1.PushConfig({
		ContentWidth = UDim.new(0, 350)
	})

	if v1.hovered() then
		p1.Tooltip({ p2 })
	end

	p1.PopConfig()
end

local function BoneEditor(p1, p2) --[[ BoneEditor | Line: 22 | Upvalues: t (copy) ]]
	local v1 = p1.Window({ (("Editing bone: %*"):format(p2.Bone.Name)) })

	v1.isOpened.value = true
	p2.Radius = p1.InputNum({ "Radius", 0.1, 0, (1 / 0), "%.3f" }, {
		number = p2.Radius
	}).number.value
	p2.RotationLimit = p1.InputNum({ "Rotation Limit", 0.1, 0, 180, "%.3f" }, {
		number = p2.RotationLimit
	}).number.value
	p2.Anchored = p1.Checkbox({ "Anchored" }, {
		isChecked = p2.Anchored
	}).isChecked.value
	p1.Text("Axis Lock")
	p1.Indent()
	p1.SameLine()
	p1.Text("X: ")

	local v2 = p1.Checkbox({ "" }, {
		isChecked = p2.AxisLocked[1]
	})

	p1.Text("Y: ")

	local v3 = p1.Checkbox({ "" }, {
		isChecked = p2.AxisLocked[2]
	})

	p1.Text("Z: ")

	local v4 = p1.Checkbox({ "" }, {
		isChecked = p2.AxisLocked[3]
	})

	p1.End()
	p1.End()

	local v5 = p1.State(Vector2.new(p2.XAxisLimits.Min, p2.XAxisLimits.Max))
	local v6 = p1.State(Vector2.new(p2.YAxisLimits.Min, p2.YAxisLimits.Max))
	local v7 = p1.State(Vector2.new(p2.ZAxisLimits.Min, p2.ZAxisLimits.Max))

	p1.Text("Axis Limits")
	p1.Indent()
	p1.DragVector2({
		"X Axis Limit",
		0.05,
		nil,
		nil,
		{ "Min: %.2f", "Max: %.2f" }
	}, {
		number = v5
	})
	p1.DragVector2({
		"Y Axis Limit",
		0.05,
		nil,
		nil,
		{ "Min: %.2f", "Max: %.2f" }
	}, {
		number = v6
	})
	p1.DragVector2({
		"Z Axis Limit",
		0.05,
		nil,
		nil,
		{ "Min: %.2f", "Max: %.2f" }
	}, {
		number = v7
	})
	p1.End()
	p1.End()
	p2.AxisLocked[1] = v2.isChecked.value
	p2.AxisLocked[2] = v3.isChecked.value
	p2.AxisLocked[3] = v4.isChecked.value
	p2.XAxisLimits = NumberRange.new(v5:get().X, v5:get().Y)
	p2.YAxisLimits = NumberRange.new(v6:get().X, v6:get().Y)
	p2.ZAxisLimits = NumberRange.new(v7:get().X, v7:get().Y)

	if not v1.closed() then
		return
	end

	t[p2] = nil
end

local function ColliderEditor(p1, p2) --[[ ColliderEditor | Line: 80 | Upvalues: t2 (copy) ]]
	local v1 = p1.Window({ (("Editing collider of type: %*"):format(p2.Type)) })

	v1.isOpened.value = true

	local v2 = p1.State(p2.Type)
	local v3 = p1.State(p2.Scale)
	local v4 = p1.State(p2.Offset)
	local v5 = p1.State(p2.Rotation)

	p1.Combo({ "Collider Type" }, {
		index = v2
	})
	p1.Selectable({ "Box", "Box" }, {
		index = v2
	})
	p1.Selectable({ "Sphere", "Sphere" }, {
		index = v2
	})
	p1.Selectable({ "Capsule", "Capsule" }, {
		index = v2
	})
	p1.End()
	p1.DragVector3({ "Scale", 0.1, 0, nil }, {
		number = v3
	})
	p1.DragVector3({ "Offset", 0.1, nil, nil }, {
		number = v4
	})
	p1.DragVector3({ "Rotation", 0.5, -180, 180 }, {
		number = v5
	})
	p2.Type = v2:get()
	p2.Scale = v3:get()
	p2.Offset = v4:get()
	p2.Rotation = v5:get()
	p1.End()

	if not v1.closed() then
		return
	end

	t2[p2] = nil
end

return function(p1, p2, p3) --[[ Line: 111 | Upvalues: t (copy), BoneEditor (copy), t2 (copy), ColliderEditor (copy), helpMarker (copy), infoText (copy) ]]
	local t3 = {}

	for v1, v2 in p2.BoneTrees do
		local RootPart = v2.RootPart
		local v3 = t3[RootPart]

		if not v3 then
			t3[RootPart] = {}
			v3 = t3[RootPart]
		end

		table.insert(v3, v2)
	end

	for v4, v5 in t do
		p1.PushId((("%* - %*"):format(p2.ID, v4.ParentIndex + 1)))
		BoneEditor(p1, v4)
		p1.PopId()
	end

	for v7, v8 in t2 do
		p1.PushId(v7.GUID)
		ColliderEditor(p1, v7)
		p1.PopId()
	end

	local v9 = #p2.BoneTrees
	local v10 = #p2.ColliderObjects

	p1.Window({
		("SmartBone Runtime Editor. %*, %*"):format(("%* BoneTree%*"):format(v9, if v9 == 1 then "" else "s"), (("%* Collider%*"):format(v10, if v10 == 1 then "" else "s"))),
		[p1.Args.Window.NoClose] = true
	})
	p1.Tree({ "Debug Gizmos", true }, {
		isUncollapsed = true
	})
	p1.SameLine()
	p1.Checkbox({ "Draw Internal Bone" }, {
		isChecked = p3.DRAW_BONE
	})
	helpMarker(p1, "Draws a sphere with the specified radius of the bone around where SmartBone believes the bone is.")
	p1.End()
	p1.SameLine()
	p1.Checkbox({ "Draw Physical Bone" }, {
		isChecked = p3.DRAW_PHYSICAL_BONE
	})
	helpMarker(p1, "Draws the actual bone objects CFrame with axis arrows.")
	p1.End()
	p1.SameLine()
	p1.Checkbox({ "Draw Root Part" }, {
		isChecked = p3.DRAW_ROOT_PART
	})
	helpMarker(p1, "Draws a bounding box and fills in the root part.")
	p1.End()
	p1.SameLine()
	p1.Checkbox({ "Draw Bounding Box" }, {
		isChecked = p3.DRAW_BOUNDING_BOX
	})
	helpMarker(p1, "Draws the bounding box used for frustum culling")
	p1.End()
	p1.SameLine()
	p1.Checkbox({ "Draw Axis Limits" }, {
		isChecked = p3.DRAW_AXIS_LIMITS
	})
	helpMarker(p1, "Draws the axis limits for each bone.")
	p1.End()
	p1.SameLine()
	p1.Checkbox({ "Draw Rotation Limits" }, {
		isChecked = p3.DRAW_ROTATION_LIMITS
	})
	helpMarker(p1, "Draws the rotation limits for each bone.")
	p1.End()
	p1.SameLine()
	p1.Checkbox({ "Draw Acceleration Info" }, {
		isChecked = p3.DRAW_ACCELERATION_INFO
	})
	helpMarker(p1, "Draws the acceleration and the required values to derive it.")
	p1.End()
	p1.SameLine()
	p1.Checkbox({ "Draw Colliders" }, {
		isChecked = p3.DRAW_COLLIDERS
	})
	helpMarker(p1, "Draws all the colliders this root object can collide with.")
	p1.End()
	p1.SameLine()
	p1.Checkbox({ "Draw Collider Influence" }, {
		isChecked = p3.DRAW_COLLIDER_INFLUENCE
	})
	helpMarker(p1, "Shows the sphere of influence around each collider.")
	p1.End()
	p1.SameLine()
	p1.Checkbox({ "Draw Collider Awake" }, {
		isChecked = p3.DRAW_COLLIDER_AWAKE
	})
	helpMarker(p1, "Shows if a collider is awake or asleep.")
	p1.End()
	p1.SameLine()
	p1.Checkbox({ "Draw Collider Broadphase" }, {
		isChecked = p3.DRAW_COLLIDER_BROADPHASE
	})
	helpMarker(p1, "Shows if a collider isn\'t reaching narrowphase.")
	p1.End()
	p1.SameLine()
	p1.Checkbox({ "Draw Fill Colliders" }, {
		isChecked = p3.DRAW_FILL_COLLIDERS
	})
	helpMarker(p1, "Fills all colliders this root object can collide with.")
	p1.End()
	p1.SameLine()
	p1.Checkbox({ "Draw Contacts" }, {
		isChecked = p3.DRAW_CONTACTS
	})
	helpMarker(p1, "Draws the position and normal of the points which bones collide with colliders.")
	p1.End()
	p1.End()
	p1.Separator()
	infoText(p1, "Simulated Objects")

	for v17, v18 in t3 do
		p1.Tree((("%* - Root Part"):format(v17.Name)))

		for v19, v20 in v18 do
			p1.Tree((("BoneTree #%*"):format(v19)))
			infoText(p1, (("Throttled Update Rate: %* / %* fps"):format(string.format("%.1f", v20.UpdateRate), (string.format("%.1f", v20.Settings.UpdateRate)))))
			infoText(p1, (("In View: %*"):format(v20.InView)))

			local v21 = p1.State(v20.Settings.Constraint)
			local v22 = p1.State(v20.Settings.WindType)
			local v23 = p1.State(v20.Settings.UpdateRate)
			local v24 = p1.State(v20.Settings.ActivationDistance)
			local v25 = p1.State(v20.Settings.ThrottleDistance)

			p1.SameLine()
			helpMarker(p1, "The constraint used, distance is more flowy while spring is more rigid.")
			p1.Combo({ "Constraint Type" }, {
				index = v21
			})
			p1.Selectable({ "Distance", "Distance" }, {
				index = v21
			})
			p1.Selectable({ "Spring", "Spring" }, {
				index = v21
			})
			p1.End()
			p1.End()
			p1.SameLine()
			helpMarker(p1, "The wind solver used, sine is a smoother wind, noise is more chaotic and hybrid is a mix of the two.")
			p1.Combo({ "Wind Type" }, {
				index = v22
			})
			p1.Selectable({ "Sine", "Sine" }, {
				index = v22
			})
			p1.Selectable({ "Noise", "Noise" }, {
				index = v22
			})
			p1.Selectable({ "Hybrid", "Hybrid" }, {
				index = v22
			})
			p1.End()
			p1.End()
			p1.SameLine()
			helpMarker(p1, "The target update rate for the bone tree")
			p1.SliderNum({ "Update Rate", 5, 0, 120 }, {
				number = v23
			})
			p1.End()
			p1.SameLine()
			helpMarker(p1, "The distance at which the bone tree stops updating")
			p1.SliderNum({ "Activation Distance", 1, 0, 500 }, {
				number = v24
			})
			p1.End()
			p1.SameLine()
			helpMarker(p1, "The distance at which the bone tree starts throttling its update rate")
			p1.SliderNum({ "Throttle Distance", 1, 0, 500 }, {
				number = v25
			})
			p1.End()
			v20.Settings.Constraint = v21:get()
			v20.Settings.WindType = v22:get()
			v20.Settings.UpdateRate = v23:get()
			v20.Settings.ActivationDistance = v24:get()
			v20.Settings.ThrottleDistance = v25:get()
			p1.Table({ 4, false, false, false })
			p1.NextColumn()
			p1.Text("Bone #")
			p1.NextColumn()
			p1.Text("Bone Name")
			p1.NextColumn()
			p1.Text("Parent #")
			p1.NextColumn()
			p1.Text("Edit")
			p1.End()
			p1.Table({ 4 })

			for v26, v27 in v20.Bones do
				p1.NextColumn()
				p1.Text((tostring(v26)))
				p1.NextColumn()
				p1.Text(v27.Bone.Name)
				p1.NextColumn()
				p1.Text((tostring(v27.ParentIndex)))
				p1.NextColumn()
				p1.SameLine()
				p1.Text("")

				if p1.SmallButton({ "Edit" }).clicked() then
					t[v27] = true
				end

				p1.End()
			end

			p1.End()
			p1.End()
		end

		p1.End()
	end

	infoText(p1, "Active Colliders")

	for v28, v29 in p2.ColliderObjects do
		p1.Tree({ v29.m_Object.Name })
		infoText(p1, "Colliders adorned to this object")
		p1.Table({ 5, false, false, false })
		p1.NextColumn()
		p1.Text("Type")
		p1.NextColumn()
		p1.Text("Scale")
		p1.NextColumn()
		p1.Text("Offset")
		p1.NextColumn()
		p1.Text("Rotation")
		p1.NextColumn()
		p1.Text("Edit")
		p1.End()
		p1.Table({ 5 })

		for v30, v31 in v29.Colliders do
			p1.NextColumn()
			p1.Text((tostring(v31.Type)))
			p1.NextColumn()
			p1.Text((tostring(v31.Scale)))
			p1.NextColumn()
			p1.Text((tostring(v31.Offset)))
			p1.NextColumn()
			p1.Text((tostring(v31.Rotation)))
			p1.NextColumn()
			p1.SameLine()
			p1.Text("")

			if p1.SmallButton({ "Edit" }).clicked() then
				t2[v31] = true
			end

			p1.End()
		end

		p1.End()
		p1.End()
	end

	p1.End()
end