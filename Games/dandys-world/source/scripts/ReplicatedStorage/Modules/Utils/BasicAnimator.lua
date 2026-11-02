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
-- CQNkBnR5cGVvZgZzdHJpbmcSXnJieGFzc2V0aWQ6Ly8lZCskBW1hdGNoKV5odHRwczovL3d3dyUucm9ibG94JS5jb20vYXNzZXQvJT9pZD0lZCskEmlzVmFsaWRBbmltYXRpb25JZA5BbmltYXRpb25UcmFjawNJc0EJSXNQbGF5aW5nBFN0b3ARc2FmZVN0b3BBbmltYXRpb24LQW5pbWF0aW9uSWQNTG9hZEFuaW1hdGlvbgRQbGF5B0Rlc3Ryb3kQcHJlbG9hZEFuaW1hdGlvbgt0b3RhbFdlaWdodARtYXRoBnJhbmRvbQZ3ZWlnaHQNcm9sbEFuaW1hdGlvbg5xdWlya0FuaW1UcmFjawRpZGxlCWFuaW1UYWJsZQR3YXJuG05vIGFuaW1hdGlvbiBzZXQgZm91bmQgZm9yOgVxdWlyaxBjdXJyZW50QW5pbVRyYWNrBGFuaW0IQW5pbWF0b3IERW51bRFBbmltYXRpb25Qcmlvcml0eQZBY3Rpb24IUHJpb3JpdHkGTG9vcGVkB1N0b3BwZWQHQ29ubmVjdAtjdXJyZW50QW5pbQhNb3ZlbWVudA1wbGF5QW5pbWF0aW9uEXN0b3BBbGxBbmltYXRpb25zBHRpY2sNbGFzdFF1aXJrVGltZQx0cnlQbGF5UXVpcmsJQ2hhcmFjdGVyDVRyZWFkbWlsbE1vZGUMR2V0QXR0cmlidXRlDU1vdmVEaXJlY3Rpb24JTWFnbml0dWRlBHdhbGsDcnVuBVN0YXRzDkZpbmRGaXJzdENoaWxkCVNwcmludGluZwlCb29sVmFsdWUFVmFsdWUQcnVuT3ZlcnJpZGVWYWx1ZQtBZGp1c3RTcGVlZBF3YWxrT3ZlcnJpZGVWYWx1ZQlvblJ1bm5pbmcKQW5pbWF0aW9ucwRJZGxlBVF1aXJrBFdhbGsDUnVuBXBhaXJzCUFuaW1hdGlvbgJpZBxvdmVycmlkZUFuaW1hdGlvbnNXaXRoQ29uZmlnBWNvdW50C2Nvbm5lY3Rpb25zCEluc3RhbmNlA25ldwZQYXJlbnQFdGFibGUGaW5zZXJ0GUludmFsaWQgQW5pbWF0aW9uSWQgZm9yICcDJzogCHRvc3RyaW5nFWNvbmZpZ3VyZUFuaW1hdGlvblNldAhPdmVycmlkZQtOdW1iZXJWYWx1ZQhJbnRWYWx1ZQdDaGFuZ2VkFGNvbm5lY3RPdmVycmlkZVZhbHVlBm9uRGllZAR3YWl0DURpc2FibGVRdWlya3MISHVtYW5vaWQMV2FpdEZvckNoaWxkKU5vIGlkbGUgYW5pbWF0aW9uIGZvdW5kOyBpZGxlIHdvbid0IHBsYXkuB1J1bm5pbmcERGllZAljb3JvdXRpbmUEd3JhcA9TZXR1cEFuaW1hdGlvbnMccmJ4YXNzZXRpZDovLzEyMTk2MDkyMTkxNjM0MRxyYnhhc3NldGlkOi8vMTIzNzk3MjkxMjI0MDA5HHJieGFzc2V0aWQ6Ly8xMzU2Mjg0NzUwNDA0MTAbcmJ4YXNzZXRpZDovLzk4MTExNzMxMjcwODQyABMEAQAAAAYDAAAFAQMTuywAA1ICAACkAQEAAAAAQJ8BAgLwAQMAAgAAAKkBAACCAQIAbwMDALwBAOcEAAAAnwEDAisBBABvAwUAvAEA5wQAAACfAQMCggECAAYDAQQAAABAAwIDAwMEAwUAKAYBGAAAAAAAAAABAAMAAAAAAQAAAAApAAAAAAUCAAAAAA4OAAwAbwQAALwCAP4BAAAAnwIDAg4CBwBNAgCcAgAAAA4CBABSBAEAvAIA+gMAAACfAgMBggABAAQDBwMIAwkDCgAyCwEYAAAAAAAAAAAAAQAAAAIzAAAAAAcDAAAAABgOABYATQMAtgAAAAAOAxMAUgUAALwDAZQBAAAAnwMDAg4DDgCMBgAAvAQD7gIAAACfBAMBvAQD+gMAAACfBAIBvAQDUAQAAACfBAIBTQQAtgAAAACpBQEAagUCBIIAAQAFAwwDDQMOAwoDDwA9EAEYAAAAAAEAAAABAQAAAAEAAAEAAAEAAAADPgAAAAAIAQAAAAAeDgAFAE0BAJ0AAAAAjAIAAH0BAwACAAAAjAEBAIIBAgCkAQMAAAgQgIwCAQBNAwCdAAAAAJ8BAwKMAgAAjAUBABwDAACMBAEAqAMJAIcHAAVNBwfLBQAAAJAGBwRDAgIGfQECAAIAAACCBQIAiwP3/4wDAQCCAwIABgMRAxIDEwQACBCAAgAAAAAAAPA/AxQAShUBGAAAAAAAAAEAAwAAAAAAAQEAAAABAAAAAAEAAf0GAEsAAAAAAgABAAAABfsAAADGAQAAMAEAzAAAAACCAAEAAQMWAHsAARgAAAAAAXwAAAAADAQBAAAJBgAABQQDAg8PefAAAgAAAACAggABAE0FAw4BAAAAhwQFACsEBgCkBQMAAAAgQG8GBABSBwAAnwUDAYIAAQDwABQABQAAgE0FAx4GAAAADgUMAG8IBwC8BgX+CAAAAJ8GAwIOBgcATQYFnAkAAAAOBgQAbwgKALwGBfoLAAAAnwYDAcYFAAAwBQMeBgAAAGUAIQBNBQMeBgAAAA4FDABvCAcAvAYF/ggAAACfBgMCDgYHAE0GBZwJAAAADgYEAG8ICgC8BgX6CwAAAJ8GAwFNBQPMDAAAAA4FDABvCAcAvAYF/ggAAACfBgMCDgYHAE0GBZwJAAAADgYEAG8ICgC8BgX6CwAAAJ8GAwHGBQAAMAUDzAwAAAD7BQAAUgYEAJ8FAgKHBgQFTQcGLg0AAABNCAKMDgAAAFIKBwC8CAiUDwAAAJ8IAwLwABkABQAAgKQJEwASRADBMAkIzRQAAACpCQAAMAkItRUAAABSCwEAvAkI7hYAAACfCQMBMAgDzAwAAABNCQhlFwAAANkLAAASAAMAvAkJxxgAAACfCQMBbwkFADAJA1oZAAAAggABAKQJGwAaRADBMAkIzRQAAACpCQEAMAkItRUAAABSCwEAvAkI7hYAAACfCQMBMAgDHgYAAAAwAANaGQAAAIIAAQAcAxcDGAMZBAAAIEADGgMbAxwDBwMIAwkCmpmZmZmZyT8DCgMWAx0DHgMNAx8DIAMhBBJEAMEDIgMjAw4DJAMlAyYDJwQaRADBAQRbKAEYKQABAwAAAQEAAAAAAQQAAQDLAAAAAAAAAAABAAAANQAAAAIAyAAAAAAAAAAAAQAAADgAxwAAAAAAAAAAAQAAADkAAAMAAAEBAAIAAAAAAAIAAQAAAAEAAAEAAAABAAEAAAAAAAADAAAAAgAAAAEAAAEAAAABAAEAAjMAAAAABQEAAAAAKE0BAB4AAAAADgEMAG8EAQC8AgH+AgAAAJ8CAwIOAgcATQIBnAMAAAAOAgQAbwQEALwCAfoFAAAAnwIDAU0BAMwGAAAADgEMAG8EAQC8AgH+AgAAAJ8CAwIOAgcATQIBnAMAAAAOAgQAbwQEALwCAfoFAAAAnwIDAcYBAAAwAQAeAAAAAMYBAAAwAQDMBgAAAG8BBwAwAQBaCAAAAIIAAQAJAxwDBwMIAwkCmpmZmZmZyT8DCgMWAxcDJgCJASkBGFcAqQAAAAAAAAAAAQAAAFcAqAAAAAAAAAAAAQAAAFgAAAEAAAEAAAEzAAAAAAcCAQAAACJNAgBaAAAAAPACHgABAACATQIAzAIAAAArAhoApAMEAAAAMECfAwECTQQAngUAAAAmAgMEjAMIAGADEgACAAAApAIIAAAcYICfAgECbwMJAGACDAADAAAA+wIAAG8DCgBvBAsAUgUBAFIGAACfAgUBpAIEAAAAMECfAgECMAIAngUAAACCAAEADAMmAxcDFgMqBAAAMEADKwMSAxMEABxggAKamZmZmZm5PwMbAjMzMzMzM9M/AJIBLAEYAAAAAAEAAAEAAAAAAAAAAAIAAAAAAAEAAAAAAAEAAAAAA5MAAAAADgMBAAAAjgJNAwJpAAAAAG8FAQC8AwMSAgAAAJ8DAwIOAwEAggABAE0DAGkDAAAAbwQEALcBBgAEAAAATQQDqgUAAABvBQQAYAQ0AAUAAABNBAJaBgAAAPAEBQAHAAAATQQCWgYAAADwBCgACAAAgE0EAh4JAAAADgQMAG8HCgC8BQT+CwAAAJ8FAwIOBQcATQUEnAwAAAAOBQQAbwcNALwFBPoOAAAAnwUDAU0EAswPAAAADgQMAG8HCgC8BQT+CwAAAJ8FAwIOBQcATQUEnAwAAAAOBQQAbwcNALwFBPoOAAAAnwUDAcYEAAAwBAIeCQAAAMYEAAAwBALMDwAAAG8EEAAwBAJaBgAAAG8EEAAwBAJaBgAAAIIAAQCpBAAATQUCaQAAAABvBxEAvAUFAxIAAACfBQMCDgUMAG8IEwC8BgUDEgAAAJ8GAwIOBgcAbwkUALwHBv4LAAAAnwcDAg4HAgBNBAbsFQAAAA4EWgBNBgJaBgAAAPAGSQAIAAAATQcCDhYAAABNBgc2CAAAACsGBgCkBxgAAABwQW8IGQBvCQgAnwcDAWUAPQBNBwIeCQAAAA4HDABvCgoAvAgH/gsAAACfCAMCDggHAE0IB5wMAAAADggEAG8KDQC8CAf6DgAAAJ8IAwFNBwLMDwAAAA4HDABvCgoAvAgH/gsAAACfCAMCDggHAE0IB5wMAAAADggEAG8KDQC8CAf6DgAAAJ8IAwHGBwAAMAcCzA8AAAD7BwAAUggGAJ8HAgKHCAYHTQkILhoAAABNCgCMGwAAAFIMCQC8CgqUHAAAAJ8KAwKkCyAAH3jQwTALCs0hAAAAqQsBADALCrUiAAAAbw0NALwLCu4jAAAAnwsDATAKAh4JAAAAbwsIADALAloGAAAATQYCHgkAAAAOBgcATQYCHgkAAABNCAKnJAAAALwGBt8lAAAAnwYDAW8GCAAwBgJaBgAAAIIAAQBNBgJaBgAAAPAGSQAHAAAATQcCDhYAAABNBgf/BwAAACsGBgCkBxgAAABwQW8IGQBvCQcAnwcDAWUAPQBNBwIeCQAAAA4HDABvCgoAvAgH/gsAAACfCAMCDggHAE0IB5wMAAAADggEAG8KDQC8CAf6DgAAAJ8IAwFNBwLMDwAAAA4HDABvCgoAvAgH/gsAAACfCAMCDggHAE0IB5wMAAAADggEAG8KDQC8CAf6DgAAAJ8IAwHGBwAAMAcCzA8AAAD7BwAAUggGAJ8HAgKHCAYHTQkILhoAAABNCgCMGwAAAFIMCQC8CgqUHAAAAJ8KAwKkCyAAH3jQwTALCs0hAAAAqQsBADALCrUiAAAAbw0NALwLCu4jAAAAnwsDATAKAh4JAAAAbwsHADALAloGAAAATQYCHgkAAAAOBgcATQYCHgkAAABNCALUJgAAALwGBt8lAAAAnwYDAW8GBwAwBgJaBgAAAIIAAQAnAy0DLgMvAzACexSuR+F6hD8DMQMmAzIDMwMcAwcDCAMJApqZmZmZmck/AwoDFgMXAzQDNQM2AzcDOAMYAxkEAABwQQMaAx0DHgMNAx8DIAMnBB940MEDIgMjAw4DOQM6AzsAnwE8ARhuAAAAAAAAAQMAAQAAAAAAAAACAAAAAAAAAOIAqQAAAAAAAAAAAQAAAFcAqAAAAAAAAAAAAQAAAFgAAAEAAAEAAB0AAAEEAQAAAAAAAQEAAAABAAAAAAABAAQCAAAApQAAAAEBAAAAAAEIAMgAAAAAAAAAAAEAAAA4AMcAAAAAAAAAAAEAAAA5AAADAAABAQACAAAAAAAMAAAAAQAAAQAAAAEAAQAAOgAAAQAAAAAAAAIAAAADAAAAnAAAAAEBAAAAAAEIAMgAAAAAAAAAAAEAAAA4AMcAAAAAAAAAAAEAAAA5AAADAAABAQACAAAAAAAMAAAAAQAAAQAAAAEAAQAAQwAAAQAAAAAAAAIAAAIzAAAAAA4BAQAAADv7AQAAbwMAALwBAQMBAAAAnwEDAisBAQCCAAEA4gIKAKQDDAAAALBAUgQCAJ8DAgQXAysAUgoHALwIAQMBAAAAnwgDAg4IJgBvCw0AvAkI/g4AAACfCQMCDgkhAE0KCLYPAAAAuywKA1IMCgCkCxEAAAAAQZ8LAgLwCwMAEgAAAKkJAABlAAsAbw0TALwLCucUAAAAnwsDAlIJCwArCQUAbw0VALwLCucUAAAAnwsDAlIJCwAOCQoA/wkAAAEAAADiChkATQsItg8AAAAwCwr0FgAAAMUJCgIBAAAAagkABm4D1P8CAAAAggABABoDPQM1AxcDPgMbAz8DMgNAAzMDQQgEAgMAAAAEBQAAAAYHAAAACAkAAAADQgQAALBAA0MDCAMMAwEEAAAAQQMCAwMDBAMFA0QDFAIAAAAAAAAkQAgCFv////8XGAAAAADjAUUBGLsAAAAAAQECBgAAAAABAAAAAQAAAAAAAAA5AAAAAAAAAQADAAAAAAABAAAAAADDAAAAAAAAAAAA/QAGKQAAAAAPAgIAAABf4gIEAP8DAAAAAAAAMAMCkQMAAAAcAwEAMAMCnQIAAACkAwYAAABQQFIEAQCfAwIEFwNLAE0JB/QHAAAAuywJA1ILCQCkCgkAAACAQJ8KAgLwCgMACgAAAKkIAABlAAsAbwwLALwKCecMAAAAnwoDAlIICgArCAUAbwwNALwKCecMAAAAnwoDAlIICgAOCCcApAgQAAA84IBvCREAnwgCAk0JB/QHAAAAMAkIthIAAAD7CQAAMAkIJBMAAABNCgKdAgAAAJUJCgEwCQKdAgAAAOILFwAwCAsuFAAAAE0MB8sWAAAAMAwLnQIAAABNDAfLFgAAADAMC8sWAAAAnjQCBAsAAABSCgIApAkaAABkgIGfCQMBTQoCGgAAAACVCQoVMAkCGgAAAABlAA0ApAgcAAAAsEFvCh0AUgsAAG8MHgBNDgf0BwAAALs/DgKkDSAAAADwQZ8NAgJzCQoNnwgCAW4DtP8CAAAA+wMBAE0DAw4hAAAAagIDAIIAAQAiA0YCAAAAAAAAAAADEQNHCAMAAQAAAAIBAAAAA/////8DQgQAAFBAA0QDAQQAAIBAAwIDAwMEAwUDSANJBAA84IADQwMMA0oDHQIAAAAAAADwPwMUCAQU/////wAVAAAAAv////8W/////wNLA0wEAGSAgQMZBAAAsEEDTQNOA08EAADwQQMYAPkBUAEY0QAAAAABAAABAAAAAAEALAAAAAAAAAEAAwAAAAAAAQAAAAAA0AAAAAEAAAABAAACAAAAAAEBAAIAAAABAAAAAAAA/AAABgAAAAAAAgAAAAAAAAAAAAAAAPEAEgAAAAEpAAAAAAQBAgAAAC/7AQAA8AEXAAAAAID7AQEAMAAB1AEAAAD7AQEATQEBWgIAAADwASQAAwAAgPsBAQBNAQEeBAAAAA4BHwD7AQEATQEBHgQAAAD7AwEATQMD1AEAAAC8AQHfBQAAAJ8BAwGCAAEA+wEBADAAAacGAAAA+wEBAE0BAVoCAAAA8AEOAAcAAID7AQEATQEBHgQAAAAOAQkA+wEBAE0BAR4EAAAA+wMBAE0DA6cGAAAAvAEB3wUAAACfAQMBggABAAgDQAM7AyYDMgMcAzoDOQMzAL4CAAEYAAAAAQAAAQAAAAAAAAAAAQAAAAAAAAAAAAMAAAEAAAAAAAAAAAEAAAAAAAAAAAM/AQAAAAgDAQAAADAOAC4AUgYCAG8HAABzBQYHvAMAAwEAAACfAwMCDgMeAG8GAgC8BAP+AwAAAJ8EAwIrBAUAbwYEALwEA/4DAAAAnwQDAg4EFABNBAPsBQAAAPACBQAGAACA+wUAADAEBdQHAAAAZQADAPsFAAAwBAWnCAAAAE0FA4UJAAAA2QcAABIAAgASAgAAvAUFxwoAAACfBQMBggABAPACBQAGAACA+wQAADABBNQHAAAAggABAPsEAAAwAQSnCAAAAIIAAQALA1EDNQNSAwgDUwM4A0ADOwM5A1QDJQELtAJVARgAAQAAAAAAAQAAAAAAAAAAAAABAAEAAQAAAAIAAAIAAAAAAAAAAA4AAQAAAAIAAAQ1AQAAAA4BBAAAAJ8C+wEAAG8DAAC8AQESAQAAAJ8BAwIOAQEAggABAPsBAQBNAQFpAgAAAG8CAwC3AAYAAgAAAE0CAaoEAAAAbwMDAGACOAADAAAA+wICAE0CAloFAAAA8AIGAAYAAAD7AgIATQICWgUAAADwAikABwAAgPsCAgBNAwIeCAAAAA4DDABvBgkAvAQD/goAAACfBAMCDgQHAE0EA5wLAAAADgQEAG8GDAC8BAP6DQAAAJ8EAwFNAwLMDgAAAA4DDABvBgkAvAQD/goAAACfBAMCDgQHAE0EA5wLAAAADgQEAG8GDAC8BAP6DQAAAJ8EAwHGAwAAMAMCHggAAADGAwAAMAMCzA4AAABvAw8AMAMCWgUAAAD7AgIAbwMPADADAloFAAAAggABAKkCAAD7AwAAbwUQALwDAwMRAAAAnwMDAg4DDABvBhIAvAQDAxEAAACfBAMCDgQHAG8HEwC8BQT+CgAAAJ8FAwIOBQIATQIE7BQAAAAOAmEA+wQCAE0EBFoFAAAA8ARLAAcAAAD7BAEA+wUCAE0HBQ4VAAAATQYHNgcAAAArBgYApAcXAAAAYEFvCBgAbwkHAJ8HAwFlAD0ATQcFHggAAAAOBwwAbwoJALwIB/4KAAAAnwgDAg4IBwBNCAecCwAAAA4IBABvCgwAvAgH+g0AAACfCAMBTQcFzA4AAAAOBwwAbwoJALwIB/4KAAAAnwgDAg4IBwBNCAecCwAAAA4IBABvCgwAvAgH+g0AAACfCAMBxgcAADAHBcwOAAAA+wcDAFIIBgCfBwIChwgGB00JCC4ZAAAATQoEjBoAAABSDAkAvAoKlBsAAACfCgMCpAsfAB50wMEwCwrNIAAAAKkLAQAwCwq1IQAAAG8NDAC8CwruIgAAAJ8LAwEwCgUeCAAAAG8LBwAwCwVaBQAAAPsEAgBNBAQeCAAAAA4ECQD7BAIATQQEHggAAAD7BgIATQYGpyMAAAC8BATfJAAAAJ8EAwH7BAIAbwUHADAFBFoFAAAAggABAPsEAgBNBARaBQAAAPAESwAGAAAA+wQBAPsFAgBNBwUOFQAAAE0GB/8GAAAAKwYGAKQHFwAAAGBBbwgYAG8JBgCfBwMBZQA9AE0HBR4IAAAADgcMAG8KCQC8CAf+CgAAAJ8IAwIOCAcATQgHnAsAAAAOCAQAbwoMALwIB/oNAAAAnwgDAU0HBcwOAAAADgcMAG8KCQC8CAf+CgAAAJ8IAwIOCAcATQgHnAsAAAAOCAQAbwoMALwIB/oNAAAAnwgDAcYHAAAwBwXMDgAAAPsHAwBSCAYAnwcCAocIBgdNCQguGQAAAE0KBIwaAAAAUgwJALwKCpQbAAAAnwoDAqQLHwAedMDBMAsKzSAAAACpCwEAMAsKtSEAAABvDQwAvAsK7iIAAACfCwMBMAoFHggAAABvCwYAMAsFWgUAAAD7BAIATQQEHggAAAAOBAkA+wQCAE0EBB4IAAAA+wYCAE0GBtQlAAAAvAQE3yQAAACfBAMB+wQCAG8FBgAwBQRaBQAAAIIAAQAmAy4DLwMwAnsUrkfheoQ/AzEDJgMyAzMDHAMHAwgDCQKamZmZmZnJPwMKAxYDFwM0AzUDNgM3AzgDGAMZBAAAYEEDGgMdAx4DDQMfAyADJwQedMDBAyIDIwMOAzkDOgM7ANsCPAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABdAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAACb///8AAAAAqf///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAFcAAAAAAAAAqP///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAFgAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAAAAANgAAAAAAAAAAAAAAAAAAAABAAAABAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAQAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAA6v7//wAAAAAAAAAAAAAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAIAAAAAAAAAMj///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAA4AAAAAAAAAMf///8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAA5AAAAAAAAAAAAAAADAAAAAAAAAAAAAAABAAAAAQAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAQAAAAAAAAAAAAAA9AAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAOL+//8AAAAAAAAAAAAAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAABAAAACAAAAAAAAADI////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAOAAAAAAAAADH////AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAOQAAAAAAAAAAAAAAAwAAAAAAAAAAAAAAAQAAAAEAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAEAAAAAAAAAAAAAAPwAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAgAAAAAFAAEAAAAp+wAAAE0BAB4AAAAADgEMAG8EAQC8AgH+AgAAAJ8CAwIOAgcATQIBnAMAAAAOAgQAbwQEALwCAfoFAAAAnwIDAU0BAMwGAAAADgEMAG8EAQC8AgH+AgAAAJ8CAwIOAgcATQIBnAMAAAAOAgQAbwQEALwCAfoFAAAAnwIDAcYBAAAwAQAeAAAAAMYBAAAwAQDMBgAAAG8BBwAwAQBaCAAAAIIAAQAJAxwDBwMIAwkCmpmZmZmZyT8DCgMWAxcDJgCIA1YBAf8BV6kAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH/AABYqAAAAAAB/wAAigAAAKn///8AAAAAAAAAAAAAAAAAAAAAAQAAAAAAAABXAAAAqP///wAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAFgAAAABAAAAAAAAAAEAAAD8AAAAAAMBAQAAAAT7AQAAUgIAAJ8BAgGCAAEAAACMAwABGAAAAAGNAQAAAAMABAAAACD7AAAATQAAJAAAAABHABsAAAAAAKQAAgAAABBAbwEDAJ8AAgH7AAAAbwIEALwAABIFAAAAnwADAisADwD7AAAAbwIGALwAABIFAAAAnwADAisACQD7AAEATQAAWgcAAADwAAUACAAAgPsAAgD7AQEA+wIDAJ8AAwFIAOH/ggABAAkDSgNXBAAAEEACmpmZmZmZuT8DLgMvA1gDJgMXAJIDAAEYAAAAAAABAAAAAgAAAAAAAAAAAAAAAAAAAAABAAAA/AeTAQAAABQBAwAABgMAAAUBB7UB4gEMADAAAWkAAAAA/wIAAAAAAAAwAgEOCAAAAG8EDQC8AgDTDgAAAJ8CAwJvBQ8AvAMC0w4AAACfAwMC2QQAABIAAABSBQQA+wYAAJ8FAgHZBQEAEgACABIAAQCkBhEAAAAAQfsHAACfBgIEFwYEAFILBQBSDAkAUg0KAJ8LAwFuBvv/AgAAAP8GAAAAAAAApAcRAAAAAEFNCAEOCAAAAJ8HAgQXBy0AjA4BAE0MCxoSAAAAjA0BAKgMKACHDwsODg8lAIcPCw5NDw8uEwAAAA4PIQCHEAsOTRAQLhMAAABNEBC2FAAAAIcPBhArDxoAhw8LDk0PDy4TAAAADg8WAE0QD7YUAAAADhATAFISDwC8EAOUFQAAAJ8QAwIOEA4AjBMAALwREO4WAAAAnxEDAbwREPoXAAAAnxECAbwREFAYAAAAnxECAU0RD7YUAAAAqRIBAGoSBhGLDNj/bgfS/wIAAABNCAEOCAAAAE0HCPICAAAADgceAE0IBxoSAAAAjAkAAGAJGgAIAAAA+wgBAFIJBwCfCAIChwkHCE0KCS4TAAAAUg0KALwLA5QVAAAAnwsDAqQMHAAbaJDBMAwLzR0AAACpDAEAMAwLtR4AAACMDgAAvAwL7hYAAACfDAMBbwwCADAMAVoBAAAAZQAEAKQIIAAAAPBBbwkhAJ8IAgFvCSIAvAcAAyMAAACfBwMC2QgCABIAAQAOBxAAUgkIAG8MJAC8CgcDIwAAAJ8KAwKMCwEAbwwkAJ8JBAFSCQgAbwwlALwKBwMjAAAAnwoDAowLAQBvDCUAnwkEAdkJAwASAAAAEgACABIAAQASAgEA2QoEABIAAQBNCwLpJgAAANkNBQASAAkAvAsLxycAAACfCwMBTQsCxygAAABSDQoAvAsLxycAAACfCwMBpAsrAACokILZDAYAEgAAABIAAQASAgIAEgACAJ8LAgKfCwEBggECACwDLQMmAxcDHAADFgMrAgAAAAAAAAAAAxgDOwIAAAAAAADwPwM5CAgA/////wECAAAAAwQAAAAFBAAAAAYHAAAACP////8JCgAAAAsKAAAAA1kDWgMeA0IEAAAAQQNGAx0DDAMNAw4DCgMPAx8DIAM+BBtokMEDIgMjAxkEAADwQQNbAz0DNQNAA0EDXAMlA10DXgNfBACokIIHCQoMDQ4PENEBYAEHlgEABQAAAAUAAAABAAAAAwATAAADAAAYAAAAAAEAAAD/AAUAAQAAAAAAAQAAAAABAAAAAAABAAAAAAAAAQAAIwAAAAEAAAABAQAAAAEAAAEAAAEAAADU/wAMAAAAAQAAAAAAAQAAAQEAAQAAAAEAAAABAAABAAAAAQAAAAIAAAAQAAAAAQAhAQAAAAAAAAABAAAAAAAAAAQAAAAALQAEAAAAAAAAAwAAAAAAAwAAAAAAAAAIAj4AAAD1AAAAAAwAAAECADSjAAAA/wABAAAAAADiAQQA/wIAAAEAAADiAwkAxQIDAgEAAAAwAgHyAAAAAP8CAAABAAAA4gMLAMUCAwIBAAAAMAIBWAEAAAD/AgAAAQAAAOIDDQDFAgMCAQAAADACAf8CAAAA/wIAAAEAAADiAw8AxQIDAgEAAAAwAgE2AwAAAMACEADAAxEA/wQAAAAAAADABRIAwAYTAMAHFAASAAYAwAgVAMAJFgASAAcAwAoXABIABgDACxgAEgABABIABgASAAkAMAsAGxkAAACCAAIAGgMXAxsDMgMzBQQAAQIDA0QDYQMUAgAAAAAAACRACAIFBgAAAAcIAAAAA2IIAgUKAAAABwgAAAADYwgCBQwAAAAHCAAAAANkCAIFDgAAAAcIAAAABgAGAQYCBgMGBQYGBgcGCAYRA2AJAAECAwUGBwgRAQABBAAGAAMBAAEAAP8ABAABAADxAAQAAQAA/wAEAAEAAP8A+AoIAAMNEQAuCQANADIAAFcAANEBAAAADgAAABkAAACpAAAAABJJfAN//5kyS+aT+3HU5VWvOWQUC3u4aX4=

