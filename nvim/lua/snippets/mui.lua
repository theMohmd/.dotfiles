local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Add MUI-specific snippets to typescriptreact filetype
ls.add_snippets("typescriptreact", {
  -- MUI sx prop utilities
  s("msx", fmt("{{ xs:{1},md:{2} }}", {i(1), i(2)})),
  s("mblack", t("sx={{backgroundColor:\"black\"}}")),

  -- Components
  s("mbox", fmt("<Box{1}>{2}</Box>",{i(1),i(2)})),
  s("mtypography", fmt("<Typography{1}>{2}</Typography>",{i(1),i(2)})),
  s("mbutton", fmt("<Button{1}>{2}</Button>",{i(1),i(2)})),
  
  -- Flexbox utilities
  s("mflex", t("display=\"flex\"")),
  s("mflexcolumn", t("flexDirection=\"column\"")),
  s("mflexrow", t("flexDirection=\"row\"")),
  s("mflexwrap", t("flexWrap=\"wrap\"")),
  s("mflexnowrap", t("flexWrap=\"nowrap\"")),
  
  -- Alignment utilities
  s("mitemscenter", t("alignItems=\"center\"")),
  s("mitemsstart", t("alignItems=\"flex-start\"")),
  s("mitemsend", t("alignItems=\"flex-end\"")),
  s("mitemsstretch", t("alignItems=\"stretch\"")),
  s("mjustifycenter", t("justifyContent=\"center\"")),
  s("mjustifystart", t("justifyContent=\"flex-start\"")),
  s("mjustifyend", t("justifyContent=\"flex-end\"")),
  s("mjustifybetween", t("justifyContent=\"space-between\"")),
  s("mjustifyaround", t("justifyContent=\"space-around\"")),
  s("mjustifyevenly", t("justifyContent=\"space-evenly\"")),
  
  -- Flex properties
  s("mflex1", t("flex={1}")),
  s("mflexgrow", t("flexGrow={1}")),
  s("mflexshrink", t("flexShrink={1}")),
  
  -- Position utilities
  s("mrel", t("position=\"relative\"")),
  s("mabs", t("position=\"absolute\"")),
  s("mfix", t("position=\"fixed\"")),
  s("msticky", t("position=\"sticky\"")),
  
  -- Display utilities
  s("mblock", t("display=\"block\"")),
  s("minline", t("display=\"inline\"")),
  s("minlineblock", t("display=\"inline-block\"")),
  s("mnone", t("display=\"none\"")),
  s("mgrid", t("display=\"grid\"")),
  
  -- Overflow utilities
  s("moverhidden", t("overflow=\"hidden\"")),
  s("moverscroll", t("overflow=\"scroll\"")),
  s("moverauto", t("overflow=\"auto\"")),
  s("moverxhidden", t("overflowX=\"hidden\"")),
  s("moveryhidden", t("overflowY=\"hidden\"")),
  
  -- Width & Height utilities
  s("mw100", t("width=\"100%\"")),
  s("mwfull", t("width=\"100%\"")),
  s("mwauto", t("width=\"auto\"")),
  s("mh100", t("height=\"100%\"")),
  s("mhfull", t("height=\"100%\"")),
  s("mhauto", t("height=\"auto\"")),
  
  -- Margin utilities
  s("m0", t("margin=\"0\"")),
  s("m1", t("margin=\"8px\"")),
  s("m2", t("margin=\"16px\"")),
  s("m3", t("margin=\"24px\"")),
  s("m4", t("margin=\"32px\"")),
  s("mauto", t("margin=\"auto\"")),
  s("mx0", t("marginX=\"0\"")),
  s("mx1", t("marginX=\"8px\"")),
  s("mx2", t("marginX=\"16px\"")),
  s("mxauto", t("marginX=\"auto\"")),
  s("my0", t("marginY=\"0\"")),
  s("my1", t("marginY=\"8px\"")),
  s("my2", t("marginY=\"16px\"")),
  s("mt0", t("marginTop=\"0\"")),
  s("mt1", t("marginTop=\"8px\"")),
  s("mt2", t("marginTop=\"16px\"")),
  s("mb0", t("marginBottom=\"0\"")),
  s("mb1", t("marginBottom=\"8px\"")),
  s("mb2", t("marginBottom=\"16px\"")),
  s("ml0", t("marginLeft=\"0\"")),
  s("ml1", t("marginLeft=\"8px\"")),
  s("ml2", t("marginLeft=\"16px\"")),
  s("mr0", t("marginRight=\"0\"")),
  s("mr1", t("marginRight=\"8px\"")),
  s("mr2", t("marginRight=\"16px\"")),
  
  -- Padding utilities
  s("mp0", t("padding=\"0\"")),
  s("mp1", t("padding=\"8px\"")),
  s("mp2", t("padding=\"16px\"")),
  s("mp3", t("padding=\"24px\"")),
  s("mp4", t("padding=\"32px\"")),
  s("mpx0", t("paddingX=\"0\"")),
  s("mpx1", t("paddingX=\"8px\"")),
  s("mpx2", t("paddingX=\"16px\"")),
  s("mpy0", t("paddingY=\"0\"")),
  s("mpy1", t("paddingY=\"8px\"")),
  s("mpy2", t("paddingY=\"16px\"")),
  s("mpt0", t("paddingTop=\"0\"")),
  s("mpt1", t("paddingTop=\"8px\"")),
  s("mpt2", t("paddingTop=\"16px\"")),
  s("mpb0", t("paddingBottom=\"0\"")),
  s("mpb1", t("paddingBottom=\"8px\"")),
  s("mpb2", t("paddingBottom=\"16px\"")),
  s("mpl0", t("paddingLeft=\"0\"")),
  s("mpl1", t("paddingLeft=\"8px\"")),
  s("mpl2", t("paddingLeft=\"16px\"")),
  s("mpr0", t("paddingRight=\"0\"")),
  s("mpr1", t("paddingRight=\"8px\"")),
  s("mpr2", t("paddingRight=\"16px\"")),
  
  -- Text utilities
  s("mtextcenter", t("textAlign=\"center\"")),
  s("mtextleft", t("textAlign=\"left\"")),
  s("mtextright", t("textAlign=\"right\"")),
  s("mtextjustify", t("textAlign=\"justify\"")),
  s("muppercase", t("textTransform=\"uppercase\"")),
  s("mlowercase", t("textTransform=\"lowercase\"")),
  s("mcapitalize", t("textTransform=\"capitalize\"")),
  
  -- Font weight utilities
  s("mfontbold", t("fontWeight=\"bold\"")),
  s("mfontnormal", t("fontWeight=\"normal\"")),
  s("mfont100", t("fontWeight={100}")),
  s("mfont200", t("fontWeight={200}")),
  s("mfont300", t("fontWeight={300}")),
  s("mfont400", t("fontWeight={400}")),
  s("mfont500", t("fontWeight={500}")),
  s("mfont600", t("fontWeight={600}")),
  s("mfont700", t("fontWeight={700}")),
  s("mfont800", t("fontWeight={800}")),
  s("mfont900", t("fontWeight={900}")),
  
  -- Border utilities
  s("mrounded", t("borderRadius=\"4px\"")),
  s("mroundedsm", t("borderRadius={2}")),
  s("mroundedmd", t("borderRadius={3}")),
  s("mroundedlg", t("borderRadius={4}")),
  s("mroundedxl", t("borderRadius=\"12px\"")),
  s("mrounded2xl", t("borderRadius=\"16px\"")),
  s("mroundedfull", t("borderRadius=\"50%\"")),
  s("mroundednone", t("borderRadius=\"0\"")),
  s("mborder", t("border=\"1px solid\"")),
  s("mborder0", t("border=\"none\"")),
  s("mbordert", t("borderTop=\"1px solid\"")),
  s("mborderb", t("borderBottom=\"1px solid\"")),
  s("mborderl", t("borderLeft=\"1px solid\"")),
  s("mborderr", t("borderRight=\"1px solid\"")),
  
  -- Background utilities
  s("mbgtransparent", t("backgroundColor=\"transparent\"")),
  
  -- Cursor utilities
  s("mpointer", t("cursor=\"pointer\"")),
  s("mnotallowed", t("cursor=\"not-allowed\"")),
  s("mdefault", t("cursor=\"default\"")),
  
  -- User select utilities
  s("mselectnone", t("userSelect=\"none\"")),
  s("mselectall", t("userSelect=\"all\"")),
  s("mselectauto", t("userSelect=\"auto\"")),
  
  -- Pointer events utilities
  s("mpointerevents", t("pointerEvents=\"auto\"")),
  s("mpointereventsn", t("pointerEvents=\"none\"")),
  
  -- Z-index utilities
  s("mz0", t("zIndex=\"0\"")),
  s("mz10", t("zIndex=\"10\"")),
  s("mz20", t("zIndex=\"20\"")),
  s("mz30", t("zIndex=\"30\"")),
  s("mz40", t("zIndex=\"40\"")),
  s("mz50", t("zIndex=\"50\"")),
  s("mzauto", t("zIndex=\"auto\"")),
  
  -- Opacity utilities
  s("mopacity0", t("opacity=\"0\"")),
  s("mopacity25", t("opacity=\"0.25\"")),
  s("mopacity50", t("opacity=\"0.5\"")),
  s("mopacity75", t("opacity=\"0.75\"")),
  s("mopacity100", t("opacity=\"1\"")),
  
  -- Shadow utilities
  s("mshadow", t("boxShadow=\"0 1px 3px rgba(0,0,0,0.12)\"")),
  s("mshadowsm", t("boxShadow=\"0 1px 2px rgba(0,0,0,0.05)\"")),
  s("mshadowmd", t("boxShadow=\"0 4px 6px rgba(0,0,0,0.07)\"")),
  s("mshadowlg", t("boxShadow=\"0 10px 15px rgba(0,0,0,0.1)\"")),
  s("mshadownone", t("boxShadow=\"none\"")),
  
  -- Transform utilities
  s("mrotate45", t("transform=\"rotate(45deg)\"")),
  s("mrotate90", t("transform=\"rotate(90deg)\"")),
  s("mrotate180", t("transform=\"rotate(180deg)\"")),
  s("mscale0", t("transform=\"scale(0)\"")),
  s("mscale50", t("transform=\"scale(0.5)\"")),
  s("mscale75", t("transform=\"scale(0.75)\"")),
  s("mscale100", t("transform=\"scale(1)\"")),
  s("mscale110", t("transform=\"scale(1.1)\"")),
  s("mscale125", t("transform=\"scale(1.25)\"")),
  
  -- Transition utilities
  s("mtransition", t("transition=\"all 0.2s\"")),
  s("mtransitionnone", t("transition=\"none\"")),
  s("mtransitionfast", t("transition=\"all 0.1s\"")),
  s("mtransitionslow", t("transition=\"all 0.5s\"")),
  
  -- Gap utilities
  s("mgap0", t("gap={0}")),
  s("mgap1", t("gap={1}")),
  s("mgap2", t("gap={2}")),
  s("mgap3", t("gap={3}")),
  s("mgap4", t("gap={4}")),
  
  -- Debug utilities
  s("xborder", t("border=\"1px solid red\"")),
})
