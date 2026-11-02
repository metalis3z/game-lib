-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-04-21 09:13:00
-- Luau version 6, Types version 3
-- Time taken: 0.002948 seconds

return {
	createButton = function(arg1, arg2, arg3) -- Line 2, Named "createButton"
		local module_upvr = {}
		module_upvr.Frame = arg1
		module_upvr.Container = arg1.Container
		module_upvr.shadowSize = math.abs(module_upvr.Container.Shadow.Position.X.Offset)
		local var4 = arg3
		if not var4 then
			function var4() -- Line 8
			end
		end
		module_upvr.clickStart = var4
		var4 = arg2
		local var6 = var4
		if not var6 then
			function var6() -- Line 9
			end
		end
		module_upvr.clickEnd = var6
		local var7_upvw = false
		local var8_upvw = true
		function module_upvr.Reset(arg1_2) -- Line 12
			--[[ Upvalues[2]:
				[1]: var7_upvw (read and write)
				[2]: module_upvr (readonly)
			]]
			var7_upvw = false
			module_upvr.Container:TweenSize(UDim2.new(1, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.2, true)
			module_upvr.Container.Shadow:TweenSize(UDim2.new(1, module_upvr.shadowSize * 2, 1, module_upvr.shadowSize * 3), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.2, true)
		end
		function module_upvr.Press(arg1_3) -- Line 17
			--[[ Upvalues[3]:
				[1]: var8_upvw (read and write)
				[2]: var7_upvw (read and write)
				[3]: module_upvr (readonly)
			]]
			if var8_upvw then
				var7_upvw = true
				module_upvr.Container:TweenSize(UDim2.new(0.95, 0, 0.95, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.05, true)
				module_upvr.Container.Shadow:TweenSize(UDim2.new(1, module_upvr.shadowSize * 2, 1, module_upvr.shadowSize * 2), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.05, true)
			end
		end
		function module_upvr.Disable(arg1_4) -- Line 24
			--[[ Upvalues[2]:
				[1]: var8_upvw (read and write)
				[2]: module_upvr (readonly)
			]]
			var8_upvw = false
			module_upvr.Container.Background.Visible = false
		end
		function module_upvr.Enable(arg1_5) -- Line 28
			--[[ Upvalues[2]:
				[1]: var8_upvw (read and write)
				[2]: module_upvr (readonly)
			]]
			var8_upvw = true
			module_upvr.Container.Background.Visible = true
		end
		function module_upvr.GetEnabled(arg1_6) -- Line 32
			--[[ Upvalues[1]:
				[1]: var8_upvw (read and write)
			]]
			return var8_upvw
		end
		function module_upvr.Clicked(arg1_7) -- Line 35
			--[[ Upvalues[3]:
				[1]: var7_upvw (read and write)
				[2]: var8_upvw (read and write)
				[3]: module_upvr (readonly)
			]]
			if var7_upvw and var8_upvw then
				module_upvr:Reset()
				module_upvr.clickStart()
				task.wait(0.025)
				module_upvr.clickEnd()
			else
				module_upvr:Reset()
			end
		end
		module_upvr.Frame.Button.MouseButton1Down:Connect(module_upvr.Press)
		module_upvr.Frame.Button.MouseButton1Up:Connect(module_upvr.Clicked)
		module_upvr.Frame.MouseLeave:Connect(module_upvr.Reset)
		return module_upvr
	end;
}