-- https://lua.expert/
local t = {}
local t2 = {
	idle = {
		{
			id = "rbxassetid://121960921916341",
			weight = 10
		}
	},
	quirk = {
		{
			id = "rbxassetid://123797291224009",
			weight = 10
		}
	},
	walk = {
		{
			id = "rbxassetid://135628475040410",
			weight = 10
		}
	},
	run = {
		{
			id = "rbxassetid://98111731270842",
			weight = 10
		}
	}
}

local function isValidAnimationId(p1) --[[ isValidAnimationId | Line: 40 ]]
	if typeof(p1) ~= "string" then
		return false
	end

	return p1:match("^rbxassetid://%d+$") or p1:match("^https://www%.roblox%.com/asset/%?id=%d+$")
end

local function safeStopAnimation(p1, p2) --[[ safeStopAnimation | Line: 50 ]]
	if not (p1 and (p1:IsA("AnimationTrack") and p1.IsPlaying)) then
		return
	end

	p1:Stop(p2)
end

local function preloadAnimation(p1, p2, p3) --[[ preloadAnimation | Line: 61 ]]
	if not (p1 and p1.AnimationId) then
		return
	end

	local v1 = p2:LoadAnimation(p1)

	if not v1 then
		return
	end

	v1:Play(0)
	v1:Stop()
	v1:Destroy()
	p3[p1.AnimationId] = true
