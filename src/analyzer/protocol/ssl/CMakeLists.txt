if (NOT ENABLE_SPICY_SSL)
    zeek_add_plugin(
        Zeek SSL
        SOURCES SSL.cc DTLS.cc Plugin.cc
        BIFS types.bif events.bif functions.bif consts.bif
        PAC tls-handshake.pac tls-handshake-protocol.pac tls-handshake-analyzer.pac ssl-defs.pac
            proc-certificate.pac tls-handshake-signed_certificate_timestamp.pac
        PAC ssl.pac
            ssl-dtls-analyzer.pac
            ssl-analyzer.pac
            ssl-dtls-protocol.pac
            ssl-protocol.pac
            ssl-defs.pac
            proc-certificate.pac
        PAC dtls.pac ssl-dtls-analyzer.pac dtls-analyzer.pac ssl-dtls-protocol.pac
            dtls-protocol.pac ssl-defs.pac)
else ()
    add_subdirectory(spicy)
    zeek_add_plugin(Zeek SSL SOURCES Plugin.cc BIFS functions.bif)
endif ()
