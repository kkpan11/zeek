zeek_add_plugin(
    Zeek NCP
    SOURCES NCP.cc Plugin.cc
    BIFS events.bif consts.bif
    PAC ncp.pac)