end

local function rollAnimation(p1) --[[ rollAnimation | Line: 74 ]]
	if not p1 or p1.totalWeight <= 0 then
		return 1
	end

	local v1 = math.random(1, p1.totalWeight)
	local sum = 0

	for i = 1, #p1 do
		sum = sum + (p1[i].weight or 1)

		if v1 <= sum then
			return i
		end
	end

	return 1
end

local function playAnimation(p1, p2, p3, p4) --[[ playAnimation | Line: 91 | Upvalues: rollAnimation (copy) ]]
	if p1 == "idle" then
		return
	end

	local v1 = p4.animTable[p1]

	if not v1 then
		warn("No animation set found for:", p1)

		return
	end

	if p1 == "quirk" then
		local currentAnimTrack = p4.currentAnimTrack

		if currentAnimTrack and (currentAnimTrack:IsA("AnimationTrack") and currentAnimTrack.IsPlaying) then
			currentAnimTrack:Stop(0.2)
		end

		p4.currentAnimTrack = nil
	else
		local currentAnimTrack = p4.currentAnimTrack

		if currentAnimTrack and (currentAnimTrack:IsA("AnimationTrack") and currentAnimTrack.IsPlaying) then
			currentAnimTrack:Stop(0.2)
		end

		local quirkAnimTrack = p4.quirkAnimTrack

		if quirkAnimTrack and (quirkAnimTrack:IsA("AnimationTrack") and quirkAnimTrack.IsPlaying) then
			quirkAnimTrack:Stop(0.2)
		end

		p4.quirkAnimTrack = nil
	end

	local anim = v1[rollAnimation(v1)].anim
	local v2 = p3.Animator:LoadAnimation(anim)

	if p1 == "quirk" then
		v2.Priority = Enum.AnimationPriority.Action
		v2.Looped = false
		v2:Play(p2)
		p4.quirkAnimTrack = v2
		v2.Stopped:Connect(function() --[[ Line: 123 | Upvalues: p4 (copy) ]]
			p4.quirkAnimTrack = nil
		end)
		p4.currentAnim = "quirk"
	else
		v2.Priority = Enum.AnimationPriority.Movement
		v2.Looped = true
		v2:Play(p2)
		p4.currentAnimTrack = v2
		p4.currentAnim = p1
	end
