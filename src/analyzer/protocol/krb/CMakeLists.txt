zeek_add_plugin(
    Zeek KRB
    SOURCES Plugin.cc KRB.cc KRB_TCP.cc
    BIFS types.bif events.bif
    PAC krb.pac
        krb-protocol.pac
        krb-analyzer.pac
        krb-asn1.pac
        krb-defs.pac
        krb-types.pac
        krb-padata.pac
        ${PROJECT_SOURCE_DIR}/src/analyzer/protocol/asn1/asn1.pac
    PAC krb_TCP.pac
        krb-protocol.pac
        krb-analyzer.pac
        krb-asn1.pac
        krb-defs.pac
        krb-types.pac
        krb-padata.pac
        ${PROJECT_SOURCE_DIR}/src/analyzer/protocol/asn1/asn1.pac)
