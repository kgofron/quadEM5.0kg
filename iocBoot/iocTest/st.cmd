#!/epics/support/quadEM/bin/linux-x86_64/quadEMTestApp

errlogInit(5000)
< unique.cmd
# < envPaths

#epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
#epicsEnvSet("EPICS_CA_ADDR_LIST", "10.10.0.255")

# Tell EPICS all about the record types, device-support modules, drivers,
# etc. in this build
#dbLoadDatabase("../../dbd/quadEMTestApp.dbd")
dbLoadDatabase("$(QUADEM)/dbd/quadEMTestApp.dbd")
quadEMTestApp_registerRecordDeviceDriver(pdbbase)

#epicsEnvSet("PREFIX",    "XF:10IDA-BI:")
##epicsEnvSet("PREFIX",    "quadEMTest:")
#epicsEnvSet("RECORD",    "AH501")
#epicsEnvSet("PORT",      "AH501")
#epicsEnvSet("TEMPLATE",  "AH501")
#epicsEnvSet("MODEL",     "AH501D")
#epicsEnvSet("QSIZE",     "20")
#epicsEnvSet("RING_SIZE", "10000")
#epicsEnvSet("TSPOINTS",  "1000")
#epicsEnvSet("IP",        "10.10.2.171:10001")
##epicsEnvSet("IP",        "164.54.160.240:10001")
< $(QUADEM)/iocBoot/iocTest/st.cmd.AHxxx

< $(QUADEM)/iocBoot/iocTest/saveRestore.cmd

iocInit()

# save settings every thirty seconds
create_monitor_set("auto_settings.req",30,"P=$(PREFIX), R=$(RECORD):, R_TS=$(RECORD)_TS:")

seq("quadEM_SNL", "P=$(PREFIX), R=$(RECORD)_TS:, NUM_CHANNELS=2048")
