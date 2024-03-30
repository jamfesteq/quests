local experience = {}


---@param against Mob
---@return number exp
function experience.get_base(against)
    local exp = 0
    if not against.valid then
        eq.debug("Invalid mob")
        return exp
    end
    if not against:IsNPC() then
        eq.debug("Not an NPC")
        return exp
    end
    local level = against:GetLevel()
    exp = (level * level * 75 * 35 / 10) -- EXP_FORMULA
    local mod = 0
    --against:CastToNPC():GetKillExpMod() -- TODO: this isn't exposed to API?
    if mod > 0 then
        exp = exp *mod
        exp = exp / 100
    end

    return exp
end

return experience