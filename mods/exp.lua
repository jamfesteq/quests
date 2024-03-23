---@param e ModGetExperienceForKill
function GetExperienceForKill(e)
    --TODO: check if buckets enabled, if not just return

    local base_exp = get_base_experience(e)
    e.self:Message(MT.White, "Base:" .. base_exp)

    --TODO: add modifiers here

    --e.self:Message(15, "You killed a " .. e.mob:GetCleanName() .. " and gained " .. e.exp .. " experience.");
end

---@param e ModGetExperienceForKill
---@return number exp
function get_base_experience(e)
    local exp = 0
    local against = e.other
    if not against.valid then
        return exp
    end
    if not against:IsNPC() then
        return exp
    end
    local level = against:GetLevel()
    exp = (level * level * 75 * 35 / 10) -- EXP_FORMULA
    local mod = 0
    --against:CastToNPC():GetKillExpMod() -- TODO: this isn't exposed to API?
    if mod >= 0 then
        exp = exp *mod
        exp = exp / 100
    end

    return exp
end