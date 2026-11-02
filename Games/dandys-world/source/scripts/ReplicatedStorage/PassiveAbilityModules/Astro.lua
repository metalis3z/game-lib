--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- CQMXBlBhcmVudAVWYWx1ZQVwcmludCpBc3RybyBQYXNzaXZlOiBSZW1vdmVkIHN0YW1pbmEgcmVnZW4gYm9vc3QeQXN0cm8gUGFzc2l2ZTogQ2xlYW5pbmcgdXAgZm9yBE5hbWUFcGNhbGwEd2Fybh1Bc3RybyBQYXNzaXZlOiBDbGVhbnVwIGVycm9yOitBc3RybyBQYXNzaXZlOiBJbml0aWFsaXppbmcgV2VsbCBSZXN0ZWQgZm9yBVN0YXRzDFdhaXRGb3JDaGlsZCVBc3RybyBQYXNzaXZlOiBTdGF0cyBmb2xkZXIgbm90IGZvdW5kFFN0YW1pbmFSZWdlbk1vZGlmaWVyO0FzdHJvIFBhc3NpdmU6IFN0YW1pbmFSZWdlbk1vZGlmaWVyIG5vdCBmb3VuZCBhZnRlciB3YWl0aW5nLEFzdHJvIFBhc3NpdmU6IEFwcGxpZWQgc3RhbWluYSByZWdlbiBib29zdCAoAi0+ASkKSW5pdGlhbGl6ZQhBY3RpdmF0ZQpEZWFjdGl2YXRlJUFzdHJvIFBhc3NpdmU6IEFkZGl0aW9uYWwgY2xlYW51cCBmb3IHQ2xlYW51cAAJAAAAAAAAAYIAAQAAABcAARgAFwAAAAAAAAAAAAABggABAAAAHQABGAAdAAAAAAMAAQAAABL7AAAADgAPAPsAAABNAAAkAAAAAA4ACwD7AAAA+wIAAE0CAuwCAAAAPgECATABAOwCAAAApAAEAAAAMEBvAQUAnwACAYIAAQAGAwECAAAAAAAA+D8DAgMDBAAAMEADBAAxAAEYAAAAAAAAAQAAAAAAAAEAAAACMgAAAAAFAAIAAAATpAABAAAAAEBvAQIA+wIAAE0CAroDAAAAnwADAaQABQAAAEBA2QEAABICAQCfAAIDKwAFAKQCBwAAAGBAbwMIAFIEAQCfAgMBggABAAkDAwQAAABAAwUDBgMHBAAAQEADCAQAAGBAAwkBAi0AARgAAAAAAAAAAwAAAAAHAQAAAAAFLgAAAAALAgAAAAAypAIBAAAAAEBvAwIATQQBugMAAACfAgMBbwQEAIwFBQC8AgDTBQAAAJ8CBAIrAgYApAMHAAAAYEBvBAgAnwMCAcADCQCCAwIAbwUKAIwGBQC8AwLTBQAAAJ8DBAIrAwYApAQHAAAAYEBvBQsAnwQCAcAEDACCBAIATQQD7A0AAABNBgPsDQAAAFsFBg4wBQPsDQAAAKQFAQAAAABAbwYPAFIHBABvCBAATQkD7A0AAABvChEAnwUGAdkFAgASAAEAEgADAIIFAgASAwMEAAAAQAMKAwYDCwMMAwgEAABgQAMNBgADDgMPBgEDAgIAAAAAAAD4PwMQAxEDEgMAAQMQEwEYAAAAAAAAAwAAAAABAQAAAAEAAwAAAAABAQAAAAEABQABAAAAAAEAAAAAAAAAAAkAAAARAAAAAAMDAAAAAAGCAAEAAABFFAEYAEcAAAAAAgIAAAAAAYIAAQAAAE0VARgATwAAAAAFAgAAAAAHpAIBAAAAAEBvAwIATQQBugMAAACfAgMBggABAAQDAwQAAABAAxYDBgBVFwEYAAAAAAAAAlYAAAAAAgAAAQIAEKMAAAD/AAMAAAAAAMABAAAwAQDbAQAAAMABAgAwAQDBAwAAAMABBAAwAQCIBQAAAMABBgAwAQDxBwAAAIIAAgAIBgQDEwYFAxQGBgMVBgcDFwQEBQYHAQABGAAHAAgAADUAAAgAAAgAAAUBAAAAAAintPOOAGXrguGwiEwvjP+b16zk+pVwmY8=

-- https://lua.expert/
return {
	Initialize = function(p1, p2) --[[ Initialize | Line: 16 ]]
		print("Astro Passive: Initializing Well Rested for", p2.Name)

		local Stats = p1:WaitForChild("Stats", 5)

		if not Stats then
			warn("Astro Passive: Stats folder not found")

			return function() --[[ Line: 23 ]] end
		end

		local StaminaRegenModifier = Stats:WaitForChild("StaminaRegenModifier", 5)

		if StaminaRegenModifier then
			local astropassiveappliedstaminaregenboost = StaminaRegenModifier.Value

			StaminaRegenModifier.Value = StaminaRegenModifier.Value * 1.5
			print("Astro Passive: Applied stamina regen boost (", astropassiveappliedstaminaregenboost, "->", StaminaRegenModifier.Value, ")")

			return function() --[[ Line: 45 | Upvalues: p2 (copy), StaminaRegenModifier (copy) ]]
				print("Astro Passive: Cleaning up for", p2.Name)

				local ok, result = pcall(function() --[[ Line: 49 | Upvalues: StaminaRegenModifier (ref) ]]
					if not (StaminaRegenModifier and StaminaRegenModifier.Parent) then
						return
					end

					StaminaRegenModifier.Value = StaminaRegenModifier.Value / 1.5
					print("Astro Passive: Removed stamina regen boost")
				end)

				if ok then
					return
				end

				warn("Astro Passive: Cleanup error:", result)
			end
		end

		warn("Astro Passive: StaminaRegenModifier not found after waiting")

		return function() --[[ Line: 29 ]] end
	end,
	Activate = function(p1, p2, p3) --[[ Activate | Line: 69 ]] end,
	Deactivate = function(p1, p2) --[[ Deactivate | Line: 77 ]] end,
	Cleanup = function(p1, p2) --[[ Cleanup | Line: 85 ]]
		print("Astro Passive: Additional cleanup for", p2.Name)
	end
}