end

local function stopAllAnimations(p1) --[[ stopAllAnimations | Line: 137 ]]
	local currentAnimTrack = p1.currentAnimTrack

	if currentAnimTrack and (currentAnimTrack:IsA("AnimationTrack") and currentAnimTrack.IsPlaying) then
		currentAnimTrack:Stop(0.2)
	end

	local quirkAnimTrack = p1.quirkAnimTrack

	if not (quirkAnimTrack and (quirkAnimTrack:IsA("AnimationTrack") and quirkAnimTrack.IsPlaying)) then
		p1.currentAnimTrack = nil
		p1.quirkAnimTrack = nil
		p1.currentAnim = "idle"

		return
	end

	quirkAnimTrack:Stop(0.2)
	p1.currentAnimTrack = nil
	p1.quirkAnimTrack = nil
	p1.currentAnim = "idle"
end

local function tryPlayQuirk(p1, p2) --[[ tryPlayQuirk | Line: 146 | Upvalues: playAnimation (copy) ]]
	if p1.currentAnim ~= "idle" or (p1.quirkAnimTrack or not (tick() - p1.lastQuirkTime > 8 and math.random() < 0.1)) then
		return
	end

	playAnimation("quirk", 0.3, p2, p1)
	p1.lastQuirkTime = tick()
