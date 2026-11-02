-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    transaction_invalid_action = { msg = "Regular action at %s:%s cannot be used inside a transaction for modifying data." },
    transaction_invalid_function = { msg = "Unregistered function at %s:%s cannot be used inside a transaction for modifying data." },
    action_invalid_function = { msg = "Unregistered function at %s:%s cannot be used for patching data." },
    action_attempt_transaction = { msg = "Action at %s:%s can only be used for patching within transactions." },
    cannot_make_action = { msg = "Unable to register a new action after the first session has been started." },
    unknown_transaction_action = { msg = "Unable to perform an action named %s?" },
    action_does_not_return = { msg = "Action %s does not return any data." },
    migration_does_not_return = { msg = "Migration %s does not return any data." },
    strict_impure_action = { msg = "Action at %s:%s is impure and does not yield the same result. Path: %s" },
    strict_not_json_from_action = { msg = "Action %s is not valid JSON: %s" },
    strict_pass_not_json_into_action = { msg = "Actions within transactions can only accept valid JSON for parameters! (at %s)" },
    schema_validation_error = { msg = "Schema validation failed on %s after action %s." },
    session_already_stopped = { msg = "Session already stopped!" },
    cannot_cancel_action = { msg = "Cannot cancel the action \"%s\" by passing nil!" }
}

local function THROW(v2, ...) -- line 66 | captures: v1
    error(string.format(v1[v2].msg, ...), 2)
end

return THROW
