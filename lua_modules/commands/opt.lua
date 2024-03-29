local commands = { }

commands["4x"] = { require("lua_modules/commands/opt/boost_4x"), "Toggle experience boost by 4x"}
commands["exp_debug"] = { require("lua_modules/commands/opt/exp_debug"), "Toggle experience debug messaging"}

---@param e PlayerEventCommand
local function opt(e)
    if #e.args < 1 then
        opt_usage(e)
        return
    end

    local command = commands[e.args[1]];
    if not command then
        e.self:Message(MT.White("Unknown option: " .. e.args[2]))
        opt_usage(e)
        return
    end

    local func = command[1]
    func(e)
end

---@param e PlayerEventCommand
function opt_usage(e)
    local val = e.self:GetBucket("boost_4x");
    if val ~= "ON" then
        val = "OFF"
    end

    e.self:Message(MT.White, "exp: [".. eq.say_link("#opt 4x", true, "4x " .. val).."]");

    val = e.self:GetBucket("exp_debug");
    if val ~= "ON" then
        val = "OFF"
    end

    e.self:Message(MT.White, "exp: [".. eq.say_link("#opt exp_debug", true, "exp_debug " .. val).."]");
end

return opt;