end

local function onRunning(p1, p2, p3) --[[ onRunning | Line: 159 | Upvalues: rollAnimation (copy) ]]
	if p3.Character:GetAttribute("TreadmillMode") then
		return
	end

	if p2 < 0.01 or p1.MoveDirection.Magnitude < 0.01 then
		if p3.currentAnim == "walk" or p3.currentAnim == "run" then
			local currentAnimTrack = p3.currentAnimTrack

			if currentAnimTrack and (currentAnimTrack:IsA("AnimationTrack") and currentAnimTrack.IsPlaying) then
				currentAnimTrack:Stop(0.2)
			end

			local quirkAnimTrack = p3.quirkAnimTrack

			if quirkAnimTrack and (quirkAnimTrack:IsA("AnimationTrack") and quirkAnimTrack.IsPlaying) then
				quirkAnimTrack:Stop(0.2)
			end

			p3.currentAnimTrack = nil
			p3.quirkAnimTrack = nil
			p3.currentAnim = "idle"
		end

		p3.currentAnim = "idle"
	else
		local v1 = false
		local Stats = p3.Character:FindFirstChild("Stats")

		if Stats then
			local Sprinting = Stats:FindFirstChild("Sprinting")

			if Sprinting and Sprinting:IsA("BoolValue") then
				v1 = Sprinting.Value
			end
		end

		if v1 then
			if p3.currentAnim ~= "run" then
				local run = p3.animTable.run

				if run then
					local currentAnimTrack = p3.currentAnimTrack

					if currentAnimTrack and (currentAnimTrack:IsA("AnimationTrack") and currentAnimTrack.IsPlaying) then
						currentAnimTrack:Stop(0.2)
					end

					local quirkAnimTrack = p3.quirkAnimTrack

					if quirkAnimTrack and (quirkAnimTrack:IsA("AnimationTrack") and quirkAnimTrack.IsPlaying) then
						quirkAnimTrack:Stop(0.2)
					end

					p3.quirkAnimTrack = nil

					local anim = run[rollAnimation(run)].anim
					local v2 = p1.Animator:LoadAnimation(anim)

					v2.Priority = Enum.AnimationPriority.Movement
					v2.Looped = true
					v2:Play(0.2)
					p3.currentAnimTrack = v2
					p3.currentAnim = "run"
				else
					warn("No animation set found for:", "run")
				end
			end

			if p3.currentAnimTrack then
				p3.currentAnimTrack:AdjustSpeed(p3.runOverrideValue)
			end

			p3.currentAnim = "run"
		else
			if p3.currentAnim ~= "walk" then
				local walk = p3.animTable.walk

				if walk then
					local currentAnimTrack = p3.currentAnimTrack

					if currentAnimTrack and (currentAnimTrack:IsA("AnimationTrack") and currentAnimTrack.IsPlaying) then
						currentAnimTrack:Stop(0.2)
					end

					local quirkAnimTrack = p3.quirkAnimTrack

					if quirkAnimTrack and (quirkAnimTrack:IsA("AnimationTrack") and quirkAnimTrack.IsPlaying) then
						quirkAnimTrack:Stop(0.2)
					end

					p3.quirkAnimTrack = nil

					local anim = walk[rollAnimation(walk)].anim
					local v3 = p1.Animator:LoadAnimation(anim)

					v3.Priority = Enum.AnimationPriority.Movement
					v3.Looped = true
					v3:Play(0.2)
					p3.currentAnimTrack = v3
					p3.currentAnim = "walk"
				else
					warn("No animation set found for:", "walk")
				end
			end

			if p3.currentAnimTrack then
				p3.currentAnimTrack:AdjustSpeed(p3.walkOverrideValue)
			end

			p3.currentAnim = "walk"
		end
	end
