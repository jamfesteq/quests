--- @param e PlayerEventCommand
local function mighty_debug(e)
    local mighty_debug = e.self:GetBucket("mighty_debug")
    if mighty_debug == "ON" then
        mighty_debug = "OFF"
    else
        mighty_debug = "ON"
    end
    e.self:SetBucket("mighty_debug", mighty_debug)
    e.self:Message(MT.Say, "Mighty combat debug messaging is now " .. mighty_debug)
end

return mighty_debug;