dofile(LockOn_Options.common_script_path .. "elements_defs.lua")
dofile(LockOn_Options.common_script_path.."KNEEBOARD/indicator/definitions.lua")
dofile(LockOn_Options.script_path .. "materials.lua")

SetScale(FOV)

--MFCD_HDG_SCALE = 0.7/275
--MFCD_HDG_DISPL = (3448 * MFCD_HDG_SCALE / 480) * GetScale()

IndTexture_Path    = IND_TEX_PATH

KBD_COLOR_DEF     = materials["MFCD_IND_DEF"] --{128,255,0,255}
KBD_COLOR_RED     = materials["MFCD_IND_RED"]
KBD_COLOR_GREEN   = materials["MFCD_IND_GREEN"]
KBD_COLOR_DGREEN  = materials["MFCD_IND_DGREEN"] -- {3,67,40,15}
KBD_COLOR_BLUE    = materials["MFCD_IND_BLUE"]
KBD_COLOR_BLACK   = materials["MFCD_IND_BLACK"]
KBD_COLOR_DARK    = materials["MFCD_IND_DARK"]
KBD_COLOR_WHITE   = materials["MFCD_IND_WHITE"]
KBD_COLOR_WHITE_Y = materials["MFCD_IND_WHITE_Y"]
KBD_COLOR_PINK    = materials["MFCD_IND_PINK"]
KBD_COLOR_YELLOW  = materials["MFCD_IND_YELLOW"]
KBD_COLOR_SKY     = materials["MFCD_IND_SKY"]
KBD_COLOR_GRND    = materials["MFCD_IND_GRND"]
KBD_COLOR_BOXBASE = materials["MFCD_IND_BOXBASE"]
KBD_COLOR_W_BASE  = materials["MFCD_IND_W_BASE"]


KBD_FONT_DEF    = "mfcd_font_def"
KBD_FONT_R      = "mfcd_font_r"
KBD_FONT_G      = "mfcd_font_g"
KBD_FONT_DG     = "mfcd_font_dg"
KBD_FONT_B      = "mfcd_font_b"
KBD_FONT_W      = "mfcd_font_w"
KBD_FONT_WY     = "mfcd_font_wy"
KBD_FONT_D      = "mfcd_font_bk"


FONT_SCALE = MFCD_Y_PIXEL/MFCD_X_PIXEL
FONT_SIZE  = 0.005

FONT_W = FONT_SIZE * 144 / 128
FONT_H = FONT_W * FONT_SCALE

H2W_SCALE = GetAspect()

local t_scale = 1

-- 字体高宽 1:1        {    高,      宽,  字间,  行间,  水平偏,  垂直偏}
KBD_STRINGDEFS_ORIG = {FONT_W, FONT_W,    0,     0,      0,     0}

KBD_STRINGDEFS_DEF  = {0.80 * FONT_W, 0.80 * FONT_W, 0, 0}

-- 大号字, 用作标题
KBD_STRINGDEFS_DEF_X05  = {t_scale*0.50*FONT_W, 0.50*FONT_W, 0, 0}
KBD_STRINGDEFS_DEF_X06  = {t_scale*0.60*FONT_W, 0.60*FONT_W, 0, 0}
KBD_STRINGDEFS_DEF_X07  = {t_scale*0.70*FONT_W, 0.70*FONT_W, 0, 0}
KBD_STRINGDEFS_DEF_X075 = {t_scale*0.75*FONT_W, 0.75*FONT_W, 0, 0}
KBD_STRINGDEFS_DEF_X08  = {t_scale*0.80*FONT_W, 0.80*FONT_W, 0, 0}
KBD_STRINGDEFS_DEF_X09  = {t_scale*0.90*FONT_W, 0.90*FONT_W, 0, 0}
KBD_STRINGDEFS_DEF_X10  = {t_scale*1.00*FONT_W, 1.00*FONT_W, 0, 0}
KBD_STRINGDEFS_DEF_X12  = {t_scale*1.20*FONT_W, 1.20*FONT_W, 0, 0}
KBD_STRINGDEFS_DEF_X15  = {t_scale*1.50*FONT_W, 1.50*FONT_W, 0, 0}
KBD_STRINGDEFS_DEF_X2   = {t_scale*2.00*FONT_W, 2.00*FONT_W, 0, 0}

DEF_BOX_INDICES = { 0,1,2, 0,2,3 }

------[[ 标签坐标 ]]------

KBD_TITLE_X = 0
KBD_TITLE_Y = H2W_SCALE - 0.2


------[[ 标签坐标 ]]------


function AddElement(object)
    object.use_mipfilter = true
    Add(object)
end

function AddStrTblElements(text_elem, parent)

    local text_strpoly

    for i=1, #(text_elem) do
        text_strpoly                 = CreateElement "ceStringPoly"
        text_strpoly.material        = KBD_FONT_B
        text_strpoly.stringdefs      = KBD_STRINGDEFS_DEF
        text_strpoly.init_pos        = text_elem[i].init_pos or {0.0, 0.0}
        text_strpoly.alignment       = "CenterCenter"
        text_strpoly.parent_element  = "KBDBase"
        
        if parent then
            text_strpoly.parent_element = KBDBase.name
        end
        
        if text_elem[i].mat then
            text_strpoly.material = text_elem[i].mat
        end  
        
        if text_elem[i].strdefs then
            text_strpoly.stringdefs = text_elem[i].strdefs
        end   
        if text_elem[i].align then
            text_strpoly.alignment = text_elem[i].align
        end    
        if text_elem[i].formats then
            text_strpoly.formats = text_elem[i].formats
        end
        if text_elem[i].params then
            text_strpoly.element_params = text_elem[i].params
        end
        if text_elem[i].ctrls then
            text_strpoly.controllers = text_elem[i].ctrls
        end
        if text_elem[i].value then
            text_strpoly.value = text_elem[i].value
        end
        
        AddElement(text_strpoly)
        text_strpoly = nil
    end
    
end

add_picture(LockOn_Options.script_path.."../Textures/IndicationTextures/kneebrd_page.dds")