end

function t.SetupAnimations(p1) --[[ SetupAnimations | Line: 209 | Upvalues: t2 (copy), rollAnimation (copy), tryPlayQuirk (copy) ]]
	local t = {
		currentAnim = "idle",
		currentAnimTrack = nil,
		quirkAnimTrack = nil,
		lastQuirkTime = 0,
		walkOverrideValue = 1,
		runOverrideValue = 1,
		Character = p1,
		animTable = {}
	}
	local Humanoid = p1:WaitForChild("Humanoid")
	local Animator = Humanoid:WaitForChild("Animator");

	(function(p12) --[[ overrideAnimationsWithConfig | Line: 227 | Upvalues: p1 (copy) ]]
		local Animations = p1:FindFirstChild("Animations")

		if not Animations then
			return
		end

		for k, v in pairs({
			idle = "Idle",
			quirk = "Quirk",
			walk = "Walk",
			run = "Run"
		}) do
			local v1
			local v2 = Animations:FindFirstChild(v)

			if v2 and v2:IsA("Animation") then
				local AnimationId = v2.AnimationId

				if typeof(AnimationId) == "string" then
					local v3 = AnimationId:match("^rbxassetid://%d+$")

					v1 = v3 or AnimationId:match("^https://www%.roblox%.com/asset/%?id=%d+$")
				else
					v1 = false
				end

				if v1 then
					p12[k] = {
						{
							weight = 10,
							id = v2.AnimationId
						}
					}
				end
			end
		end
	end)(t2)

	local function configureAnimationSet(p1, p2) --[[ configureAnimationSet | Line: 249 | Upvalues: Humanoid (copy), t (copy) ]]
		local t2 = {
			count = 0,
			totalWeight = 0,
			connections = {},
			totalWeight = #p2
		}

		for k, v in pairs(p2) do
			local v1
			local id = v.id

			if typeof(id) == "string" then
				local v2 = id:match("^rbxassetid://%d+$")

				v1 = v2 or id:match("^https://www%.roblox%.com/asset/%?id=%d+$")
			else
				v1 = false
			end

			if v1 then
				local Animation = Instance.new("Animation")

				Animation.AnimationId = v.id
				Animation.Parent = Humanoid
				t2.totalWeight = t2.totalWeight + 0
				table.insert(t2, {
					count = 1,
					anim = Animation,
					totalWeight = v.weight,
					weight = v.weight
				})
				t2.count = t2.count + 1

				continue
			end

			local v4 = warn

			v4("Invalid AnimationId for \'" .. p1 .. "\': " .. tostring(v.id))
		end

		t.animTable[p1] = t2
	end

	for k, v in pairs(t2) do
		configureAnimationSet(k, v)
	end

	local t3 = {}

	for k, v in pairs(t.animTable) do
		for i = 1, v.count do
			if v[i] and (v[i].anim and not t3[v[i].anim.AnimationId]) then
				local anim = v[i].anim

				if anim and anim.AnimationId then
					local v1 = Animator:LoadAnimation(anim)

					if v1 then
						v1:Play(0)
						v1:Stop()
						v1:Destroy()
						t3[anim.AnimationId] = true
					end
				end
			end
		end
	end

	local idle = t.animTable.idle

	if idle and idle.count > 0 then
		local v2 = Animator:LoadAnimation(idle[rollAnimation(idle)].anim)

		v2.Priority = Enum.AnimationPriority.Idle
		v2.Looped = true
		v2:Play(0)
		t.currentAnim = "idle"
	else
		warn("No idle animation found; idle won\'t play.")
	end

	local Animations = p1:FindFirstChild("Animations")

	local function connectOverrideValue(p1, p2, p3) --[[ connectOverrideValue | Line: 308 | Upvalues: t (copy) ]]
		if not p1 then
			return
		end

		local v1 = p1:FindFirstChild(p3 .. "Override")

		if v1 and (v1:IsA("NumberValue") or v1:IsA("IntValue")) then
			local v2 = v1.Value

			if p3 == "Walk" then
				t.walkOverrideValue = v2
			else
				t.runOverrideValue = v2
			end

			v1.Changed:Connect(function(p1) --[[ Line: 318 | Upvalues: p3 (copy), t (ref) ]]
				if p3 == "Walk" then
					t.walkOverrideValue = p1

					if t.currentAnim == "walk" and t.currentAnimTrack then
						t.currentAnimTrack:AdjustSpeed(t.walkOverrideValue)
					end
				else
					t.runOverrideValue = p1

					if t.currentAnim ~= "run" or not t.currentAnimTrack then
						return
					end

					t.currentAnimTrack:AdjustSpeed(t.runOverrideValue)
				end
			end)
		else
			if p3 == "Walk" then
				t.walkOverrideValue = p2

				return
			end

			t.runOverrideValue = p2
		end
	end

	local v3, v4

	if not Animations then
		v3 = function(p13) --[[ onRunning | Line: 347 | Upvalues: p1 (copy), Humanoid (copy), t (copy), rollAnimation (ref) ]]
			if p1:GetAttribute("TreadmillMode") then
				return
			end

			if p13 < 0.01 or Humanoid.MoveDirection.Magnitude < 0.01 then
				if t.currentAnim == "walk" or t.currentAnim == "run" then
					local v1 = t
					local currentAnimTrack = v1.currentAnimTrack

					if currentAnimTrack and (currentAnimTrack:IsA("AnimationTrack") and currentAnimTrack.IsPlaying) then
						currentAnimTrack:Stop(0.2)
					end

					local quirkAnimTrack = v1.quirkAnimTrack

					if quirkAnimTrack and (quirkAnimTrack:IsA("AnimationTrack") and quirkAnimTrack.IsPlaying) then
						quirkAnimTrack:Stop(0.2)
					end

					v1.currentAnimTrack = nil
					v1.quirkAnimTrack = nil
					v1.currentAnim = "idle"
				end

				t.currentAnim = "idle"
			else
				local v2 = false
				local Stats = p1:FindFirstChild("Stats")

				if Stats then
					local Sprinting = Stats:FindFirstChild("Sprinting")

					if Sprinting and Sprinting:IsA("BoolValue") then
						v2 = Sprinting.Value
					end
				end

				if v2 then
					if t.currentAnim ~= "run" then
						local v3 = Humanoid
						local v4 = t
						local run = v4.animTable.run

						if run then
							local currentAnimTrack = v4.currentAnimTrack

							if currentAnimTrack and (currentAnimTrack:IsA("AnimationTrack") and currentAnimTrack.IsPlaying) then
								currentAnimTrack:Stop(0.2)
							end

							local quirkAnimTrack = v4.quirkAnimTrack

							if quirkAnimTrack and (quirkAnimTrack:IsA("AnimationTrack") and quirkAnimTrack.IsPlaying) then
								quirkAnimTrack:Stop(0.2)
							end

							v4.quirkAnimTrack = nil

							local anim = run[rollAnimation(run)].anim
							local v5 = v3.Animator:LoadAnimation(anim)

							v5.Priority = Enum.AnimationPriority.Movement
							v5.Looped = true
							v5:Play(0.2)
							v4.currentAnimTrack = v5
							v4.currentAnim = "run"
						else
							warn("No animation set found for:", "run")
						end
					end

					if t.currentAnimTrack then
						t.currentAnimTrack:AdjustSpeed(t.runOverrideValue)
					end

					t.currentAnim = "run"
				else
					if t.currentAnim ~= "walk" then
						local v6 = Humanoid
						local v7 = t
						local walk = v7.animTable.walk

						if walk then
							local currentAnimTrack = v7.currentAnimTrack

							if currentAnimTrack and (currentAnimTrack:IsA("AnimationTrack") and currentAnimTrack.IsPlaying) then
								currentAnimTrack:Stop(0.2)
							end

							local quirkAnimTrack = v7.quirkAnimTrack

							if quirkAnimTrack and (quirkAnimTrack:IsA("AnimationTrack") and quirkAnimTrack.IsPlaying) then
								quirkAnimTrack:Stop(0.2)
							end

							v7.quirkAnimTrack = nil

							local anim = walk[rollAnimation(walk)].anim
							local v8 = v6.Animator:LoadAnimation(anim)

							v8.Priority = Enum.AnimationPriority.Movement
							v8.Looped = true
							v8:Play(0.2)
							v7.currentAnimTrack = v8
							v7.currentAnim = "walk"
						else
							warn("No animation set found for:", "walk")
						end
					end

					if t.currentAnimTrack then
						t.currentAnimTrack:AdjustSpeed(t.walkOverrideValue)
					end

					t.currentAnim = "walk"
				end
			end
		end
		v4 = function() --[[ onDied | Line: 392 | Upvalues: t (copy) ]]
			local v1 = t
			local currentAnimTrack = v1.currentAnimTrack

			if currentAnimTrack and (currentAnimTrack:IsA("AnimationTrack") and currentAnimTrack.IsPlaying) then
				currentAnimTrack:Stop(0.2)
			end

			local quirkAnimTrack = v1.quirkAnimTrack

			if quirkAnimTrack and (quirkAnimTrack:IsA("AnimationTrack") and quirkAnimTrack.IsPlaying) then
				quirkAnimTrack:Stop(0.2)
			end

			v1.currentAnimTrack = nil
			v1.quirkAnimTrack = nil
			v1.currentAnim = "idle"
		end
		Humanoid.Running:Connect(function(p13) --[[ Line: 396 | Upvalues: v3 (copy) ]]
			v3(p13)
		end)
		Humanoid.Died:Connect(v4)
		coroutine.wrap(function() --[[ Line: 402 | Upvalues: p1 (copy), t (copy), tryPlayQuirk (ref), Humanoid (copy) ]]
			while p1.Parent ~= nil do
				wait(0.1)

				if p1:GetAttribute("TreadmillMode") or (p1:GetAttribute("DisableQuirks") or t.currentAnim ~= "idle") then
					continue
				end

				tryPlayQuirk(t, Humanoid)
			end
		end)()

		return t
	end

	connectOverrideValue(Animations:FindFirstChild("Walk"), 1, "Walk")
	connectOverrideValue(Animations:FindFirstChild("Run"), 1, "Run")
	v3 = function(p13) --[[ onRunning | Line: 347 | Upvalues: p1 (copy), Humanoid (copy), t (copy), rollAnimation (ref) ]]
		if p1:GetAttribute("TreadmillMode") then
			return
		end

		if p13 < 0.01 or Humanoid.MoveDirection.Magnitude < 0.01 then
			if t.currentAnim == "walk" or t.currentAnim == "run" then
				local v1 = t
				local currentAnimTrack = v1.currentAnimTrack

				if currentAnimTrack and (currentAnimTrack:IsA("AnimationTrack") and currentAnimTrack.IsPlaying) then
					currentAnimTrack:Stop(0.2)
				end

				local quirkAnimTrack = v1.quirkAnimTrack

				if quirkAnimTrack and (quirkAnimTrack:IsA("AnimationTrack") and quirkAnimTrack.IsPlaying) then
					quirkAnimTrack:Stop(0.2)
				end

				v1.currentAnimTrack = nil
				v1.quirkAnimTrack = nil
				v1.currentAnim = "idle"
			end

			t.currentAnim = "idle"
		else
			local v2 = false
			local Stats = p1:FindFirstChild("Stats")

			if Stats then
				local Sprinting = Stats:FindFirstChild("Sprinting")

				if Sprinting and Sprinting:IsA("BoolValue") then
					v2 = Sprinting.Value
				end
			end

			if v2 then
				if t.currentAnim ~= "run" then
					local v3 = Humanoid
					local v4 = t
					local run = v4.animTable.run

					if run then
						local currentAnimTrack = v4.currentAnimTrack

						if currentAnimTrack and (currentAnimTrack:IsA("AnimationTrack") and currentAnimTrack.IsPlaying) then
							currentAnimTrack:Stop(0.2)
						end

						local quirkAnimTrack = v4.quirkAnimTrack

						if quirkAnimTrack and (quirkAnimTrack:IsA("AnimationTrack") and quirkAnimTrack.IsPlaying) then
							quirkAnimTrack:Stop(0.2)
						end

						v4.quirkAnimTrack = nil

						local anim = run[rollAnimation(run)].anim
						local v5 = v3.Animator:LoadAnimation(anim)

						v5.Priority = Enum.AnimationPriority.Movement
						v5.Looped = true
						v5:Play(0.2)
						v4.currentAnimTrack = v5
						v4.currentAnim = "run"
					else
						warn("No animation set found for:", "run")
					end
				end

				if t.currentAnimTrack then
					t.currentAnimTrack:AdjustSpeed(t.runOverrideValue)
				end

				t.currentAnim = "run"
			else
				if t.currentAnim ~= "walk" then
					local v6 = Humanoid
					local v7 = t
					local walk = v7.animTable.walk

					if walk then
						local currentAnimTrack = v7.currentAnimTrack

						if currentAnimTrack and (currentAnimTrack:IsA("AnimationTrack") and currentAnimTrack.IsPlaying) then
							currentAnimTrack:Stop(0.2)
						end

						local quirkAnimTrack = v7.quirkAnimTrack

						if quirkAnimTrack and (quirkAnimTrack:IsA("AnimationTrack") and quirkAnimTrack.IsPlaying) then
							quirkAnimTrack:Stop(0.2)
						end

						v7.quirkAnimTrack = nil

						local anim = walk[rollAnimation(walk)].anim
						local v8 = v6.Animator:LoadAnimation(anim)

						v8.Priority = Enum.AnimationPriority.Movement
						v8.Looped = true
						v8:Play(0.2)
						v7.currentAnimTrack = v8
						v7.currentAnim = "walk"
					else
						warn("No animation set found for:", "walk")
					end
				end

				if t.currentAnimTrack then
					t.currentAnimTrack:AdjustSpeed(t.walkOverrideValue)
				end

				t.currentAnim = "walk"
			end
		end
	end
	v4 = function() --[[ onDied | Line: 392 | Upvalues: t (copy) ]]
		local v1 = t
		local currentAnimTrack = v1.currentAnimTrack

		if currentAnimTrack and (currentAnimTrack:IsA("AnimationTrack") and currentAnimTrack.IsPlaying) then
			currentAnimTrack:Stop(0.2)
		end

		local quirkAnimTrack = v1.quirkAnimTrack

		if quirkAnimTrack and (quirkAnimTrack:IsA("AnimationTrack") and quirkAnimTrack.IsPlaying) then
			quirkAnimTrack:Stop(0.2)
		end

		v1.currentAnimTrack = nil
		v1.quirkAnimTrack = nil
		v1.currentAnim = "idle"
	end
	Humanoid.Running:Connect(function(p13) --[[ Line: 396 | Upvalues: v3 (copy) ]]
		v3(p13)
	end)
	Humanoid.Died:Connect(v4)
	coroutine.wrap(function() --[[ Line: 402 | Upvalues: p1 (copy), t (copy), tryPlayQuirk (ref), Humanoid (copy) ]]
		while p1.Parent ~= nil do
			wait(0.1)

			if p1:GetAttribute("TreadmillMode") or (p1:GetAttribute("DisableQuirks") or t.currentAnim ~= "idle") then
				continue
			end

			tryPlayQuirk(t, Humanoid)
		end
	end)()

	return t
end

return t