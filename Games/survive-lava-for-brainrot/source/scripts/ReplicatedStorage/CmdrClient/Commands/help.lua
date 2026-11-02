-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v12 = {
	["Name"] = "help",
	["Description"] = "Displays a list of all commands, or inspects one command.",
	["Group"] = "Help",
	["Args"] = {
		{
			["Type"] = "command",
			["Name"] = "Command",
			["Description"] = "The command to view information on",
			["Optional"] = true
		}
	},
	["ClientRun"] = function(p1, p2)
		if p2 then
			local v3 = p1.Cmdr.Registry:GetCommand(p2)
			p1:Reply(("Command: %*"):format(v3.Name), Color3.fromRGB(230, 126, 34))
			if v3.Aliases and #v3.Aliases > 0 then
				p1:Reply(("Aliases: %*"):format((table.concat(v3.Aliases, ", "))), Color3.fromRGB(230, 230, 230))
			end
			p1:Reply(v3.Description, Color3.fromRGB(230, 230, 230))
			for v4, v5 in ipairs(v3.Args) do
				p1:Reply((("#%* %*%*: %* - %*"):format(v4, v5.Name, v5.Optional == true and "?" or "", v5.Type, v5.Description)))
			end
		else
			p1:Reply("Argument Shorthands\n-------------------\n.   Me/Self\n*   All/Everyone\n**  Others\n?   Random\n?N  List of N random values\n")
			p1:Reply("Tips\n----\n\226\128\162 Utilize the Tab key to automatically complete commands\n\226\128\162 Easily select and copy command output\n")
			local v6 = p1.Cmdr.Registry:GetCommands()
			table.sort(v6, function(p7, p8)
				if p7.Group and p8.Group then
					return p7.Group < p8.Group
				else
					return p7.Group
				end
			end)
			local v9 = nil
			for _, v10 in ipairs(v6) do
				v10.Group = v10.Group or "No Group"
				if v9 ~= v10.Group then
					p1:Reply((("\n%*\n%*"):format(v10.Group, (string.rep("-", #v10.Group)))))
					v9 = v10.Group
				end
				local v11
				if v10.Description then
					v11 = ("%* - %*"):format(v10.Name, v10.Description)
				else
					v11 = v10.Name
				end
				p1:Reply(v11)
			end
		end
		return ""
	end
}
return v12
