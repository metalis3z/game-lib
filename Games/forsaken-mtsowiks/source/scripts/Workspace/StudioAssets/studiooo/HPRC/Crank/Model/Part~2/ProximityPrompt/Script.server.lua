-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMXBnNjcmlwdAVDcmFuaxFGaW5kRmlyc3RBbmNlc3RvcgtQcmltYXJ5UGFydApPcmlnaW5hbENGDEdldEF0dHJpYnV0ZQZDRnJhbWUMU2V0QXR0cmlidXRlBlBhcmVudAR0YXNrBHdhaXQGQW5nbGVzBG1hdGgDcmFkBGdhbWUMVHdlZW5TZXJ2aWNlCVR3ZWVuSW5mbwNuZXcGQ3JlYXRlBFBsYXkVUHJvbXB0QnV0dG9uSG9sZEJlZ2FuB0Nvbm5lY3QVUHJvbXB0QnV0dG9uSG9sZEVuZGVkAAMIAAEAAAA8pAABAAAAAEBvAgIAvAAAfAMAAACfAAMCDgA0AE0BAJsEAAAAbwMFALwBARIGAAAAnwEDAisBCgBNAQCbBAAAAG8DBQBNBQCbBAAAAE0EBYUHAAAAvAEBLggAAACfAQQBqQEBAN4BAACkAgEAAAAAQE0BAiQJAAAADgEcAKQBDAAALKCAnwEBAvsCAAArAgEAggABAE0CAJsEAAAAKwIBAIIAAQBNAgCbBAAAAE0DAoUHAAAApAQOAAA0cIBbBgEPuxYGAqQFEgAARACBnwUCAowGAACMBwAAnwQEAgkDAwQwAwKFBwAAAEgA3/+CAAEAEwMBBAAAAEADAgMDAwQDBQMGAwcDCAMJAwoDCwQALKCAAwwEADRwgAIAAAAAAIB2QAMNAw4EAEQAgQAHAAEYAAAAAAAAAQEAAAAAAAAAAAAAAAAAAAAAAQABAAAAAAEAAAEAAAEAAAABAAAAAAAAAAAAAAAAAAAAAPwHCAAAAAAHAAEAAAAmpAABAAAAAEBvAgIAvAAAfAMAAACfAAMCUgEAAA4BBgBNAQCbBAAAAG8DBQC8AQESBgAAAJ8BAwIOABYADgEVAKkCAADeAgAApAMIAAAAcEBNAgM7CQAAAE0EAJsEAAAApAUMAAAsoIBvBg0AnwUCAuIGDwAwAQaFDgAAALwCApYQAAAAnwIFArwCAu4RAAAAnwICAYIAAQASAwEEAAAAQAMCAwMDBAMFAwYDDwQAAHBAAxADEQMSBAAsoIACMzMzMzMz0z8DBwUBDgMTAxQAFQABGAAAAAAAAAEAAAAAAAAAAQABAAEAAAAAAAAAAAAAAAAAAAAAAAACFgAAAAAFAAABAgAXowAAAKQBAQAAAABATQABJAIAAAAOABAAqQEAAE0CALgDAAAA2QQAABIBAf+8AgLHBAAAAJ8CAwFNAgCZBQAAANkEAQASAQH/vAICxwQAAACfAgMBwQEAAIIAAQAGAwEEAAAAQAMJAxUDFgMXAgABAQABGAABAAAAAgECAAAAAAAADgAAAAAAAAAIAQAAAAAChMzEji4NTFS2CK4ahcIeuJKnWqjKG+hrdtt+wxAepr2XrdX3zEn0Og==

-- Decompiled by Krnl

local v1 = script.Parent
if v1 then
	local v_u_2 = false
	v1.PromptButtonHoldBegan:Connect(function()
		-- upvalues: (ref) v_u_2
		local v3 = script:FindFirstAncestor("Crank")
		if v3 then
			if not v3.PrimaryPart:GetAttribute("OriginalCF") then
				v3.PrimaryPart:SetAttribute("OriginalCF", v3.PrimaryPart.CFrame)
			end
			v_u_2 = true
			while script.Parent do
				local v4 = task.wait()
				if not v_u_2 then
					return
				end
				if not v3.PrimaryPart then
					return
				end
				local v5 = v3.PrimaryPart
				local v6 = v5.CFrame
				local v7 = CFrame.Angles
				local v8 = v4 * 360
				v5.CFrame = v6 * v7(math.rad(v8), 0, 0)
			end
		end
	end)
	v1.PromptButtonHoldEnded:Connect(function()
		-- upvalues: (ref) v_u_2
		local v9 = script:FindFirstAncestor("Crank")
		local v10
		if v9 then
			v10 = v9.PrimaryPart:GetAttribute("OriginalCF")
		else
			v10 = v9
		end
		if v9 and v10 then
			v_u_2 = false
			game.TweenService:Create(v9.PrimaryPart, TweenInfo.new(0.3), {
				["CFrame"] = v10
			}):Play()
		end
	end)
end
