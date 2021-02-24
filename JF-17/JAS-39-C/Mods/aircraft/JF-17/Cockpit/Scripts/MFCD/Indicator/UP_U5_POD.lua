dofile(LockOn_Options.script_path .. "MFCD/MFCDs_defs.lua")

local page_root = create_page_root()

-- POD 选择菜单
local osb_txt = {
    {name="POD",    value="POD",             init_pos={MFCD_FONT_UD1_X,    MFCD_FONT_U_Y  }, align="CenterCenter",                                }, -- 返回主页面
    {name="WMD7",   value="W\nM\nD\n7",      init_pos={MFCD_FONT_R_HORI_X, MFCD_FONT_LR1_Y}, align="RightCenter",  controllers={{"POD_Check",1},},}, -- WMD7 POD
    --{name="SPJ",    value="S\nP\nJ",         init_pos={MFCD_FONT_R_HORI_X, MFCD_FONT_LR2_Y}, align="RightCenter",  controllers={{"POD_Check",2},},}, -- SPJ POD
    --{name="IRST",   value="I\nR\nS\nT",      init_pos={MFCD_FONT_R_HORI_X, MFCD_FONT_LR3_Y}, align="RightCenter",  controllers={{"POD_Check",3},},}, -- IRST POD
    {name="MIL",    value="M\nI\nL",         init_pos={MFCD_FONT_R_HORI_X, MFCD_FONT_LR4_Y}, align="RightCenter",  controllers={{"POD_Check",4},},}, -- MIL POD
    {name="TV",     value="T\nV\nI\nR",      init_pos={MFCD_FONT_L_HORI_X, MFCD_FONT_LR1_Y}, align="LeftCenter",   controllers={{"POD_Check",5},},}, -- TVIR seeker
    --{name="ARM",    value="A\nR\nM",         init_pos={MFCD_FONT_L_HORI_X, MFCD_FONT_LR2_Y}, align="LeftCenter",   controllers={{"POD_Check",6},},}, -- ARM seeker
}

local text_strpoly
local mesh_poly

for i=1, #(osb_txt) do
    text_strpoly                    = CreateElement "ceStringPoly"
    text_strpoly.material           = MFCD_FONT_DEF
    text_strpoly.BackgroundMaterial = MFCD_MATERIAL_BLACK
    text_strpoly.stringdefs         = MFCD_STRINGDEFS_DEF_X08
    text_strpoly.init_pos           = osb_txt[i].init_pos
    text_strpoly.alignment          = osb_txt[i].align

    if osb_txt[i].controllers == nil then
        osb_txt[i].controllers = {}
    end
    osb_txt[i].controllers[#osb_txt[i].controllers + 1] = {"string_background_color", 0,0,0}
    text_strpoly.controllers = osb_txt[i].controllers
    
    if osb_txt[i].value ~= nil then
        text_strpoly.value = osb_txt[i].value
    else
        text_strpoly.value = "OSB" .. i
    end
    AddToUpper(text_strpoly)
    text_strpoly = nil
end
