zeek_add_plugin(
    Zeek PE
    SOURCES PE.cc Plugin.cc
    BIFS events.bif
    PAC pe.pac pe-analyzer.pac pe-file-headers.pac pe-file-idata.pac pe-file.pac pe-file-types.pac)
